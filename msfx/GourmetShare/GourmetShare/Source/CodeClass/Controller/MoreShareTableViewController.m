//
//  MoreShareTableViewController.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/24.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "MoreShareTableViewController.h"
#import "MoreShareTableViewCell.h"
#import "MoreShareViewController.h"
#import "GetShareDataTool.h"
@interface MoreShareTableViewController ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation MoreShareTableViewController
// 第三方小菊花
- (void)p_setupProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupProgressHud];
    self.dataArr = [NSMutableArray array];
    [self.tableView registerClass:[MoreShareTableViewCell class] forCellReuseIdentifier:@"cell"];
    [[GetShareDataTool shareShareData]getShareWithPassValue:^(NSArray *array) {
        self.dataArr = (NSMutableArray *)array;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.dataArr.count<1) {
            }
            else
            {
                [self.tableView reloadData];
            }
            
            self.hud.hidden = YES;
        });
    }];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuffModle *model = self.dataArr[indexPath.row];
    MoreShareViewController *more = [[MoreShareViewController alloc]init];
    more.stuff = model;
    [self.navigationController pushViewController:more animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    StuffModle *stuf = self.dataArr[indexPath.row];
    
    cell.nameLabel.text = stuf.title;
    cell.userLabel.text = stuf.nickname;
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    dispatch_async(globl_t, ^{
        
       [cell.myImage sd_setImageWithURL:[NSURL URLWithString:stuf.albums[0]]];
    });

    
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
