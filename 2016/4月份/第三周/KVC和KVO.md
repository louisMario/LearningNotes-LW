#KVC和KVO实际操作

---
###键值编码KVC
KVC的操作方法由NSKeyValueCoding协议提供，而NSObject就实现了这个协议，也就是说ObjC中几乎所有的对象都支持KVC操作，它是一种可以直接通过字符串的名字(key)来访问类属性(实例变量)的机制。而不是通过调用Setter、Getter方法访问。常用的KVC操作方法如下：
* 动态设置
 setValue:属性值 forKey:属性名（用于简单路径）//跟点语法是一个道理。
 setValue:属性值 forKeyPath:属性路径（用于复合路径，例如Person有一个Account类型的属性，那么person.account就是一个复合属性）
* 动态读取
 valueForKey:属性名
 valueForKeyPath:属性名(用于复合路径）

---
以上是比较基础的方法，不解释，另外几个方法下面上代码：

## 实际开发中的应用：
* 解析plist文件或者JSON
对于初学者来说可能比较头疼这一块，但是恰巧这块是最为重要的，在实际工作中，你会经常需要用到KVC的方式去解析plist文件或者JSON，或许你会说用SBJSON库啊，YYModel框架啊。是！确实现在第三方库做的非常好，但是只会用别人写的代码，自己又不懂实现原理，那我只能说你迟早会变成SB的，放心。
```
其实原理很简单：
使用 setValuesForKeysWithDictionary:这个方法就可以
其实更多的是在于解析过程不懂设置，其实这块本不该放在KVC来讲，因为涉及到的知识也就是mvc，封装等等、
```

     ###在这里教小伙伴一个原则：遇到字典就转模型
比如我有这么个模型类：
![城市.plist](http://upload-images.jianshu.io/upload_images/1436895-174d54b53d54808e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

遇到字典转模型类，所以你会发现我左边对应的文件里面有allGroups和regions俩个模型类，第一个对应的便是大数组Root Array，第二遍对应的是每个item里面的regions数组，因为他下面就是字典。

剩下的解析方式就不做过多介绍，下面直接上代码，不懂可以留言问我，主要针对其他小错误的地方给大家再介绍一下。
![allGroups.h的声明](http://upload-images.jianshu.io/upload_images/1436895-df52cafb59c4b064.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

接下来这部分是重点：

![allGroups.m](http://upload-images.jianshu.io/upload_images/1436895-0e5054b3b616dfd1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![重写原则](http://upload-images.jianshu.io/upload_images/1436895-d766af7d2a18a0d0.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
首先上面是普通的setValuesForKeysWithDictionary,设置了个循环，没什么好讲，下面的部分的话用到了一个方法setValue:(id)value forundefinedKey:(NSString *)key。这个方法用在当
* 传过来的字典中的值在模型类中找不到可以匹配的key时调用。
我们可以在这个方法中去修改或者直接赋值完成我们想要实现的效果。
#####包括最常见的就是字典中的key和我们模型类的key相互冲突了，我们可以直接给他赋值跳过这个value。
---
以上是字典转模型，如果你懂得的话相信转json也是so easy的。
同样道理，模型转字典的情况在开发中也是会有的，只是非常少而已，比如：老板叫我把在网上获取的json数据转为plist文件存到本地。那你可以调用dictionaryWithValuesForKeys来完成这个需求。
例如：
```
- (NSDictionary *)dictionaryWithValuesForKeys:(NSArray *)keys;
 
//实例:
NSDictionary *dic = [self.dataArray dictionaryWithValuesForKeys:@[@"name",@"age"]];
for (int i =0 ; i<dic.count; i++) {
    NSLog(@"%@", [dic objectForKey:[dic allKeys][i]]);
}
```
---
###KVO观察者模式
KVO其实是一种观察者模式，利用它可以很容易实现视图组件和数据模型的分离，当数据模型的属性值改变之后作为监听器的视图组件就会被激发，激发时就会回调监听器自身。
在ObjC中要实现KVO则必须实现NSKeyValueObServing协议，不过幸运的是NSObject已经实现了该协议，因此几乎所有的ObjC对象都可以使用KVO。

---
* KVO实现原理：
当你观察一个对象时，一个新的类会动态被创建。这个类继承自该对象的原本的类，并重写了被观察属性的 setter 方法。自然，重写的 setter 方法会负责在调用原 setter 方法之前和之后，通知所有观察对象值的更改。最后把这个对象的 isa 指针 ( isa 指针告诉 Runtime 系统这个对象的类是什么 ) 指向这个新创建的子类，对象就神奇的变成了新创建的子类的实例。
原来，这个中间类，继承自原本的那个类。不仅如此，Apple 还重写了 -class 方法，企图欺骗我们这个类没有变，就是原本那个类。更具体的信息，去跑一下 Mike Ash 的那篇文章里的代码就能明白，这里就不再重复。

---
* 在ObjC中使用KVO操作常用的方法如下：
注册指定Key路径的监听器： addObserver: forKeyPath: options: context:
删除指定Key路径的监听器： removeObserver: forKeyPath
removeObserver: forKeyPath: context:
回调监听 observeValueForKeyPath: ofObject: change: context:

---
* KVO的使用步骤也比较简单：通过addObserver: forKeyPath: options: context:为被监听对象（它通常是数据模型）注册监听器重写监听器的observeValueForKeyPath: ofObject: change: context:方法

---
* KVO的使用可以分为两步
```
1.注册观察者
2.在回调方法中监听被观察者属性的变化
```

1.注册观察者
```
//第一个参数observer：观察者 （这里观察self.view对象的属性的变化）
//第二个参数keyPath：被观察的属性名称(这里观察self.view背景颜色的改变)
//第三个参数options：观察属性的新值、旧值等的一些配置（枚举值，这里用来监听改变时的新值）
//第四个参数context：上下文，可以为kvo的回调方法传值
//注册观察者
[self.view addObserver:self forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
```
方便直观理解，上图：
![只要你调用它的set方法他就会调用](http://upload-images.jianshu.io/upload_images/1436895-6be1aceb407bf2d2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
在回调方法中监听被观察者属性的变化（当self.view的backgroundColor在某处发生改变则会自动调用该方法）
```
//参数解释
//keyPath:属性名称
//object:被观察的对象
//change:变化前后的值都存储在change字典中（因为上面布置观察新值）
//context:注册观察者时，context传过来的值-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{ if([keyPath isEqualToString:@"backgroundColor"])
{//View的背景颜色发生了变化 //newColor为改变后的值  id newColor = [change objectForKey:NSKeyValueChangeNewKey] }}
```
继续上图：
![实现监听方法](http://upload-images.jianshu.io/upload_images/1436895-4b9be11b785b7905.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以上是所有内容，后期会继续补充案例，喜欢的可以关注一下，希望对小白有帮助。