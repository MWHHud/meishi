//
//  NewsDetailTableViewController.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/19.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "NewsDetailTableViewController.h"
#import "NewsDetailImageTableViewCell.h"
#import "NewsDetailTableViewCell.h"
#import "NewImage.h"
@interface NewsDetailTableViewController ()
@property(nonatomic,strong)NSMutableArray *conArr;// 新闻内容数组
@property(nonatomic,strong)NSMutableArray *picArr;// 图片数组
@property(nonatomic,strong)NSMutableString *conStr;
@property(nonatomic,strong)NSMutableString *picStr;
@property(nonatomic,strong)NSMutableArray *newconArr;
@property(nonatomic,strong)NSMutableArray *newpicArr;
@property(nonatomic,assign)int i;
@property(nonatomic,assign)BOOL isImage;
@property(nonatomic,assign)int curr;
@property(nonatomic,strong)NSMutableDictionary *picDict;
@property(nonatomic,strong)NSMutableDictionary *newpicDict;
@property(nonatomic,assign)CGFloat height;// 正文的高度
@property(nonatomic,assign)CGFloat height1;// 第一行的高度



@end

@implementation NewsDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.i = 0;
    
    self.conArr = [NSMutableArray array];
    self.picArr = [NSMutableArray array];
    self.conArr = (NSMutableArray *)self.news.contents;
    self.picArr = (NSMutableArray *)self.news.image;
    self.picDict = [NSMutableDictionary dictionary];
    int index = 0;
    int picIndex = 0;
    
    for (NSString *str in _conArr) {
        if ([str isEqualToString:@"img"])
        {
            [_picDict setValue:_picArr[picIndex] forKey:[NSString stringWithFormat:@"%d",index]];

            picIndex++;
        }
        index++;
    }
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
}
-(CGFloat)heightforlabel:(NSString *)str
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0]};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(kScreenWidth-20, 5000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        return self.height1;
    }
    if (self.isImage == YES) {
        return 200;
    }
    else
    {
        return self.height;
    }
    
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows

    return self.conArr.count +1 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        NewsDetailTableViewCell *newsLabel = [[NewsDetailTableViewCell alloc]init];
        newsLabel.newsLabel.text = self.news.title;
        self.height1 = [self heightforlabel:self.news.title];
        CGRect temp = newsLabel.newsLabel.frame;
        temp.size.height = self.height1;
        newsLabel.newsLabel.frame = temp;
        newsLabel.newsLabel.numberOfLines = 0;
        self.isImage = NO;
        return newsLabel;
    }
    else{
        if ([self.conArr[indexPath.row-1] isEqualToString:@"img"]) {
            NSString *picStr = [_picDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row-1]];
            NewsDetailImageTableViewCell *newsImage = [[NewsDetailImageTableViewCell alloc]init];
            [newsImage.newsImage sd_setImageWithURL:[NSURL URLWithString:picStr]];
            self.isImage = YES;
            return newsImage;
        }
        else
        {
                        NewsDetailTableViewCell *newsLabel = [[NewsDetailTableViewCell alloc]init];
            newsLabel.newsLabel.text = self.conArr[indexPath.row-1];
            self.height = [self heightforlabel:self.conArr[indexPath.row-1]];
            CGRect temp = newsLabel.newsLabel.frame;
            temp.size.height = self.height;
            newsLabel.newsLabel.frame = temp;
            newsLabel.newsLabel.numberOfLines = 0;
            self.isImage = NO;
            return newsLabel;
        }

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
