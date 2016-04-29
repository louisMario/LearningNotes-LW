##ARC虽然能够解决大部分的内存泄露问题，但是仍然有些地方是我们需要注意的。(个人理解加找的资料，希望有补充的可以说一下)

---
####循环引用：
循环引用简单来说就是两个对象相互强引用了对方，即retain了对方，从而导致谁也释放不了谁的内存泄露问题。比如声明一个delegate时一般用weak而不能用retain或strong，因为你一旦那么做了，很大可能引起循环引用。
这种简单的循环引用只要在coding的过程中多加注意，一般都可以发现。
解决的办法也很简单，一般是将循环链中的一个强引用改为弱引用就可解决。
另外一种block引起的循环引用问题，通常是一些对block原理不太熟悉的开发者不太容易发现的问题。

___
###block引起的循环引用
我们先看看官方文档关于block调用时的解释：Object and Block Variables
```
When a block is copied, it creates strong references to object variables used within the block. If you use a block within the implementation of a method:

If you access an instance variable by reference, a strong reference is made to self;
If you access an instance variable by value, a strong reference is made to the variable.
当一Block块复制的时候,它会创建强引用的Block块内使用对象的引用变量。如果你使用一个Block内的实现方法:
如果你访问实例变量通过引用,一个强大的指的是自我;
如果你访问实例变量的值,一个强引用的变量。

```
主要有两条规则：
第一条规则，如果在block中访问了属性，那么block就会retain住self。
第二条规则，如果在block中访问了一个局部变量，那么block就会对该变量有一个强引用，即retain该局部变量。

根据这两条规则，我们可以知道发生循环引用的情况：
```
//规则1
self.myblock = ^{
    [self doSomething];           // 访问成员方法
    NSLog(@"%@", weakSelf.str);   // 访问属性
};

//规则2
ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
[request setCompletionBlock:^{
  NSString* string = [request responseString];
}];
对象对block拥有一个强引用，而block内部又对外部对象有一个强引用，形成了闭环，发生内存泄露。
```
怎么解决这种内存泄露呢？
可以用block变量来解决，首先还是看看官方文档怎么说的:
```
Use Lifetime Qualifiers to Avoid Strong Reference Cycles

In manual reference counting mode, __block id x; has the effect of not retaining x. In ARC mode, __block id x; defaults to retaining x (just like all other values). To get the manual reference counting mode behavior under ARC, you could use __unsafe_unretained __block id x;. As the name __unsafe_unretained implies, however, having a non-retained variable is dangerous (because it can dangle) and is therefore discouraged. Two better options are to either use __weak (if you don’t need to support iOS 4 or OS X v10.6), or set the __block value to nil to break the retain cycle.

使用生命周期限定符来避免强引用周期在手动引用计数模式下,__block id x,x的影响没有保留。在ARC模式下,__block id x;默认保留x(就像其他值)。把手册引用计数ARC下的行为模式,您可以使用__unsafe_unretained __block id x;。正如__unsafe_unretained名称所暗示的,然而,是一个非保留变量是危险的(因为它可以摇摆),因此气馁。两个更好的选择是,要么使用__weak(如果您不需要支持iOS 4或OS X v10.6),或一组__block值为nil打破保留周期。
```
官网提供了几种方案，我们看看第一种，用__block变量：

在MRC中，__block id x不会retain住x；但是在ARC中，默认是retain住x的，我们需要
使用__unsafe_unretained __block id x来达到弱引用的效果。现在使用的更多是__weak.

那么解决方案就如下所示：

```
__block id weakSelf = self;  //MRC
//__unsafe_unretained __block id weakSelf = self;   ARC下面用这个
self.myblock = ^{
    [weakSelf doSomething];  
    NSLog(@"%@", weakSelf.str);  
};
```
___
###performSelector的问题 
[self performSelector:@selector(foo:) withObject:self.property afterDelay:3]; performSelector延时调用的原理是这样的,执行上面这段函数的时候系统会自动将self.property的`retainCount`加1，直到selector执行完毕之后才会将self.property的`retainCount`减1。这样子如果selector一直未执行的话，self就一直不能够被释放掉，就有可能照成内存泄露。比较好的解决方案是将未执行的perform给取消掉: [NSObject cancelPreviousPerformRequestsWithTarget:self]; 因这种原因产生的泄露因为并不违反任何规则，是Intrument所无法发现的。

