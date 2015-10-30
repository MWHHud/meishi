//
//  LoginDataTool.h
//  GourmetShare
//
//  Created by jang on 15/10/21.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PassValue)(NSArray *array);

@interface LoginDataTool : NSObject

+(LoginDataTool *)shareLoginData;

@property (nonatomic,strong)AVObject *postNew;

@property (nonatomic,strong)AVObject *postStuffModle;

-(BOOL)NewFavoriteWithNew:(News *)aNew;

-(BOOL)FoodFavoriteWithStuffModle:(StuffModle *)stuff;

//返回美食收藏
- (void)getFoodDataWithName:(NSString *)name PassValue:(PassValue)passValue;

//返回新闻收藏
- (void)getNewsDataWithName:(NSString *)name PassValue:(PassValue)passValue;

@end
