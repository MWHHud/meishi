//
//  GetFavouriteDataTool.h
//  GourmetShare
//
//  Created by jang on 15/10/22.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
typedef void(^PassValue)(NSArray *array);
@interface GetFavouriteDataTool : NSObject

@property (nonatomic,strong)AVObject *postFavourite;

//单例初始化工具类
+(GetFavouriteDataTool *)shareFavouriteData;

//收藏食谱
-(BOOL)podFavouriteWith:(StuffModle *)stuff UserName:(NSString *)userName;

//获取收藏
-(void)getFavouriteWithUserName:(NSString *)userName PassValue:(PassValue)passVallue;

//删除收藏
-(void)deleteFavouriteWith:(StuffModle *)stuff UserName:(NSString *)userName;

@end
