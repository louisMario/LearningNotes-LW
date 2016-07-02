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

#import "LWChatViewController.h"
#import "LWSampleMessage.h"
#import "LWCellFrameModel.h"
#import "LWChatTableViewCell.h"
#import"LWTabBar.h"
#define backGroundColor [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0]
#define kToolBarH 44
#define kTextFieldH 30
@interface LWChatViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray * cellFrameDatas;
@property(nonatomic,strong)UITableView * chatView;
@property(nonatomic,strong)UIImageView * toolBar;
@property(nonatomic,strong)LWTabBar *tab;
@end

@implementation LWChatViewController
- (LWTabBar*)tab {
    if(_tab == nil) {
        _tab = [LWTabBar shareOneTab];
    }
    return _tab;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建通知监听键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil
     ];
    //加载数据
    [self loadData];
    //添加tableview
    [self addChatView];
    //添加工具栏
    [self addToolBar];
}
-(void)viewWillAppear:(BOOL)animated
{  [super viewWillAppear:YES];
    
    [self.tab setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{   [super viewWillDisappear:YES];
    [self.tab setHidden:NO];
}
-(void)loadData
{
    _cellFrameDatas = [NSMutableArray array];
    NSURL *dataUrl = [[NSBundle mainBundle]URLForResource:@"messages.plist" withExtension:nil];
    NSArray *dataArray = [NSArray arrayWithContentsOfURL:dataUrl];
    for (NSDictionary *dict in dataArray) {
        LWSampleMessage *message = [LWSampleMessage messageModelWithDict:dict];
        //拿出数据里面的最后一次数据
        LWCellFrameModel *lastFrame = [self.cellFrameDatas lastObject];
        LWCellFrameModel *cellFrame = [[LWCellFrameModel alloc]init];
        //判断模型类的时间和最新获取的数据的时间是否相等来决定是否展示时间label
        message.showTime = ![message.time isEqualToString:lastFrame.message.time];
        //更新新的数据保存
        cellFrame.message = message;
        [_cellFrameDatas addObject:cellFrame];
    }
}
-(void)addChatView
{
    self.view.backgroundColor = backGroundColor;
    UITableView *chatView = [[UITableView alloc]init];
    chatView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-kToolBarH);
    chatView.backgroundColor = backGroundColor;
    chatView.delegate = self;
    chatView.dataSource = self;
    chatView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //默认是YES。控制在编辑模式的时候是否行可以选择
    chatView.allowsSelection = NO;
    //添加手势
    [chatView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEdit)]];
    _chatView = chatView;
    [self.view addSubview:chatView];
}
-(void)addToolBar
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.frame = CGRectMake(0, self.view.frame.size.height - kToolBarH, self.view.frame.size.width, kToolBarH);
    bgView.image = [UIImage imageNamed:@"chat_bottom_bg"];
    //打开用户交互
    bgView.userInteractionEnabled = YES;
    _toolBar = bgView;
    [self.view addSubview:bgView];
    
    //语音按钮
    UIButton *sendSoundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendSoundBtn.frame = CGRectMake(0, 0, kToolBarH, kToolBarH);
    [sendSoundBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
    [sendSoundBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateSelected];
    [bgView addSubview:sendSoundBtn];
    
    //加号按钮
    UIButton *addMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addMoreBtn.frame = CGRectMake(self.view.frame.size.width - kToolBarH, 0, kToolBarH, kToolBarH);
    [addMoreBtn setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
    [addMoreBtn setImage:[UIImage imageNamed:@"chat_bottom_up_press"] forState:UIControlStateSelected];
    [bgView addSubview:addMoreBtn];
    
    //表情按钮
    UIButton *expressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    expressBtn.frame = CGRectMake(self.view.frame.size.width - kToolBarH * 2, 0, kToolBarH, kToolBarH);
    [expressBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
    [expressBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateSelected];
    [bgView addSubview:expressBtn];
    
    //输入框
    UITextField *textField = [[UITextField alloc] init];
    //设置返回键显示为发送
    textField.returnKeyType = UIReturnKeySend;
    //将自动禁用返回键当文本小部件长度为零的内容,并将自动启用当文本小部件内容不为0时的内容
    textField.enablesReturnKeyAutomatically = YES;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 1)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.frame = CGRectMake(kToolBarH, (kToolBarH - kTextFieldH) * 0.5, self.view.frame.size.width - 3 * kToolBarH, kTextFieldH);
    textField.background = [UIImage imageNamed:@"chat_bottom_textfield"];
    textField.delegate = self;
    [bgView addSubview:textField];

}
#pragma mark - tableview的数据源和代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellFrameDatas.count;
}
-(LWChatTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    LWChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LWChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.cellFrame = _cellFrameDatas[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWCellFrameModel *cellFrame = _cellFrameDatas[indexPath.row];
    return cellFrame.cellHeght;
}

#pragma mark - UItextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //获取时间
    NSDate *sendDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *locationString = [dateFormatter stringFromDate:sendDate];
    
    //创建一个MessageModel类
    LWSampleMessage *message = [[LWSampleMessage alloc]init];
    message.text = textField.text;
    message.time = locationString;
    message.type = 0;
    
    //创建一个CellFrameModel类
    LWCellFrameModel *cellFrame = [[LWCellFrameModel alloc]init];
    LWCellFrameModel *lastCellFrame = [_cellFrameDatas lastObject];
    message.showTime = ![lastCellFrame.message.time isEqualToString:message.time];
    cellFrame.message = message;
    
    //添加数据并刷新
    [_cellFrameDatas addObject:cellFrame];
    [_chatView reloadData];
    
    //刷新后滚到最后
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:_cellFrameDatas.count - 1 inSection:0];
    [_chatView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    //清空
    textField.text = @"";
    
    return YES;
}
- (void)endEdit
{
    [self.view endEditing:YES];
}
- (void)keyboardWillChange:(NSNotification *)note
{
    NSLog(@"%@", note.userInfo);
    NSDictionary *userInfo = note.userInfo;
    CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
}
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#warning bd
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self.view endEditing:YES];
//}












@end
