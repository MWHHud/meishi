//
//  DetailTableViewController.h
//  GourmetShare
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StuffModle ;
@interface DetailTableViewController : UITableViewController
@property(nonatomic,strong)StuffModle *stuffmodel;
@property (nonatomic,assign)BOOL isDownload;
@end
