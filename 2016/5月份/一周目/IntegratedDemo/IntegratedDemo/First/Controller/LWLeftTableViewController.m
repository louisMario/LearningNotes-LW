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

#import "LWLeftTableViewController.h"
#import "LWFriendGroup.h"
#import "LWFirends.h"
#import "LWTabSectionHeaderView.h"
#import "LWChatViewController.h"
@interface LWLeftTableViewController ()<LWTabSectionHeaderViewDelegate>
@property(nonatomic,strong)NSArray * firendsData;
@end

@implementation LWLeftTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tableview";
    self.tableView.sectionHeaderHeight = 40;
    [self loadData];
}
//加载数据
-(void)loadData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"friends.plist" ofType:nil];
    NSArray *Bfriends = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *MuArr = [NSMutableArray array];
    for (NSDictionary *dic in Bfriends)
    {
        LWFriendGroup *friendGroup = [[LWFriendGroup alloc]initWithDict:dic];
        [MuArr addObject:friendGroup];
    }
    self.firendsData  = [MuArr copy];
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.firendsData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LWFriendGroup *friend = self.firendsData[section];
    NSInteger count = friend.isOpen? friend.friends.count : 0;
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    LWFriendGroup *friendGroup = self.firendsData[indexPath.section];
    LWFirends *friend = friendGroup.friends[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:friend.icon];
    cell.textLabel.textColor = friend.isVip ? [UIColor redColor] : [UIColor lightGrayColor];
    cell.textLabel.text = friend.name;
    cell.detailTextLabel.text = friend.intro;
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LWTabSectionHeaderView *headView = [LWTabSectionHeaderView headViewWithTableView:tableView];
    headView.delegate = self;
    headView.FriendGroup = _firendsData[section];
    return headView;
}
//协议中的方法   点击后刷新section下的内容
- (void)clickHeadView
{
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWChatViewController *chatViewController = [[LWChatViewController alloc]init];
//    [chatViewController setHidesBottomBarWhenPushed:YES];

    [self.navigationController pushViewController:chatViewController animated:YES];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
