//
//  AllCategoryTableViewController.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 jang. All rights reserved.
//

#import "AllCategoryTableViewController.h"
#import "AllCategoryTableViewCell.h"

@interface AllCategoryTableViewController ()

@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *btnArr;
@property(nonatomic,strong)NSMutableArray *tempArr;
@property(nonatomic,strong)NSMutableString *str1;
@end

@implementation AllCategoryTableViewController
//// 第一层分类
- (void)viewDidLoad {
    [super viewDidLoad];
    [[GetFoodDataTool shareGetFoodData]getFoodDataWithPassValue:^(NSArray *array) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataArr = (NSMutableArray *)array;
                        [self.tableView reloadData];
            
                    });
    }];
    [self.tableView registerClass:[AllCategoryTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tempArr = [NSMutableArray array];
    self.btnArr = [NSMutableArray array];
    self.str1 = [NSMutableString string];

    self.view.backgroundColor = [UIColor whiteColor];
    // 删除返回按钮文字(只留箭头)
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryDetailTableViewController *detail = [[CategoryDetailTableViewController alloc]init];
    FoodCategoryModel *model = self.dataArr[indexPath.row]; 
    detail.parid = model.parentId;

    [self.navigationController pushViewController:detail animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AllCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.categoryLabel.text = @"分类";
    FoodCategoryModel *categorymodel = [[FoodCategoryModel alloc]init];
    categorymodel = self.dataArr[indexPath.row];
    cell.categoryLabel.text = categorymodel.name;
    
    
    [[GetFoodDataTool shareGetFoodData]getListWithParentId:categorymodel.parentId PassValue:^(NSArray *array) {
        self.btnArr = (NSMutableArray *)array;
        if (self.btnArr.count<=2) {
            [cell.categoryButton1 setTitle:[self.btnArr[0]valueForKey:@"name"] forState:UIControlStateNormal];
            [cell.categoryButton2 setTitle:[self.btnArr[1]valueForKey:@"name"] forState:UIControlStateNormal];
        }
        else if(self.btnArr.count <= 4)
        {
            [cell.categoryButton1 setTitle:[self.btnArr[0]valueForKey:@"name"] forState:UIControlStateNormal];
            [cell.categoryButton2 setTitle:[self.btnArr[1]valueForKey:@"name"] forState:UIControlStateNormal];
            [cell.categoryButton3 setTitle:[self.btnArr[2]valueForKey:@"name"] forState:UIControlStateNormal];
            [cell.categoryButton4 setTitle:[self.btnArr[3]valueForKey:@"name"] forState:UIControlStateNormal];
            
        }
        else
        {
            [cell.categoryButton1 setTitle:[self.btnArr[0]valueForKey:@"name"] forState:UIControlStateNormal];
            [cell.categoryButton2 setTitle:[self.btnArr[1]valueForKey:@"name"] forState:UIControlStateNormal];
            [cell.categoryButton3 setTitle:[self.btnArr[2]valueForKey:@"name"] forState:UIControlStateNormal];
            [cell.categoryButton4 setTitle:[self.btnArr[3]valueForKey:@"name"] forState:UIControlStateNormal];
            [cell.categoryButton5 setTitle:[self.btnArr[4]valueForKey:@"name"] forState:UIControlStateNormal];
            [cell.categoryButton6 setTitle:[self.btnArr[5]valueForKey:@"name"] forState:UIControlStateNormal];

        }


        


        [cell.categoryButton1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.categoryButton2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
        [cell.categoryButton3 addTarget:self action:@selector(button3Action:) forControlEvents:UIControlEventTouchUpInside];
        [cell.categoryButton4 addTarget:self action:@selector(button4Action:) forControlEvents:UIControlEventTouchUpInside];
        [cell.categoryButton5 addTarget:self action:@selector(button5Action:) forControlEvents:UIControlEventTouchUpInside];
        [cell.categoryButton6 addTarget:self action:@selector(button6Action:) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
-(void)button1Action:(UIButton *)sender
{
    DetailMenuTableViewController *menu = [[DetailMenuTableViewController alloc]init];
    
    NSString *sss = sender.titleLabel.text;
    menu.lastname = sss;
    [self.navigationController pushViewController:menu animated:YES];
}
-(void)button2Action:(UIButton *)sender
{
    DetailMenuTableViewController *menu = [[DetailMenuTableViewController alloc]init];
    
    NSString *sss = sender.titleLabel.text;
    menu.lastname = sss;
    [self.navigationController pushViewController:menu animated:YES];
}
-(void)button3Action:(UIButton *)sender
{
    DetailMenuTableViewController *menu = [[DetailMenuTableViewController alloc]init];
    
    NSString *sss = sender.titleLabel.text;
    menu.lastname = sss;
    [self.navigationController pushViewController:menu animated:YES];
}
-(void)button4Action:(UIButton *)sender
{
    DetailMenuTableViewController *menu = [[DetailMenuTableViewController alloc]init];
    
    NSString *sss = sender.titleLabel.text;
    if (sender.titleLabel.text == nil) {
        return;
    }
    else
    {
        menu.lastname = sss;
        [self.navigationController pushViewController:menu animated:YES];
        
    }}
-(void)button5Action:(UIButton *)sender
{
    DetailMenuTableViewController *menu = [[DetailMenuTableViewController alloc]init];
    
    NSString *sss = sender.titleLabel.text;
    if (sender.titleLabel.text == nil) {
        return;
    }
    else
    {
        menu.lastname = sss;
        [self.navigationController pushViewController:menu animated:YES];
        
    }
    
}
-(void)button6Action:(UIButton *)sender
{
    DetailMenuTableViewController *menu = [[DetailMenuTableViewController alloc]init];
    
    NSString *sss = sender.titleLabel.text;
    if (sender.titleLabel.text == nil) {
        return;
    }
    else
    {
        menu.lastname = sss;
        [self.navigationController pushViewController:menu animated:YES];
        
    }
    
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
