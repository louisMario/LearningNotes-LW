/*
 *----------Dragon be here!----------*
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　　　　　┃
 * 　　┃　　　━　　　┃
 * 　　┃　┳┛　┗┳　┃
 * 　　┃　　　　　　　┃
 * 　　┃　　　┻　　　┃
 * 　　┃　　　　　　　┃
 * 　　┗━┓　　　┏━┛
 * 　　　　┃　　　┃神兽保佑
 * 　　　　┃　　　┃代码永无BUG！
 * 　　　　┃　　　┗━━━┓
 * 　　　　┃　　　　　　　┣┓
 * 　　　　┃　　　　　　　┏┛
 * 　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　┃┫┫　┃┫┫
 * 　　　　　┗┻┛　┗┻┛
 * ━━━━━━神兽出没━━━━━━━━━━━━*
 */

#import "LWTabBarButton.h"
#define LWImageRidio 0.7
@implementation LWTabBarButton
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font  = [UIFont systemFontOfSize:12];
        
    }
    return self;
}
//把从tabbar接收过来的items在当前这个button模型类赋值。
-(void)setItems:(UITabBarItem *)items
{   _items = items;
    //先清空一下
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];

    //监听模型中传过来的参数是否发生改变
    [items addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [items addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [items addObserver:self  forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    
}
//监听后的动作操作
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setTitle:_items.title forState:UIControlStateNormal];
    [self setImage:_items.image forState:UIControlStateNormal];
    [self setImage:_items.selectedImage forState:UIControlStateSelected];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //image
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * LWImageRidio;//让图片占据百分之70的高度就可以，留30给文字
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
}
@end
