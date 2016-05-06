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

#import "LWTabSectionHeaderView.h"
#import "LWFriendGroup.h"
#define  ViewZB (0.7 *self.frame.size.width)
@interface LWTabSectionHeaderView()
//整个sectionhead用button替换
@property(nonatomic,strong)UIButton * bgButton;
//好友在线数
@property(nonatomic,strong)UILabel * numLabel;

@end
@implementation LWTabSectionHeaderView
+(instancetype)headViewWithTableView:(UITableView *)tableview
{
    static NSString *headID = @"header";
//    用这行的话调用didMoveToSuperview这个方法的顺序不一样
//    LWTabSectionHeaderView *head = [tableview dequeueReusableHeaderFooterViewWithIdentifier:headID];
    LWTabSectionHeaderView *head = [tableview dequeueReusableCellWithIdentifier:headID];
    if (head == nil) {
        head = [[LWTabSectionHeaderView alloc]initWithReuseIdentifier:headID];
    }
    return head;
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeCenter;
        //下面这行的作用是让图片尺寸不变
        button.imageView.clipsToBounds = NO;
        //让按钮显示的东西在最左边
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让边距距离有十
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //文字距离按钮距离
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [button addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _bgButton = button;
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:numLabel];
        _numLabel = numLabel;
    }
    return self;
}
- (void)headBtnClick
{     NSLog(@"%s",__func__);

    _FriendGroup.opened = ! _FriendGroup.isOpen;

    if ([_delegate respondsToSelector:@selector(clickHeadView)]) {
        [_delegate clickHeadView];
    }
}
-(void)setFriendGroup:(LWFriendGroup *)FriendGroup
{
    _FriendGroup = FriendGroup;
    [_bgButton setTitle:FriendGroup.name forState:UIControlStateNormal];
    
    _numLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)FriendGroup.online ,(unsigned long)FriendGroup.friends.count];
    
}

- (void)didMoveToSuperview
{  //判断按钮是否点击了   从而改变button上的imageview旋转90度
    NSLog(@"%s",__func__);
        _bgButton.imageView.transform = _FriendGroup.isOpen ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgButton.frame = self.bounds;
    _numLabel.frame = CGRectMake(ViewZB, 0, self.frame.size.width - ViewZB-10, self.frame.size.height);
}















@end
