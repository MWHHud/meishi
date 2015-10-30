//
//  SearchDataTool.h
//  GourmetShare
//
//  Created by jang on 15/10/26.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^PassValue)(NSArray *array);
@interface SearchDataTool : NSObject


@property (nonatomic,strong)AVQuery *query;
//单例初始化工具类
+(SearchDataTool *)shareSearchData;

//搜索
-(void)searchWithKeyword:(NSString *)keyWord PassValue:(PassValue)passValue;
@end
