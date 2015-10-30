//
//  APPHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里存放普通的app宏定义和声明等信息.

#ifndef Project_APPHeader_h
#define Project_APPHeader_h

#import "AppDelegate.h"
#import "MainPageViewController.h"
#import "LeftSortsViewController.h"
#import "PopInfoListViewController.h"
#import "GourmetMainViewController.h"
#import "PrivateListViewController.h"

#import "AllCategoryTableViewController.h"
#import "CategoryDetailTableViewController.h"
#import "CategoryDetailTableViewCell.h"
#import "DetailMenuTableViewController.h"
#import "DetailTableViewController.h"


#import "FoodCategoryModel.h"
#import "FoodListModle.h"
#import "StuffModle.h"
#import "StepModle.h"
#import "News.h"

#import "RegisterModer.h"


#import "PopNews.h"
#import "NewsDetail.h"





#import "GetFoodDataTool.h"
#import "GetNewsDataTool.h"
#import "RegisterDataTool.h"



#define kScreenSize           [[UIScreen mainScreen] bounds].size
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

#define KisEqual @"no"

#import "LoginViewController.h"
#import "MoreShareViewController.h"

#import "SearchViewController.h"
#import "SearchDataTool.h"





































//TODO 提示
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
// 最终使用下面的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))


#endif
