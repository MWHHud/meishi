//
//  GetNewsDataTool.h
//  GourmetShare
//
//  Created by jang on 15/10/18.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PassValue)(NSArray *array);

@interface GetNewsDataTool : NSObject

@property (nonatomic,strong)NSMutableArray *dataArr;

//单例初始化工具类
+ (GetNewsDataTool *)shareGetNewsData;

//返回新闻信息
- (void)getNewsDataWithPassValue:(PassValue)passValue;

@end
