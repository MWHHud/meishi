//
//  GourmetMainViewController.m
//  GourmetShare
//
//  Created by jang on 15/10/15.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "GourmetMainViewController.h"
#import "MainView.h"
#import "MoreShareTableViewController.h"
#import "GetShareDataTool.h"
#import "MyScrollView.h"

@interface GourmetMainViewController ()<SDCycleScrollViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)MainView *mView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableString *pic_url;
@property(nonatomic,strong)UITapGestureRecognizer *tap;
@property(nonatomic,strong)UITapGestureRecognizer *tap1;
@property(nonatomic,strong)UITapGestureRecognizer *tap2;
@property(nonatomic,strong)UITapGestureRecognizer *tap3;
@property(nonatomic,strong)UITapGestureRecognizer *tap4;
@property(nonatomic,strong)UITapGestureRecognizer *tap5;
@property(nonatomic,strong)UITapGestureRecognizer *tap6;
@property(nonatomic,strong)UITapGestureRecognizer *tap7;
@property(nonatomic,assign)NSInteger number;
@property(nonatomic,strong)NSMutableArray *fdataArr;
@property(nonatomic,strong)NSMutableArray *picArr;
@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)SDCycleScrollView *view1;
@property(nonatomic,strong)NSMutableArray *comdataArr;
@property (nonatomic,strong)MyScrollView *my;
@end

