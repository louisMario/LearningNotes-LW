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

#import "LWTabBarController.h"
#import "UIImage+LWimage.h"
#import "LWTabBar.h"
#import "UIBarButtonItem+Item.h"
#import "LWHomeViewController.h"
#import "LWNavigationController.h"
@interface LWTabBarController ()<LWTabBarDelegate>
@property(nonatomic,strong)NSMutableArray * items;
@end

@implementation LWTabBarController
- (NSMutableArray *)items {
    if(_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildViewController];
    [self setUpTabBar];

}
//设置自定义tabbar
-(void)setUpTabBar{
    LWTabBar *tabBar = [[LWTabBar alloc]initWithFrame:self.tabBar.frame];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.items = self.items;
    tabBar.delegate = self;
    
    [self.view addSubview:tabBar];
    
    //移除系统版本的tabbar，不移除的话无法自定义tabbarbutton里面的badeg3view
    [self.tabBar removeFromSuperview];
}

-(void)tabBar:(LWTabBar *)tabBar didClickButton:(NSInteger)index{
    self.selectedIndex = index;
}
//设置每个界面
-(void)setUpAllChildViewController
{
    LWHomeViewController *home = [[LWHomeViewController alloc]init];
    [self setUpOneViewChildViewController:home andImage:[UIImage imageNamed:@"tabbar_home"] andSelectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] andTitle:@"首页"];
    
    
    UIViewController *message = [[UIViewController alloc]init];
    [self setUpOneViewChildViewController:message andImage:[UIImage imageNamed:@"tabbar_message_center"] andSelectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] andTitle:@"消息"];
    
    UIViewController *discover = [[UIViewController alloc]init];
    [self setUpOneViewChildViewController:discover  andImage:[UIImage imageNamed:@"tabbar_discover"] andSelectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] andTitle:@"发现"];

    UIViewController *profile = [[UIViewController alloc]init];
    [self setUpOneViewChildViewController:profile andImage:[UIImage imageNamed:@"tabbar_profile"] andSelectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] andTitle:@"我"];
    
}
//每个子界面显示的东西
-(void)setUpOneViewChildViewController:(UIViewController *)vc  andImage:(UIImage *)image andSelectedImage:(UIImage*)SEimage andTitle: (NSString *)title
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = SEimage;
    [self.items addObject:vc.tabBarItem];
    LWNavigationController *nav = [[LWNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