___
###NSTimer的问题
我们都知道timer用来在未来的某个时刻执行一次或者多次我们指定的方法，那么问题来了（当然不是挖掘机）。究竟系统是怎么保证timer触发action的时候，我们指定的方法是有效的呢？万一receiver无效了呢？

答案很简单，系统会自动retain住其接收者，直到其执行我们指定的方法。
看看官方的文档吧，也建议你自己写个demo测试一下。
```
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds target:(id)target selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeats
target  
The object to which to send the message specified by aSelector when the timer fires. The timer maintains a strong reference to target until it (the timer) is invalidated. (系统会维护一个强引用直到timer调用invalidated)

userInfo  
The user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter may be nil.

repeats 
If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
```
可以注意到repeats参数，一次性（repeats为NO）的timer会再触发后自动调用invalidated，而重复性的timer则不会。
现在问题又来了，看看下面这段代码:
```
- (void)dealloc
{
    [timer invalidate];
    [super dealloc];
}
```
这个是很容易犯的错误，如果这个timer是个重复性的timer，那么self对象就会被timerretain住，这个时候不调用invalidate的话，self对象的引用计数会大于1，dealloc永远不会调用到，这样内存泄露就会发生。

timer都会对它的target进行retain，我们需要小心对待这个target的生命周期问题，尤其是重复性的timer，同时需要注意在dealloc之前调用invalidate。
关于timer其实有挺多可以研究的，比如其必须在runloop中才有效，比如其时间一定是准的吗？这些由于和本章主题不相关，暂时就不说了。

关于performSelector:afterDelay的问题
```
- (void)performSelector:(SEL)aSelector withObject:(id)anArgument afterDelay:(NSTimeInterval)delay
```
我们还是看看官方文档怎么说的，同样也希望大家能写个demo验证下。
```
This method sets up a timer to perform the aSelector message on the current thread’s run loop.
The timer is configured to run in the default mode (NSDefaultRunLoopMode).
When the timer fires, the thread attempts to dequeue the message from the run loop and perform the selector.
It succeeds if the run loop is running and in the default mode; otherwise, the timer waits until the run loop is in the default mode.
```
大概意思是系统依靠一个timer来保证延时触发，但是只有在runloop在default mode的时候才会执行成功，否则selector会一直等待run loop切换到default mode。
根据我们之前关于timer的说法，在这里其实调用performSelector:afterDelay:同样会造成系统对target强引用，也即retain住。这样子，如果selector一直无法执行的话（比如runloop不是运行在default model下）,这样子同样会造成target一直无法被释放掉，发生内存泄露。
怎么解决这个问题呢？
其实很简单，我们在适当的时候取消掉该调用就行了，系统提供了接口:

+ (void)cancelPreviousPerformRequestsWithTarget:(id)aTarget
这个函数可以在dealloc中调用吗，大家可以自己思考下？
关于NSNotification的addObserver与removeObserver问题
我们应该会注意到我们常常会再dealloc里面调用removeObserver,会不会上面的问题呢？
答案是否定的，这是因为addObserver只会建立一个弱引用到接收者，所以不会发生内存泄露的问题。但是我们需要在dealloc里面调用removeObserver，避免通知的时候，对象已经被销毁，这时候会发生crash.

___
###C 语言的接口
C 语言不能够调用OC中的retain与release，一般的C 语言接口都提供了release函数（比如CGContextRelease(context c)）来管理内存。ARC不会自动调用这些C接口的函数，所以这还是需要我们自己来进行管理的.

下面是一段常见的绘制代码，其中就需要自己调用release接口。
```
CGContextRef context = CGBitmapContextCreate(NULL, target_w, target_h, 8, 0, rgb, bmi);

    CGColorSpaceRelease(rgb);

    UIImage *pdfImage = nil;
    if (context != NULL) {
        CGContextDrawPDFPage(context, page);

        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        CGContextRelease(context);

        pdfImage = [UIImage imageWithCGImage:imageRef scale:screenScale orientation:UIImageOrientationUp];
        CGImageRelease(imageRef);
    } else {
       CGContextRelease(context);
    }
```
总的来说，ARC还是很好用的，能够帮助你解决大部分的内存泄露问题。所以还是推荐大家直接使用ARC，尽量不要使用mrc。