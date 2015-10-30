//
//  DetailTableViewController.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 jang. All rights reserved.
//

#import "DetailTableViewController.h"
#import "TitleTableViewCell.h"
#import "ImtroTableViewCell.h"
#import "TagsTableViewCell.h"
#import "IngredientsTableViewCell.h"
#import "StepTableViewCell.h"
#import "BurdenTableViewCell.h"
#import "DataBaseHandler.h"
#import "CollectTableViewController.h"
#import "GetFavouriteDataTool.h"

@interface DetailTableViewController ()<UMSocialUIDelegate>
@property(nonatomic,strong)NSMutableArray *groupArr;
@property(nonatomic,strong)NSMutableDictionary *dataDic;
@property(nonatomic,strong)NSMutableArray *stepArr;// 步骤数组
@property(nonatomic,strong)NSMutableString *pic_url;// 标题图片


@property(nonatomic,strong)NSMutableArray *ingreArr;// 食材数组
@property(nonatomic,strong)NSMutableArray *burdenArr;// 配料数组
@property(nonatomic,strong)NSMutableString *s;
@property(nonatomic,strong)ImtroTableViewCell *ic;// 简介cell

@property(nonatomic,assign)BOOL flag;
@property(nonatomic,assign)CGFloat height; // 返回简介的高度
@property(nonatomic,assign)CGFloat stepheight;// 步骤的高度

@property (nonatomic,assign)BOOL isclick; // 收藏是否点击

@property(nonatomic,strong) NSMutableArray *screenshots;//截图cell
@property(nonatomic,assign) BOOL isShare;//是否点击分享
@property(nonatomic,assign)NSInteger indexSection;


@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isclick = NO;
    
    [self.tableView registerClass:[TitleTableViewCell class] forCellReuseIdentifier:@"title"];
    
    [self.tableView registerClass:[ImtroTableViewCell class] forCellReuseIdentifier:@"imtro"];
    
    [self.tableView registerClass:[TagsTableViewCell class] forCellReuseIdentifier:@"tags"];
    
    [self.tableView registerClass:[IngredientsTableViewCell class] forCellReuseIdentifier:@"ingredients"];
    
    [self.tableView registerClass:[StepTableViewCell class] forCellReuseIdentifier:@"step"];
    [self.tableView registerClass:[BurdenTableViewCell class] forCellReuseIdentifier:@"burden"];

    UIBarButtonItem *download = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"xiazai.png"] style:UIBarButtonItemStylePlain target:self action:@selector(downloadAction:)];
    UIBarButtonItem *share = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fenxiang.png"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction:)];
    UIBarButtonItem *collect = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"shoucang.png"] style:UIBarButtonItemStylePlain target:self action:@selector(collectAction:)];
    NSMutableArray *buttonArr = [[NSMutableArray alloc]initWithObjects:share,collect, nil];
    
    if (!self.isDownload) {
        [buttonArr addObject:download];
    }
    self.indexSection = 0;
    self.navigationItem.rightBarButtonItems = buttonArr;
    
    [self p_data];
    self.flag = YES;
    self.height = 230;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.isShare = NO;//默认分享状态为NO

}

// 简介字符串截取高度
-(CGFloat)heightforstring:(NSString *)string
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(CGRectGetWidth([[UIScreen mainScreen]bounds]) - 20, 5000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
    
}

// stepcell的截取字符串高度
-(CGFloat)heightforstring1:(NSString *)string
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(CGRectGetWidth([[UIScreen mainScreen]bounds]) / 2 - 5 , 5000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
    
}
-(void)p_data
{
    self.dataDic = [NSMutableDictionary dictionary];
    self.groupArr = [NSMutableArray array];
    self.ingreArr = [NSMutableArray array];
    self.burdenArr = [NSMutableArray array];
    self.stepArr = self.stuffmodel.steps;
    self.ingreArr = (NSMutableArray *)[self.stuffmodel.ingredients componentsSeparatedByString:@";"];
    self.burdenArr = (NSMutableArray *)[self.stuffmodel.burden componentsSeparatedByString:@";"];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
// 返回cell的高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 220;
    }
    else if(indexPath.section == 1)
    {
        return self.height+30;
    }
    else if(indexPath.section == 2)
    {
        return 200;
    }
    else if(indexPath.section == 3)
    {
        return 30;
    }
    else if(indexPath.section == 4)
    {
        return 30;
    }
    else
    {
        if (self.stepheight >200) {
            return self.stepheight+40;
        }
        else{
            return 200;
        }
        
    }
}
// 分组头部的高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 30;
}