@implementation GourmetMainViewController
-(void)loadView
{
    self.my = [[MyScrollView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.view = _my;
}

-(NSInteger)randomnum
{
    NSInteger num = arc4random()%28+10001;
    return num;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.comdataArr = [NSMutableArray array];
    self.my.contentSize = CGSizeMake(self.my.bounds.size.width, self.my.bounds.size.height * 2.2);
    
    
    
    // 添加"更多"事件
    [self.my.moreButton1 addTarget:self action:@selector(moreButton1Action) forControlEvents:UIControlEventTouchUpInside];
    [self.my.moreButton2 addTarget:self action:@selector(moreButton2Action:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupRefresh];
    [self p_data];
    
}

-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

// 断网处理
-(void)nethandle
{
    
    if (self.dataArr.count<1) {
        self.my.oneImageView1.userInteractionEnabled = NO;
        self.my.twoImageView1.userInteractionEnabled = NO;
        self.my.threeImageView1.userInteractionEnabled = NO;
        self.my.fourImageView1.userInteractionEnabled = NO;
        self.view1.delegate = nil;
    }
    else
    {
        self.my.oneImageView1.userInteractionEnabled = YES;
        self.my.twoImageView1.userInteractionEnabled = YES;
        self.my.threeImageView1.userInteractionEnabled = YES;
        self.my.fourImageView1.userInteractionEnabled = YES;
        self.view1.delegate = self;
        
    }
    if (self.comdataArr.count<1) {
        self.my.oneImageView2.userInteractionEnabled = NO;
        self.my.twoImageView2.userInteractionEnabled = NO;
        self.my.threeImageView2.userInteractionEnabled = NO;
        self.my.fourImageView2.userInteractionEnabled = NO;
    }
    else
    {
        self.my.oneImageView2.userInteractionEnabled = YES;
        self.my.twoImageView2.userInteractionEnabled = YES;
        self.my.threeImageView2.userInteractionEnabled = YES;
        self.my.fourImageView2.userInteractionEnabled = YES;
        
    }
    
}

-(void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [control beginRefreshing];
    
    // 3.加载数据
    [self refreshStateChange:control];
    
}
-(void)refreshStateChange:(UIRefreshControl *)control
{
    
    // 轮播图图片数组
    self.picArr = [NSMutableArray array];
    // 轮播图标题
    self.titleArr = [NSMutableArray array];
    
    // 给imageview添加点击手势
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    self.my.oneImageView1.userInteractionEnabled = YES;
    [self.my.oneImageView1 addGestureRecognizer:_tap];
    
    self.tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction1)];
    self.my.twoImageView1.userInteractionEnabled = YES;
    [self.my.twoImageView1 addGestureRecognizer:_tap1];
    
    
    self.tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2)];
    self.my.threeImageView1.userInteractionEnabled = YES;
    [self.my.threeImageView1 addGestureRecognizer:_tap2];
    
    
    self.tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction3)];
    self.my.fourImageView1.userInteractionEnabled = YES;
    [self.my.fourImageView1 addGestureRecognizer:_tap3];
    
    
    self.tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction4)];
    self.my.oneImageView2.userInteractionEnabled = YES;
    [self.my.oneImageView2 addGestureRecognizer:_tap4];
    
    
    self.tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction5)];
    self.my.twoImageView2.userInteractionEnabled = YES;
    [self.my.twoImageView2 addGestureRecognizer:_tap5];
    
    self.tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction6)];
    self.my.threeImageView2.userInteractionEnabled = YES;
    [self.my.threeImageView2 addGestureRecognizer:_tap6];
    
    self.tap7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction7)];
    self.my.fourImageView2.userInteractionEnabled = YES;
    [self.my.fourImageView2 addGestureRecognizer:_tap7];
    
    
    self.fdataArr = [NSMutableArray array];
    self.dataArr = [NSMutableArray array];
    self.number = [self randomnum];
    [[GetFoodDataTool shareGetFoodData]getListWithParentId:[NSMutableString stringWithFormat:@"%ld",(long)self.number] PassValue:^(NSArray *array) {
        self.fdataArr = (NSMutableArray *)array;
        FoodListModle *model = self.fdataArr[0];
        [[GetFoodDataTool shareGetFoodData]getFoodListInfoWithId:model.lid PassValue:^(NSArray *array) {
            
            self.dataArr = (NSMutableArray *)array;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                StuffModle *model = [[StuffModle alloc]init];
                model =self.dataArr[4];
                for (NSMutableString *str in model.albums) {
                    self.pic_url = str;
                }
                
                [self.my.oneImageView1 sd_setImageWithURL:[NSURL URLWithString:self.pic_url]];
                self.my.oneLabel1.text = model.title;
                
                
                StuffModle *model1 = [[StuffModle alloc]init];
                model1 =self.dataArr[5];
                for (NSMutableString *str in model1.albums) {
                    self.pic_url = str;
                }
                
                [self.my.twoImageView1 sd_setImageWithURL:[NSURL URLWithString:self.pic_url]];
                self.my.twoLabel1.text = model1.title;
                
                
                StuffModle *model2 = [[StuffModle alloc]init];
                model2 =self.dataArr[3];
                for (NSMutableString *str in model2.albums) {
                    self.pic_url = str;
                }
                
                [self.my.threeImageView1 sd_setImageWithURL:[NSURL URLWithString:self.pic_url]];
                self.my.threeLabel1.text = model2.title;
                
                StuffModle *model14 = [[StuffModle alloc]init];
                model14 = self.dataArr[2];
                for (NSMutableString *str in model14.albums) {
                    self.pic_url = str;
                }
                
                [self.my.fourImageView1 sd_setImageWithURL:[NSURL URLWithString:self.pic_url]];
                self.my.fourLabel1.text = model14.title;
                [self p_data];
                // 轮播图数据
                StuffModle *model3 = self.dataArr[0];
                for (NSMutableString *str in model3.albums) {
                    self.pic_url = str;
                    UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.pic_url]]];
                    [self.picArr addObject:img1];
                    [self.titleArr addObject:model3.title];
                    
                    
                }
                
                StuffModle *model4 = self.dataArr[1];
                for (NSMutableString *str in model4.albums) {
                    self.pic_url = str;
                    UIImage *img2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.pic_url]]];
                    [self.picArr addObject:img2];
                    [self.titleArr addObject:model4.title];
                    
                }
                
                StuffModle *model5 = self.dataArr[2];
                for (NSMutableString *str in model5.albums) {
                    self.pic_url = str;
                    UIImage *img3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.pic_url]]];
                    [self.picArr addObject:img3];
                    [self.titleArr addObject:model5.title];
                    
                }
                
                self.view1 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 3 / 4) imagesGroup:self.picArr];
                self.view1.titlesGroup = self.titleArr;
                self.view1.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
                self.view1.delegate = self;
                [self.view addSubview:_view1];
                // 断网处理
                [self nethandle];
            });
            
            
            
        }];
        
    }];
    
    
    [self nethandle];

    
    
    // 3. 结束刷新
    [control endRefreshing];
    
}

