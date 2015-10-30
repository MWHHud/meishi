//
//  PersonalCenterTbaleViewController.m
//  GourmetShare
//
//  Created by jang on 15/10/27.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "PersonalCenterTbaleViewController.h"
#import "PersonalCenterHeadCell.h"
#import "PersonalCenterCell.h"
#import "MySelfViewController.h"
#import "ShareTableViewController.h"
#import "AboutUsViewController.h"
#import "DownloadTableViewController.h"
#import "CollectTableViewController.h"
#import "RegisterDataTool.h"
#import "UserInfoModle.h"
@interface PersonalCenterTbaleViewController ()
@property(nonatomic,strong)UIAlertView *alert;
@end

@implementation PersonalCenterTbaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[PersonalCenterHeadCell class] forCellReuseIdentifier:@"headCell"];
    [self.tableView registerClass:[PersonalCenterCell class] forCellReuseIdentifier:@"cell"];
    [[RegisterDataTool shareRegisterData] addObserver:self forKeyPath:@"LoginName" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self p_setupHeadImage];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self p_setupHeadImage];
}

-(void)p_setupHeadImage
{
    NSIndexPath *tempImdexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:tempImdexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    //触发选中事件
    if ([self.tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:tempImdexPath];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 8;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return kScreenWidth*0.6;
    }
    return 55;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PersonalCenterHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headCell" forIndexPath:indexPath];

        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.headImageView setImage:[UIImage imageNamed:@"user.png"] forState:UIControlStateNormal] ;
        
        [cell.headImageView addTarget:self action:@selector(LoginAction) forControlEvents:UIControlEventTouchUpInside];
        
        cell.nameLable.text =@"未登录";
        
        return cell;
    }
    else
    {
        PersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.frame = CGRectMake(0, 0, kScreenWidth, 50);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.row == 1) {
            cell.titleImage.image = [UIImage imageNamed:@"usercenter_draft.png"];
            cell.titleName.text = @"我的信息";
        } else if (indexPath.row == 2) {
            cell.titleImage.image = [UIImage imageNamed:@"usercenter_collection.png"];
            cell.titleName.text = @"我的收藏";
        } else if (indexPath.row == 3) {
            cell.titleImage.image = [UIImage imageNamed:@"usercenter_recipe.png"];
            cell.titleName.text = @"我的菜谱";
        } else if (indexPath.row == 4) {
            cell.titleImage.image = [UIImage imageNamed:@"usercenter_pai.png"];
            cell.titleName.text = @"本地下载";
        } else if (indexPath.row == 5) {
            cell.titleImage.image = [UIImage imageNamed:@"usercenter_blog.png"];
            cell.titleName.text = @"清除缓存";
        }else if (indexPath.row == 6) {
            cell.titleImage.image = [UIImage imageNamed:@"usercenter_delete.png"];
            cell.titleName.text = @"注销";
        }else if (indexPath.row == 7) {
            cell.titleImage.image = [UIImage imageNamed:@"main_user_gray.png"];
            cell.titleName.text = @"关于我们";
        }
        return cell;
    }

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *userName = [RegisterDataTool shareRegisterData].LoginName;
    if (indexPath.row == 0) {
        PersonalCenterHeadCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if ([RegisterDataTool shareRegisterData].LoginName != nil) {
            
            
            cell.nameLable.text = [RegisterDataTool shareRegisterData].userInfo.nickname;
            
            //是否有本地头像
            NSString *uniquePath = [[RegisterDataTool shareRegisterData] imageFilePath:[RegisterDataTool shareRegisterData].LoginName];
            
            BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
            
            if (!blHave) {
                if ([RegisterDataTool shareRegisterData].userInfo.headImage != nil) {
                    UIImageView *tempImage = [[UIImageView alloc]init];
                    [tempImage sd_setImageWithURL:[NSURL URLWithString:[RegisterDataTool shareRegisterData].userInfo.headImage]];
                    [cell.headImageView setImage:tempImage.image forState:UIControlStateNormal];
                    
                }
            }else {
                [cell.headImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:uniquePath]] forState:UIControlStateNormal];
            }
        }
        else
        {
            [cell.headImageView setImage:[UIImage imageNamed:@"user.png"]forState:UIControlStateNormal];
            cell.nameLable.text  = @"未登录";
        }

    }
    else if (indexPath.row == 1) {
        MySelfViewController *my = [[MySelfViewController alloc]init];
        [tempAppDelegate.LeftSlideVC closeLeftView];
        [tempAppDelegate.mainNavigationController pushViewController:my animated:YES];
    }
    else if (indexPath.row == 2) {
        if (userName == nil) {
            UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未登陆" delegate:self cancelButtonTitle:@"去登陆" otherButtonTitles:@"取消", nil];
            alert1.tag = 110;
            [alert1 show];
        }
        else
        {
            CollectTableViewController *collect = [[CollectTableViewController alloc]init];
            collect.userName = userName;
            [tempAppDelegate.LeftSlideVC closeLeftView];
            [tempAppDelegate.mainNavigationController pushViewController:collect animated:YES];
        }
    }
    else if (indexPath.row == 3)
    {
        ShareTableViewController *share = [[ShareTableViewController alloc]init];
        [tempAppDelegate.LeftSlideVC closeLeftView];
        [tempAppDelegate.mainNavigationController pushViewController:share animated:YES];
    }
    else if (indexPath.row == 4)
    {
        DownloadTableViewController *download = [[DownloadTableViewController alloc]init];
        [tempAppDelegate.LeftSlideVC closeLeftView];
        [tempAppDelegate.mainNavigationController pushViewController:download
                                                            animated:YES];
    }
    else if (indexPath.row == 5)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定要清除缓存吗?" message:@"将清除本地缓存" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        alert.tag = 101;
        [alert show];
        
    }
    else if (indexPath.row == 6)
    {
        NSString *name = [RegisterDataTool shareRegisterData].LoginName;
        if (name == nil) {
            [self p_showAlertView:@"提示" message:@"未登录"];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定注销" message:@"注销" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
            
            alert.tag = 102;
            [alert show];
        }
    }
    else if (indexPath.row == 7)
    {
        AboutUsViewController *us = [[AboutUsViewController alloc]init];
        [tempAppDelegate.LeftSlideVC closeLeftView];
        [tempAppDelegate.mainNavigationController pushViewController:us animated:YES];
        
    }
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
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"已清除缓存!" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        
        //删除
        [manager removeItemAtPath:cachesPath error:nil];
        
        a.tag = 103;
        [a show];
    }
    else if (alertView.tag == 102 && buttonIndex == 0)
    {
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"已注销!" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [[RegisterDataTool shareRegisterData] setValue:nil forKey:@"LoginName"];
        [AVUser logOut];  //清除缓存用户对象
        a.tag = 104;
        [a show];
    }
    else if (alertView.tag == 110 &&buttonIndex == 0)
    {
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        LoginViewController *login = [[LoginViewController alloc]init];
        [tempAppDelegate.LeftSlideVC closeLeftView];
        [tempAppDelegate.mainNavigationController pushViewController:login animated:YES];
    }
    else if (alertView.tag == 103 && buttonIndex == 0)
    {
        
    }else
    {
        if (buttonIndex == 0) {
            AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            LoginViewController *login = [[LoginViewController alloc]init];
            [tempAppDelegate.LeftSlideVC closeLeftView];
            [tempAppDelegate.mainNavigationController pushViewController:login animated:YES];
        }
    }
}

-(void)LoginAction
{
    if ([RegisterDataTool shareRegisterData].LoginName == nil) {
        self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未登陆" delegate:self cancelButtonTitle:@"去登陆" otherButtonTitles:@"取消", nil];
        [_alert show];
        
    }
}


@end
