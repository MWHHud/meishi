//
//  CategoryDetailTableViewController.h
//  GourmetShare
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodListModle;
@interface CategoryDetailTableViewController : UITableViewController
@property(nonatomic,strong)FoodListModle *flmodel;
@property(nonatomic,strong)NSString *parid;
@end