// 分区头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    tableView.backgroundColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1];
    tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"detailback.png"]];
    if (section == 0) {
        return @"菜名";
    }
    else if(section == 1)
    {
        return @"简介";
    }
    else if(section == 2)
    {
        return @"食用场景";
    }
    else if(section == 3)
    {
        return @"食材和配料";
    }
    else if (section == 4)
    {
        return @"配料";
    }
    else
    {
        return @"做法和步骤";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 0) {
        
        return 1;
    }
    else if (section == 1)
    {
        return 1;
    }
    else if (section == 2)
    {
        return 1;
    }
    else if (section == 3)
    {
        return self.ingreArr.count;
    }
    else if(section == 4)
    {
        return self.burdenArr.count;
    }
    else if(section == 5)
    {
        return self.stuffmodel.steps.count;
        
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        TitleTableViewCell *title = [tableView dequeueReusableCellWithIdentifier:@"title"];
        title.albumsImage.image = [UIImage imageNamed:@"5.jpg"];
        self.pic_url = [NSMutableString string];
        for (NSMutableString *str in self.stuffmodel.albums) {
            self.pic_url = str;
        }
        [title.albumsImage sd_setImageWithURL:[NSURL URLWithString:_pic_url]];
        title.nameLabel.text = self.stuffmodel.title;

        title.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:0.5];
        title.selectionStyle = UITableViewCellSelectionStyleNone;
        return title;
    }
    else if(indexPath.section == 1)
    {
        ImtroTableViewCell *imtro = [tableView dequeueReusableCellWithIdentifier:@"imtro"];

        imtro.imtroLabel.text = self.stuffmodel.imtro;
        // 截取字符串,改变label的高度
        CGFloat tempHeight = [self heightforstring:self.stuffmodel.imtro];
        CGRect temprect = imtro.imtroLabel.frame;
        temprect.size.height = tempHeight;
        imtro.imtroLabel.frame = temprect;
        self.height = tempHeight;
        imtro.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:0.5];

        imtro.selectionStyle = UITableViewCellSelectionStyleNone;
        return imtro;

    }
    else if (indexPath.section == 2)
    {
        
        TagsTableViewCell *tags = [tableView dequeueReusableCellWithIdentifier:@"tags"];

        tags.tagsLabel.text = self.stuffmodel.tags;

        tags.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:0.5];
        tags.selectionStyle = UITableViewCellSelectionStyleNone;
        return tags;
    }
    else if (indexPath.section == 3)
    {
        IngredientsTableViewCell *ingredients = [tableView dequeueReusableCellWithIdentifier:@"ingredients"];

        //ingredients.nameLabel.text = self.ingreArr[indexPath.row];
        // 把数组赋给s
        NSString *s = [NSString stringWithFormat:@"%@",self.ingreArr[indexPath.row]];
        // 通过截取s取得数组arr
        NSArray *arr = [s componentsSeparatedByString:@","];
        ingredients.nameLabel.text = [arr objectAtIndex:0];
        ingredients.numLabel.text = [arr objectAtIndex:1];

        ingredients.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:0.5];
        ingredients.selectionStyle = UITableViewCellSelectionStyleNone;
        return ingredients;
    }
    else if (indexPath.section == 4)
    {
        BurdenTableViewCell *burden = [tableView dequeueReusableCellWithIdentifier:@"burden"];
        NSString *s1 = [NSString stringWithFormat:@"%@",self.burdenArr[indexPath.row]];
        NSArray *arr1 = [s1 componentsSeparatedByString:@","];
        burden.nameLabel.text = [arr1 objectAtIndex:0];
        burden.numLabel.text = [arr1 objectAtIndex:1];
        burden.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:0.5];
        burden.selectionStyle = UITableViewCellSelectionStyleNone;
        return burden;
    }
    else if(indexPath.section == 5)
    {
        StepTableViewCell *step = [tableView dequeueReusableCellWithIdentifier:@"step"];

        [step.stepImage sd_setImageWithURL:[NSURL URLWithString:[self.stepArr[indexPath.row] objectForKey:@"img"]]];
        //[NSURL URLWithString:[self.stepArr[indexPath.row] objectForKey:@"img"]]
        //[step.stepImage ];
        step.stepLabel.text = [self.stepArr[indexPath.row] objectForKey:@"step"];
        CGFloat tempHeight = [self heightforstring1:[self.stepArr[indexPath.row] objectForKey:@"step"]];
        CGRect temprect = step.stepLabel.frame;
        temprect.size.height = tempHeight;
        step.stepLabel.frame = temprect;
        self.stepheight = tempHeight;
        
        step.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:0.5];
        step.selectionStyle = UITableViewCellSelectionStyleNone;
        return step;
    }
    return 0;
    
    // Configure the cell...
    
}

