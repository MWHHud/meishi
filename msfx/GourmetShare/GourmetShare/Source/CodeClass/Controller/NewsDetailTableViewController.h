//
//  NewsDetailTableViewController.h
//  GourmetShare
//
//  Created by lanou3g on 15/10/19.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;
@class NewsDetail;
@interface NewsDetailTableViewController : UITableViewController
@property(nonatomic,strong)News *news;
@property(nonatomic,strong)NSString *newid;
@property(nonatomic,strong)NewsDetail *detailnews;
@end
