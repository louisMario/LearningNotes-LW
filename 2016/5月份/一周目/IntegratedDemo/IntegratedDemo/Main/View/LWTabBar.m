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

#import "LWTabBar.h"
#import "LWTabBarButton.h"
@interface LWTabBar()
@property(nonatomic,weak)UIButton * selectedButton;
@property(nonatomic,weak)UIButton * plusButton;
@property(nonatomic,strong)NSMutableArray* AllButtons;
@end
@implementation LWTabBar
static LWTabBar *_oneTab;
+(instancetype)shareOneTab
{
    if (_oneTab == nil) {
        _oneTab = [[LWTabBar alloc]init];
    }
    return _oneTab;
}
- (NSMutableArray *)AllButtons {
    if(_AllButtons == nil) {
        _AllButtons = [NSMutableArray array];
    }
    return _AllButtons;
}

//接收从控制传过来的items
-(void)setItems:(NSArray *)items
{
    _items = items;
    for (UITabBarItem *item in _items) {
        LWTabBarButton *button = [LWTabBarButton buttonWithType:UIButtonTypeCustom];
        //再把拆解出来的item传到button类去处理。
        button.items = item;
        button.tag = self.AllButtons.count;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        // 判断是否是第一个button
        if (button.tag == 0) {
            [self btnClick:button];
            //是的话就默认点击
        }
        [self addSubview:button];
        //把每个处理好的button调回来加入到数组中
        [self.AllButtons addObject:button];
    }
}
//点击button后调用
-(void)btnClick:(UIButton *)btn
{   //让button的点击按钮根据用户的点击而改变
    _selectedButton.selected = NO;
    btn.selected = YES;
    _selectedButton = btn;
    //判断代理是否响应了方法，如果响应了，便把btn的tag传给控制器方便控制器处理跳转到哪个界面上
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:btn.tag];
    }
}
//自定按钮的设置
- (UIButton *)plusButton {
	if(_plusButton == nil) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"Imported Layers"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"Imported Layers"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Imported LayersSE"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"Imported LayersSE"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        
        _plusButton = btn;
        
        [self addSubview:_plusButton];

    }
	return _plusButton;
}
-(void)layoutSubviews
{
//    [super layoutSubviews];
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w/(self.AllButtons.count+1);
    CGFloat btnH = h;
    int i = 0;
    for (UIView *tabBarButton in self.AllButtons) {
        if (i == 1) {
            i = 2;
        }
        btnX = btnW*i;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i ++;
    }
    self.plusButton.center = CGPointMake(w*0.5,h*0.5 );
}

@end