// 下载
-(void)downloadAction:(UIBarButtonItem *)sender
{
    if ([[DataBaseHandler shareGetFoodData]insertDownloadWithStuffModle:self.stuffmodel]) {
    [self p_showAlertView:@"提示" message:@"下载成功"];
    }else
    {
    [self p_showAlertView:@"提示" message:@"下载失败"];
    }
    
}

//显示提示框
- (void)p_showAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}
// 分享
-(void)shareAction:(UIBarButtonItem *)sender
{
    self.screenshots = [NSMutableArray array];
    self.isShare = YES;//点击分享
    self.indexSection = 0;
    [self.tableView reloadData];
    self.tableView.contentOffset = CGPointMake(0, 0);//从tableview（0，0）处开始截图
    
    //获取tableviewContentSize大小
    CGRect shareContentSize = CGRectMake(0, 0, self.tableView.contentSize.width, self.tableView.contentSize.height);
    
    //获取tableview的indexPaths集合
    NSArray *indexPaths = [self.tableView indexPathsForRowsInRect:shareContentSize];
    
    
    for (NSIndexPath *tempImdexPath in indexPaths) {
        //循环选中每个cell
        [self.tableView selectRowAtIndexPath:tempImdexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        //触发选中事件
        if ([self.tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:tempImdexPath];
        }
    }
    [self.tableView reloadData];
    //合成完整图片
    UIImage *image = [self verticalImageFromArray:_screenshots];
    image = [UIImage imageWithData:UIImageJPEGRepresentation(image, 0.1)];// 比例压缩
    //分享截图结束
    self.isShare = NO;
    
    //调整contentOffset
    self.tableView.contentOffset = CGPointMake(0, self.tableView.contentOffset.y -200);
    
    // 分享到新浪微博
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:@"从美食分享街APP分享"
                                     shareImage:image
                                shareToSnsNames:@[UMShareToSina]
                                       delegate:self];
    

    
    
    
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"分享成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"分享失败,请重新分享" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
// 收藏
-(void)collectAction:(UIBarButtonItem *)sender
{
    NSString *userName = [RegisterDataTool shareRegisterData].LoginName;
    if (userName == nil) {
        [self p_showAlertView:@"提示" message:@"未登录"];
    }
    else
    {
        if ([[GetFavouriteDataTool shareFavouriteData]podFavouriteWith:self.stuffmodel UserName:userName]) {
            [self p_showAlertView:@"提示" message:@"已收藏"];
        }
    }
}


- (UIImage*) imageWithUIView:(UIView*) view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)verticalImageFromArray:(NSArray *)imagesArray
{
    UIImage *unifiedImage = nil;
    CGSize totalImageSize = [self verticalAppendedTotalImageSizeFromImagesArray:imagesArray];
    UIGraphicsBeginImageContextWithOptions(totalImageSize, NO, 0.f);
    // For each image found in the array, create a new big image vertically
    int imageOffsetFactor = 0;
    for (UIImage *img in imagesArray) {
        [img drawAtPoint:CGPointMake (0, imageOffsetFactor)];
        imageOffsetFactor += img.size.height;
    }
    
    unifiedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return unifiedImage;
}

- (CGSize)verticalAppendedTotalImageSizeFromImagesArray:(NSArray *)imagesArray
{
    CGSize totalSize = CGSizeZero;
    for (UIImage *im in imagesArray) {
        CGSize imSize = [im size];
        totalSize.height += imSize.height;
        // The total width is gonna be always the wider found on the array
        totalSize.width = MAX(totalSize.width, imSize.width);
    }
    return totalSize;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //分享状态开始截图
    if (_isShare) {
        
        if (indexPath.section == _indexSection) {
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
            UITableViewHeaderFooterView *headView = [tableView headerViewForSection:indexPath.section];
            UIImage *tempHeadImage = [self imageWithUIView:headView];
            if (tempHeadImage != nil) {
                [_screenshots addObject: tempHeadImage];
                self.tableView.contentOffset = CGPointMake(0, tableView.contentOffset.y + headView.frame.size.height);
            }
            _indexSection ++;
        }
        
        [tableView reloadData];//刷新tableview，否则无图
        //获取选中cell
        UITableViewCell *tempCell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        //获取当前cell截图
        UIImage *tempImage = [self imageWithUIView:tempCell];

        
        

        //移动contentOffset加载下一行，否则cell为nil
        self.tableView.contentOffset = CGPointMake(0, self.tableView.contentOffset.y +tempCell.frame.size.height);
        
        if (tempImage != nil) {
            [_screenshots addObject: tempImage];//加入截图数组
        }
        
    }
}



@end
