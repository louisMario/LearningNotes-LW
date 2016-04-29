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
//#import "LWBadegView.h"
#define LWImageRidio 0.7
@interface LWTabBarButton()



@end
@implementation LWTabBarButton
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:0];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        //图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return self;
}
- (void)setItems:(UITabBarItem *)items{
    _items = items;
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    //KVO
[items addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
[items addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
[items addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
//[items addObserver:self forKeyPath:@"badegValue" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    [self setTitle:_items.title forState:UIControlStateNormal];
    
    [self setImage:_items.image forState:UIControlStateNormal];
    
    [self setImage:_items.selectedImage forState:UIControlStateHighlighted];
    
#warning 后面补充badeg的。
    
}

// 修改按钮内部子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * LWImageRidio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    // 2.title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
}
@end
