//
//  MySelfTableViewController.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "MySelfTableViewController.h"
#import "MySelfImageTableViewCell.h"
#import "MySelfLabelTableViewCell.h"
#import "RegisterDataTool.h"
#import "UserInfoModle.h"
#import "LTView.h"
@interface MySelfTableViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UserInfoModle *userInfo;
@end

@implementation MySelfTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[MySelfImageTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerClass:[MySelfLabelTableViewCell class] forCellReuseIdentifier:@"cell2"];

    UIBarButtonItem *changInfo = [[UIBarButtonItem alloc]initWithTitle:@"修改资料" style:UIBarButtonItemStylePlain target:self action:@selector(changInfo:)];
    self.navigationItem.rightBarButtonItem = changInfo;
    if ([RegisterDataTool shareRegisterData].LoginName != nil) {
        self.userInfo = [[UserInfoModle alloc]init];
        _userInfo = [RegisterDataTool shareRegisterData].userInfo;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }
    else
        return 60;
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
    
    if ([RegisterDataTool shareRegisterData].LoginName != nil) {
        if (indexPath.row == 0) {
            MySelfImageTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1" ];
            cell1.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"purpleback.jpg"]];
            return cell1;
        }
        else
        {
            MySelfLabelTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            
            cell2.titleLabel.textAlignment = NSTextAlignmentRight;
            if (indexPath.row == 1) {
                cell2.titleLabel.text = @"昵称:";
                [cell2.textFiled outputFileText:_userInfo.nickname];
            }
            if (indexPath.row == 2) {
                cell2.titleLabel.text = @"账号:";
                [cell2.textFiled outputFileText:_userInfo.email];
            }
            if (indexPath.row == 3) {
                cell2.titleLabel.text = @"性别:";

                [cell2.textFiled outputFileText:_userInfo.gender];
            }
            if (indexPath.row == 4) {
                cell2.titleLabel.text = @"个人爱好:";

                [cell2.textFiled outputFileText:_userInfo.hobby];
            }
            if (indexPath.row == 5) {
                cell2.titleLabel.text = @"爱吃的菜:";

                [cell2.textFiled outputFileText:_userInfo.likeFood];
            }
            if (indexPath.row == 6) {
                cell2.titleLabel.text = @"会做的菜:";
                [cell2.textFiled outputFileText:_userInfo.skill];
            }
            return cell2;
        }
    }
    
    if (indexPath.row == 0) {
        MySelfImageTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1" ];
        cell1.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"purpleback.jpg"]];
        return cell1;
    }
    else
    {
        MySelfLabelTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        
        cell2.titleLabel.textAlignment = NSTextAlignmentRight;
        if (indexPath.row == 1) {
            cell2.titleLabel.text = @"昵称:";
            [cell2.textFiled outputFileText:@"--"];
        }
        if (indexPath.row == 2) {
            cell2.titleLabel.text = @"账号:";
            [cell2.textFiled outputFileText:@"--"];
        }
        if (indexPath.row == 3) {
            cell2.titleLabel.text = @"性别:";
            
            [cell2.textFiled outputFileText:@"--"];
        }
        if (indexPath.row == 4) {
            cell2.titleLabel.text = @"个人爱好:";
            
            [cell2.textFiled outputFileText:@"--"];
        }
        if (indexPath.row == 5) {
            cell2.titleLabel.text = @"爱吃的菜:";
            
            [cell2.textFiled outputFileText:@"--"];
        }
        if (indexPath.row == 6) {
            cell2.titleLabel.text = @"会做的菜:";
            [cell2.textFiled outputFileText:@"--"];
        }
        return cell2;
    }
    // Configure the cell...
    
  
}

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

//显示提示框
- (void)p_showAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

-(void)changInfo:(UIBarButtonItem *)sender
{
    if ([sender.title isEqualToString:@"修改资料"]) {
        if ([RegisterDataTool shareRegisterData].LoginName != nil) {
            
        }
        else
        {
            [self p_showAlertView:@"提示" message:@"未登录"];
        }
    }

}

@end
