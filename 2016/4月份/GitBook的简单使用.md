#GitBook从看懂到看开

![GitBook](http://upload-images.jianshu.io/upload_images/1436895-615269927a549517.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

最近开始学习使用github，无意中了解到有gitbook这个东东，抱着忐忑的心情展开了一系列学习，结果发现网上并没有很直白的教程，这里简单分享一下GitBook的一些学习心得。
```
PS:浏览本文的时候，默认你已经学会github的一些使用。
```
 * GitBook是什么？
GitBook是一个基于 [Node.js](http://baike.baidu.com/view/3974030.htm) 的命令行工具，可使用 [Github](http://baike.baidu.com/view/3366456.htm)/[Git](http://baike.baidu.com/subview/1531489/12032478.htm) 和 [Markdown](http://baike.baidu.com/view/2311114.htm) 来制作精美的电子书，GitBook 并非关于 Git 的教程。
 * 为什么要用GitBook？
  确实，在这个各种编辑器和博客横飞的年代（比如简书），GitBook有什么优势呢？
GitBook支持输出多种文档格式：
```
·静态站点：GitBook默认输出该种格式，生成的静态站点可直接托管搭载Github Pages服务上；
·PDF：这个格式不用解释吧，相信大家都用过；
·ePub:（Electronic Publication的缩写，意为：电子出版），是一个自由的开放标准，属于一种可以“自动重新编排”的内容；也就是文字内容可以根据阅读设备的特性，以最适于阅读的方式显示。EPub档案内部使用了XHTML或DTBook （一种由DAISY Consortium提出的XML标准）来展现文字、并以zip压缩格式来包裹档案内容。EPub格式中包含了数位版权管理（DRM）相关功能可供选用。
·eBook:是利用互联网技术创造的全新网络出版方式，它将传统的书籍出版发行方式在计算机中实现，区别于传统的纸制媒介出版物。
·单HTML网页：支持将内容输出为单页的HTML，不过一般用在将电子书格式转换为PDF或eBook的中间过程；
·JSON：一般用于电子书的调试或元数据提取。
·Mobi:.MOBI域名是全球唯一专为手机及移动终端设备打造的域名，是为ICANN批准的全新国际顶级域名，其致力于将互联网信息传送到手机等移动设备上。它由爱立信、gSM协会、google、微软、诺基亚、三星电子、Syniverse科技、T-Mobile等全球顶级知名手机厂商和相关行业协会共同投资。
```
当然最最主要的还是支持多人同时开发文档，比如多人同时翻译一本书籍，这个功能可以大大增加工作效率。
 * GitBook的基本操作：
首先介绍网页上的操作：我是使用的github账号登录，也推荐大家使用这个登录，后面会体现出好处：
![登录界面](http://upload-images.jianshu.io/upload_images/1436895-b1111e00dbb07801.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
登录过后会看到下面的界面：

![首页MyBook](http://upload-images.jianshu.io/upload_images/1436895-7520636d7271a348.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


 * 接下来是重点：团队协作
    我们都知道在github上面如果要多人协作开发一个项目，有一个方法是创建一个organization，那么在GitBook也同样，可以创建一个organization。
![团队Member成员界面](http://upload-images.jianshu.io/upload_images/1436895-91295b16f1931d09.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

添加邀请过后，对方会收到邮件，需要对方同意的情况下才能参加进来。
 * 创建团队合作的项目：

![创建协同book](http://upload-images.jianshu.io/upload_images/1436895-93c1c6b8452d2c00.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
   
基本操作就这么多，其他的大家可以自己慢慢专研，主要注意点就是上图的红色字体，我也研究了好久这块，一开始gitbook总是提示：
![没有权利](http://upload-images.jianshu.io/upload_images/1436895-ae70e85fa07dd928.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

所以大家要记得创建项目的时候，先在github上面创建一个组织并开通一个项目，接着在GitBook上面创建的时候选择那个可以共同开发的项目来编写即可。

 * 编写格式
   GitBook的编写格式默认是Markdown编辑器来编写，相信经常使用简书的你并不陌生，在这里我就不做一一介绍。
 * 图形化客户端的操作
    GitBook 也跟github desktop一样，他有一个GitBook editor
![Mac下的客户端](http://upload-images.jianshu.io/upload_images/1436895-e8ef04f73340501b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
登录界面是一样的就不上图了，接下来是界面简单描述：

![登录之后的主页](http://upload-images.jianshu.io/upload_images/1436895-f2b2be95594d955c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![打开书本后的界面解释](http://upload-images.jianshu.io/upload_images/1436895-3664777a491864c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![Summary](http://upload-images.jianshu.io/upload_images/1436895-761ac4de5ba8b94d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![分支在界面上的显示效果](http://upload-images.jianshu.io/upload_images/1436895-b5d19724cc2ef724.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 
 *  你也可以在gitbook上面直接管理你github上面的项目文档，由于比较简单这里就不做介绍。（我的github上的文档都是用GitBook editor来编写的，挺方便）

以上是GitBook的一些简单使用，我也是初学者，后期如果有研究更深入的内容也会继续补充，希望对大家有所帮助。