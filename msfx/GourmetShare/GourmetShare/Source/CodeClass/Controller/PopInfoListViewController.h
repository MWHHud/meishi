//
//  PopInfoListViewController.h
//  GourmetShare
//
//  Created by jang on 15/10/15.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopInfoListViewController : UITableViewController
-(void)refreshStateChange:(UIRefreshControl *)control;
-(void)setupRefresh;
@end