-(void)p_data
{
    [[GetShareDataTool shareShareData]getShareWithPassValue:^(NSArray *array) {
        
        self.comdataArr = (NSMutableArray *)array;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (array.count<1) {
                self.my.oneImageView2.userInteractionEnabled = NO;
                self.my.twoImageView2.userInteractionEnabled = NO;
                self.my.threeImageView2.userInteractionEnabled = NO;
                self.my.fourImageView2.userInteractionEnabled = NO;
            }
            else if (array.count<2)
            {
                StuffModle *stu1 = self.comdataArr[0];
                [self.my.oneImageView2 sd_setImageWithURL:[NSURL URLWithString:stu1.albums[0]]];
                self.my.oneLabel2.text =  stu1.title;
                self.my.twoImageView2.userInteractionEnabled = NO;
                self.my.threeImageView2.userInteractionEnabled = NO;
                self.my.fourImageView2.userInteractionEnabled = NO;
            }
            else if (array.count<3)
            {
                StuffModle *stu1 = self.comdataArr[0];
                [self.my.oneImageView2 sd_setImageWithURL:[NSURL URLWithString:stu1.albums[0]]];
                self.my.oneLabel2.text =  stu1.title;
                
                StuffModle *stu2 = self.comdataArr[1];
                [self.my.twoImageView2 sd_setImageWithURL:[NSURL URLWithString:stu2.albums[0]]];
                self.my.twoLabel2.text =  stu2.title;
                
                self.my.threeImageView2.userInteractionEnabled = NO;
                self.my.fourImageView2.userInteractionEnabled = NO;
            }
            else if (array.count < 4)
            {
                StuffModle *stu1 = self.comdataArr[0];
                [self.my.oneImageView2 sd_setImageWithURL:[NSURL URLWithString:stu1.albums[0]]];
                self.my.oneLabel2.text =  stu1.title;
                
                StuffModle *stu2 = self.comdataArr[1];
                [self.my.twoImageView2 sd_setImageWithURL:[NSURL URLWithString:stu2.albums[0]]];
                self.my.twoLabel2.text =  stu2.title;
                
                StuffModle *stu3 = self.comdataArr[2];
                [self.my.threeImageView2 sd_setImageWithURL:[NSURL URLWithString:stu3.albums[0]]];
                self.my.threeLabel2.text =  stu3.title;
                
                self.my.fourImageView2.userInteractionEnabled = NO;
            }
            else
            {
                StuffModle *stu1 = self.comdataArr[0];
                [self.my.oneImageView2 sd_setImageWithURL:[NSURL URLWithString:stu1.albums[0]]];
                self.my.oneLabel2.text =  stu1.title;
                
                StuffModle *stu2 = self.comdataArr[1];
                [self.my.twoImageView2 sd_setImageWithURL:[NSURL URLWithString:stu2.albums[0]]];
                self.my.twoLabel2.text =  stu2.title;
                
                StuffModle *stu3 = self.comdataArr[2];
                [self.my.threeImageView2 sd_setImageWithURL:[NSURL URLWithString:stu3.albums[0]]];
                self.my.threeLabel2.text =  stu3.title;
                
                StuffModle *stu4 = self.comdataArr[3];
                [self.my.fourImageView2 sd_setImageWithURL:[NSURL URLWithString:stu4.albums[0]]];
                self.my.fourLabel2.text = stu4.title;
            }
 
        
        });
        
    }];

    
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.dataArr[index] == nil) {
        
    }
    else
    {
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        DetailTableViewController *detail =[[DetailTableViewController alloc]init];
        detail.stuffmodel = self.dataArr[index];
        [tempAppDelegate.LeftSlideVC closeLeftView];
        [tempAppDelegate.mainNavigationController pushViewController:detail animated:YES];
        
    }
    
    
}
// 手势点击事件
-(void)tapAction
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    DetailTableViewController *detail =[[DetailTableViewController alloc]init];
    detail.stuffmodel = self.dataArr[4];
    [tempAppDelegate.LeftSlideVC closeLeftView];
    [tempAppDelegate.mainNavigationController pushViewController:detail animated:YES];
}


