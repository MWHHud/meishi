//
//  ShareTableViewController.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/21.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "ShareTableViewController.h"
#import "ShareDetailViewController.h"
#import "GetShareDataTool.h"
#import "myshareTableViewCell.h"
@interface ShareTableViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UIAlertView *alert;
@property(nonatomic,strong)UIBarButtonItem *edit;
@property(nonatomic,assign)BOOL flag;
@end

@implementation ShareTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.alert.delegate = self;
    self.flag = YES;
    [self.tableView registerClass:[myshareTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.dataArr = [NSMutableArray array];
    [self p_data];
    [self setupRefresh];
    self.edit = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(btnAction)];
    UIBarButtonItem *share = [[UIBarButtonItem alloc]initWithTitle:@"我要分享" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    NSArray *btnArr = [NSArray arrayWithObjects:share,_edit, nil];
    self.navigationItem.rightBarButtonItems = btnArr;
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 下拉刷新
-(void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [control beginRefreshing];
    
    // 3.加载数据
    [self refreshStateChange:control];
    
}
// 数据请求
-(void)p_data
{
    if ([RegisterDataTool shareRegisterData].LoginName == nil) {
        
    }
    else
    {
        [[GetShareDataTool shareShareData]getShareWithUserName:[RegisterDataTool shareRegisterData].LoginName PassValue:^(NSArray *array) {
            self.dataArr = (NSMutableArray *)array;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
            });
        }];
        
    }
}
-(void)refreshStateChange:(UIRefreshControl *)control
{
    
    [self p_data];
    // 3. 结束刷新
    [control endRefreshing];
    
}

-(void)rightAction:(UIBarButtonItem *)sender
{
    if ([RegisterDataTool shareRegisterData].LoginName == nil) {
        self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未登陆" delegate:self cancelButtonTitle:@"去登陆" otherButtonTitles:@"取消", nil];
        //self.alert.tag = 101;
        [_alert show];
        
    }
    else
    {
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        ShareDetailViewController *detail = [[ShareDetailViewController alloc]init];
        
        [tempAppDelegate.LeftSlideVC closeLeftView];
        
        [tempAppDelegate.mainNavigationController pushViewController:detail animated:YES];

    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
  
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    myshareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    StuffModle *model = self.dataArr[indexPath.row];
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:model.albums[0]]];
    cell.name.text = model.title;

    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuffModle *model = self.dataArr[indexPath.row];
    MoreShareViewController *share = [[MoreShareViewController alloc]init];
    share.stuff = model;
    [self.navigationController pushViewController:share animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)btnAction
{
    if (self.flag == YES) {
        [self.edit setTitle:@"完成"];
    }
    else
    {
        [self.edit setTitle:@"编辑"];
    }
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    self.flag = !_flag;
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuffModle *model = self.dataArr[indexPath.row];
    [[GetShareDataTool shareShareData]deleteShareWithUserName:[RegisterDataTool shareRegisterData].LoginName Sid:model.sid];
    [self.dataArr removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
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
