//
//  AboutUsViewController.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property(nonatomic,strong)UIScrollView *scrollview;
@end

@implementation AboutUsViewController
-(CGFloat)heightforstring1:(NSString *)string
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(kScreenWidth-20, 5000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scrollview.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*1.5);
    [self.view addSubview:_scrollview];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"about.jpeg"]];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*0.1, 0, kScreenWidth*0.8, kScreenHeight)];
    
    name.numberOfLines = 0;
    name.text = @"1.有详细步骤图的菜谱\n    有近万个菜谱供您选择\n    菜谱拥有清晰步骤图，看图学习\n    让您轻松做出美味大餐！\n\n2.返璞归真的设计\n    清爽简洁的页面，极具诱惑的美食大图\n    美食，是眼睛到味蕾的全方位享受。\n\n3.收藏、分享\n    您可以收藏你满意的菜谱，把菜谱分享给您的朋友们\n    还可以给大家分享您的DIY美食\n\n4.下载菜谱\n    下载到本地，没有网络的时候也能愉快的看图学做菜啦\n\n5.健康资讯浏览\n    我们每日将向您推送健康资讯，让您的生活更加健康   \n  \n作者: Mr.Jiang ,Welling , 小丑\n";
    
    CGFloat height  = [self heightforstring1:name.text];
    CGRect rect = name.frame;
    rect.size.height = height;
    name.frame = rect;
    [self.scrollview addSubview:name];
   
    
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
