//
//  GetFoodDataTool.h
//  GourmetShare
//
//  Created by jang on 15/10/15.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PassValue)(NSArray *array);
typedef void(^PassID)(NSString *ID);
typedef void(^Stuff)(StuffModle *stuff);

@interface GetFoodDataTool : NSObject

@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,strong)NSMutableArray *dataListArr;


//美食数据加载工具类（私有数据库加载/云数据库加载/JOSN接口加载（未处理））


//单例初始化工具类
+(GetFoodDataTool *)shareGetFoodData;

//返回美食总数据
-(void)getFoodDataWithPassValue:(PassValue)passValue;

//根据大分类名返回（标签集合）数据
-(NSArray *)getModleWithName:(NSString *)name;
-(void)getModleWithName:(NSString *)name PassValue:(PassValue)passVallue;

//根据大分类ID返回（标签集合）数据
-(NSArray *)getModleWithParentId:(NSString *)parentId;
-(void)getModleWithParentId:(NSString *)parentId PassValue:(PassValue)passVallue;
-(void)getListWithParentId:(NSString *)parentId  PassValue:(PassValue)passVallue;

//根据index返回（标签集合）数据
-(NSArray *)getModleWithIndex:(NSInteger)index;

//根据大分类 ID 和 标签 名返回 标签ID
-(NSString *)getIdWithParentId:(NSString *)parentId Name:(NSString *)name;
-(void)getIdWithParentId:(NSString *)parentId Name:(NSString *)name PassId:(PassID)passId;


//根据标签ID返回（菜谱列表）数据
-(NSArray *)getFoodListInfoWithId:(NSString *)lid;
-(void)getFoodListInfoWithId:(NSString *)lid PassValue:(PassValue)passVallue;
-(void)getFoodListInfoWithName:(NSString *)name PassValue:(PassValue)passVallue;




//根据菜谱ID返回菜谱数据
-(StuffModle *)getFoodInfoWithSid:(NSString *)sid;
-(StuffModle *)getPopFoodInfoWithSid:(NSString *)sid;
-(void)getFoodInfoWithSid:(NSString *)sid stuff:(Stuff)stuff;



@end