-(void)tapAction1
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    DetailTableViewController *detail =[[DetailTableViewController alloc]init];
    detail.stuffmodel = self.dataArr[5];
    [tempAppDelegate.LeftSlideVC closeLeftView];
    [tempAppDelegate.mainNavigationController pushViewController:detail animated:YES];
}


-(void)tapAction2
{
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    DetailTableViewController *detail =[[DetailTableViewController alloc]init];
    detail.stuffmodel = self.dataArr[3];
    [tempAppDelegate.LeftSlideVC closeLeftView];
    [tempAppDelegate.mainNavigationController pushViewController:detail animated:YES];
}

-(void)tapAction3
{
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    DetailTableViewController *detail = [[DetailTableViewController alloc]init];
    detail.stuffmodel = self.dataArr[2];
    [tempAppDelegate.LeftSlideVC closeLeftView];
    [tempAppDelegate.mainNavigationController pushViewController:detail animated:YES];
}


-(void)tapAction4
{
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    MoreShareViewController *more = [[MoreShareViewController alloc]init];
    more.stuff = self.comdataArr[0];
    [tempAppDelegate.LeftSlideVC closeLeftView];
    [tempAppDelegate.mainNavigationController pushViewController:more animated:YES];
}


-(void)tapAction5
{
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    MoreShareViewController *more = [[MoreShareViewController alloc]init];
    more.stuff = self.comdataArr[1];
    [tempAppDelegate.LeftSlideVC closeLeftView];
    [tempAppDelegate.mainNavigationController pushViewController:more animated:YES];
}

-(void)tapAction6
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    MoreShareViewController *more = [[MoreShareViewController alloc]init];
    more.stuff = self.comdataArr[2];
    [tempAppDelegate.LeftSlideVC closeLeftView];
    [tempAppDelegate.mainNavigationController pushViewController:more animated:YES];
}

-(void)tapAction7
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    MoreShareViewController *more = [[MoreShareViewController alloc]init];
    more.stuff = self.comdataArr[3];
    [tempAppDelegate.LeftSlideVC closeLeftView];
    [tempAppDelegate.mainNavigationController pushViewController:more animated:YES];
}




// "更多"点击事件
-(void)moreButton1Action:(UIButton *)sender
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    AllCategoryTableViewController *all = [[AllCategoryTableViewController alloc]init];
    
    [tempAppDelegate.LeftSlideVC closeLeftView];
    
    [tempAppDelegate.mainNavigationController pushViewController:all animated:YES];
    
}
-(void)moreButton1Action
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    AllCategoryTableViewController *all = [[AllCategoryTableViewController alloc]init];
    
    [tempAppDelegate.LeftSlideVC closeLeftView];
    
    [tempAppDelegate.mainNavigationController pushViewController:all animated:YES];
}
-(void)moreButton2Action:(UIButton *)sender
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    MoreShareTableViewController *more = [[MoreShareTableViewController alloc]init];
    
    [tempAppDelegate.LeftSlideVC closeLeftView];
    
    [tempAppDelegate.mainNavigationController pushViewController:more animated:YES];
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
