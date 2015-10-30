//
//  MoreShareViewController.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/24.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "MoreShareViewController.h"
#import "MoreShareView.h"
#import "GetShareDataTool.h"
@interface MoreShareViewController ()

@property (nonatomic,strong)MoreShareView *more;

@end

@implementation MoreShareViewController
-(void)loadView
{
    self.more = [[MoreShareView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.view = _more;
    
    
}

-(CGFloat)heightforstring1:(NSString *)string
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(kScreenWidth-20, 5000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
    
}
-(void)p_data
{
    CGRect rect = self.more.materLabel.frame;
    rect.size.height = [self heightforstring1:self.stuff.ingredients];
    self.more.materLabel.frame = rect;
    CGRect rect2 = self.more.step.frame;
    rect2.origin.y = CGRectGetMaxY(self.more.materLabel.frame)+10;
    self.more.step.frame = rect2;
    
    
    
    CGRect rect1 = self.more.stepLabel.frame;
    rect1.size.height = [self heightforstring1:self.stuff.imtro];
    rect1.origin.y = CGRectGetMaxY(self.more.step.frame)+10;
    self.more.stepLabel.frame = rect1;
    self.more.nameLabel.text = self.stuff.title;
    [self.more.myImage sd_setImageWithURL:[NSURL URLWithString:self.stuff.albums[0]]];
    self.more.materLabel.text = self.stuff.ingredients;
    self.more.stepLabel.text = self.stuff.imtro;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.more.back.contentSize  = CGSizeMake(kScreenWidth, 900);
    [self p_data];
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
