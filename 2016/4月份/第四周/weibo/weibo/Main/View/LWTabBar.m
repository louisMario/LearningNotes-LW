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
@property(nonatomic,strong)NSMutableArray *buttons;
@property(nonatomic,weak)UIButton * plusButton;
@end
@implementation LWTabBar
- (NSMutableArray *)buttons {
    if(_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
-(void)setItems:(NSArray *)items{
    _items = items;
    
    for (UITabBarItem *item in _items) {
        LWTabBarButton *btn = [LWTabBarButton buttonWithType:UIButtonTypeCustom];
        btn.items = item;
        btn.tag = self.buttons.count;


     [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (btn.tag == 0) {
            [self btnClick:btn];
            
        }
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
}
//点击Button调用
- (void)btnClick:(UIButton *)btn{
    _selectedButton.selected = NO;
    btn.selected = YES;
    _selectedButton = btn;
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:btn.tag];
    }
    
}
-(UIButton *)plusButton{
    if (_plusButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        // 默认按钮的尺寸跟背景图片一样大
        // sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
        [btn sizeToFit];
        _plusButton = btn;
        [self addSubview:_plusButton];
    }
    return _plusButton;
}
-(void)layoutSubviews
{
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnx = 0;
    CGFloat btny = 0;
    CGFloat btnw = w/(self.buttons.count+1);
    CGFloat btnh = h;

    int i = 0;
    for (UIView *tabBarButton in self.buttons) {
        if (i == 2) {
            i = 3;
        }
        btnx = btnw*i;
        tabBarButton.frame = CGRectMake(btnx, btny, btnw, btnh);
        i ++;
    }
    self.plusButton.center = CGPointMake(w*0.5, h*0.5);
}



@end
