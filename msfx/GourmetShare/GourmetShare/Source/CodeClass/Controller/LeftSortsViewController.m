//
//  LeftSortsViewController.m
//  GourmetShare
//
//  Created by jang on 15/10/15.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "LeftSortsView.h"
#import "CollectTableViewController.h"
#import "ShareTableViewController.h"
#import "DownloadTableViewController.h"
#import "MySelfTableViewController.h"
#import "MySelfViewController.h"
#import "RegisterDataTool.h"
#import "UserInfoModle.h"

@interface LeftSortsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UIImageView *backImage;
@property (nonatomic,strong) LeftSortsView *lv;
@end

@implementation LeftSortsViewController

-(void)loadView
{
    self.lv = [[LeftSortsView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _lv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImage = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.backImage.image = [UIImage imageNamed:@"leftback.jpg"];
    _lv.backgroundColor = [UIColor colorWithPatternImage:self.backImage.image];
    
    _lv.tableview.dataSource = self;
    _lv.tableview.delegate  = self;
    _lv.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_lv.headButton addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //button置为顶层view，不然事件不能触发
    [_lv bringSubviewToFront:_lv.headButton];
    [[RegisterDataTool shareRegisterData] addObserver:self forKeyPath:@"LoginName" options:NSKeyValueObservingOptionNew context:nil];
    
    [_lv.headButton setBackgroundImage:[UIImage imageNamed:@"user.png"] forState:UIControlStateNormal];
    _lv.headName.text = @"未登录";
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self p_setupHeadImage];
}

-(void)p_setupHeadImage
{
    if ([RegisterDataTool shareRegisterData].LoginName != nil) {
        
        _lv.headName.text = [RegisterDataTool shareRegisterData].userInfo.nickname;
        
        //是否有本地头像
        NSString *uniquePath = [[RegisterDataTool shareRegisterData] imageFilePath:[RegisterDataTool shareRegisterData].LoginName];
        
        BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
        
        if (!blHave) {
            if ([RegisterDataTool shareRegisterData].userInfo.headImage != nil) {
                UIImageView *tempImage = [[UIImageView alloc]init];
                [tempImage sd_setImageWithURL:[NSURL URLWithString:[RegisterDataTool shareRegisterData].userInfo.headImage]];
                [_lv.headButton setBackgroundImage:tempImage.image forState:UIControlStateNormal];
            }
        }else {
            [_lv.headButton setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:uniquePath]] forState:UIControlStateNormal];
        }
    }
    else
    {
        [_lv.headButton setBackgroundImage:[UIImage imageNamed:@"user.png"] forState:UIControlStateNormal];
        _lv.headName.text = @"未登录";
    }
}

- (void)headButtonAction:(UIButton *)sender
{
    if ([RegisterDataTool shareRegisterData].LoginName == nil) {
        LoginViewController *lv = [[LoginViewController alloc]init];
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        
        [tempAppDelegate.mainNavigationController pushViewController:lv animated:NO];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"首  页";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"个人信息";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"我的收藏";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"我的菜谱";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"本地下载";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"清除缓存";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"注  销";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *userName = [RegisterDataTool shareRegisterData].LoginName;
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (indexPath.row == 0) {
        [tempAppDelegate.LeftSlideVC closeLeftView];//返回首页
        MainPageViewController *mpVC = [[MainPageViewController alloc] init];
        
        [tempAppDelegate.LeftSlideVC closeLeftView];//个人信息
        
        [tempAppDelegate.mainNavigationController pushViewController:mpVC animated:NO];
        
    } else if (indexPath.row == 1) {
        MySelfViewController *msVC = [[MySelfViewController alloc] init];
        
        [tempAppDelegate.LeftSlideVC closeLeftView];//个人信息
        
        [tempAppDelegate.mainNavigationController pushViewController:msVC animated:NO];
    } else if (indexPath.row == 2) {
        if (userName == nil) {
            [self p_showAlertView:@"提示" message:@"未登录"];
        }
        else
        {
            CollectTableViewController *collect = [[CollectTableViewController alloc]init];
            
            collect.userName = userName;
            
            [tempAppDelegate.LeftSlideVC closeLeftView];
            
            [tempAppDelegate.mainNavigationController pushViewController:collect animated:YES];
        }
    } else if (indexPath.row == 3) {
        
        ShareTableViewController *share = [[ShareTableViewController alloc]init];
        
        [tempAppDelegate.LeftSlideVC closeLeftView];
        
        [tempAppDelegate.mainNavigationController pushViewController:share animated:YES];
    } else if (indexPath.row == 4) {
        
        DownloadTableViewController *download = [[DownloadTableViewController alloc]init];
        
        [tempAppDelegate.LeftSlideVC closeLeftView];
        
        [tempAppDelegate.mainNavigationController pushViewController:download animated:YES];
    } else if (indexPath.row == 5) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定要清除缓存吗?" message:@"将清除本地缓存" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        
        alert.tag = 101;
        
        [alert show];
        
    } else if (indexPath.row == 6) {
        if (userName == nil) {
            [self p_showAlertView:@"提示" message:@"未登录"];
        }
        else
        {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定注销" message:@"注销" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        
        alert.tag = 102;
        
        [alert show];
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


//显示提示框
- (void)p_showAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101 && buttonIndex == 0) {
        NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        
        //删除
        [manager removeItemAtPath:cachesPath error:nil];
        
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"已清除缓存!" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        a.tag = 103;
        [a show];
    }
    else if (alertView.tag == 102 && buttonIndex == 0)
    {
        [[RegisterDataTool shareRegisterData] setValue:nil forKey:@"LoginName"];
        [AVUser logOut];  //清除缓存用户对象
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"已注销!" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        a.tag = 104;
        [a show];
    }
    else if (alertView.tag == 103 && buttonIndex == 0)
    {
        
    }
}


@end
