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
#import "UIImage+LWImage.h"
#import "LWTabBar.h"
#import "LWLeftTableViewController.h"
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpAllChildViewController];
    [self setUpTabBar];
}
-(void)setUpTabBar
{     LWTabBar *tabBar = [LWTabBar shareOneTab];
    tabBar.frame = self.tabBar.frame;
    tabBar.backgroundColor = [UIColor whiteColor];
    
    tabBar.items = self.items;
    
    [self.view addSubview:tabBar];
    // 移除系统的tabBar
    [self.tabBar removeFromSuperview];
    
}
-(void)tabBar:(LWTabBar *)tabBar didClickButton:(NSInteger)index{
    self.selectedIndex = index;
}
-(void)setUpAllChildViewController
{
    LWLeftTableViewController *first =  [[LWLeftTableViewController alloc]init];
    [self setOneChildViewController:first andImage:[UIImage imageNamed:@"icon bars alt"] andSelectedImage:[UIImage imageWithOriginalName:@"icon bars altSE"] andtitle:@"TableView"];
    UIViewController  *second = [[UIViewController alloc]init];
    [self setOneChildViewController:second andImage:[UIImage imageNamed:@"icon company"] andSelectedImage:[UIImage imageWithOriginalName:@"icon companySE"] andtitle:@"ConllectionView"];
}
-(void)setOneChildViewController:(UIViewController *)controller andImage:(UIImage*)image andSelectedImage:(UIImage *)selectedImage andtitle:(NSString *)title
{
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = image;
    controller.tabBarItem.selectedImage = selectedImage;
    [self.items addObject:controller.tabBarItem];
    
    LWNavigationController  *nav= [[LWNavigationController alloc] initWithRootViewController:controller];
    
    [self addChildViewController:nav];
}


@end
