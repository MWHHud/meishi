//
//  PrivateListViewController.m
//  GourmetShare
//
//  Created by jang on 15/10/15.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "PrivateListViewController.h"
#import "CollectTableViewController.h"
#import "ShareTableViewController.h"
#import "DownloadTableViewController.h"
#import "GetFavouriteDataTool.h"
#import "MySelfTableViewController.h"
#import "AboutUsViewController.h"
#import "MySelfViewController.h"

@interface PrivateListViewController ()<UIAlertViewDelegate>

@end

@implementation PrivateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *userName = [RegisterDataTool shareRegisterData].LoginName;
    if (indexPath.row == 0) {
        MySelfViewController *my = [[MySelfViewController alloc]init];
        [tempAppDelegate.LeftSlideVC closeLeftView];
        [tempAppDelegate.mainNavigationController pushViewController:my animated:YES];
    }
    else if (indexPath.row == 1) {
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
    }
    else if (indexPath.row == 2)
    {
        ShareTableViewController *share = [[ShareTableViewController alloc]init];
        [tempAppDelegate.LeftSlideVC closeLeftView];
        [tempAppDelegate.mainNavigationController pushViewController:share animated:YES];
    }
    else if (indexPath.row == 3)
    {
        DownloadTableViewController *download = [[DownloadTableViewController alloc]init];
        [tempAppDelegate.LeftSlideVC closeLeftView];
        [tempAppDelegate.mainNavigationController pushViewController:download
                                                            animated:YES];
    }
    else if (indexPath.row == 4)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定要清除缓存吗?" message:@"将清除本地缓存" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        alert.tag = 101;
        [alert show];
        
    }
    else if (indexPath.row == 5)
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
    else if (indexPath.row == 6)
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
        a.tag = 103;
        [a show];
    }
    else if (alertView.tag == 102 && buttonIndex == 0)
    {
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"已注销!" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [RegisterDataTool shareRegisterData].LoginName = nil;
        a.tag = 104;
        [a show];
    }
    else if (alertView.tag == 103 && buttonIndex == 0)
    {
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"个人信息";
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"我的收藏";
    }
    else if (indexPath.row == 2)
    {
        cell.textLabel.text = @"我的分享";
    }
    else if (indexPath.row == 3)
    {
        cell.textLabel.text = @"本地下载";
    }
    else if (indexPath.row == 4)
    {
        cell.textLabel.text = @"清除缓存";
    }
    else if (indexPath.row == 5)
    {
        cell.textLabel.text = @"注销";
    }
    else if (indexPath.row == 6)
    {
        cell.textLabel.text = @"关于我们";
    }
    // Configure the cell...
    
    return cell;
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
