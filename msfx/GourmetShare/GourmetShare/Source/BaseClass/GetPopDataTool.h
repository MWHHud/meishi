//
//  GetPopDataTool.h
//  GourmetShare
//
//  Created by lanou3g on 15/10/19.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PassValue) (NSArray *array);
typedef void(^PassID) (NSString *ID);
typedef void(^PNews) (PopNews *news);
typedef void(^PDetail) (NewsDetail *detail);

@interface GetPopDataTool : NSObject

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)NSMutableArray *detailArray;

@property(nonatomic,strong)NewsDetail *newsdetail;

//pop界面数据加载

+(GetPopDataTool *)shareGetPopData;


//返回总数据
-(void)getPopDataWithPassValue:(PassValue)passValue;

//根据index返回数据
-(PopNews *)getPopNewsWithIndex:(NSInteger)index;

//根据ID返回详情
-(void)getNewsDataWithDocid:(NSString *)docid Pdetail:(PDetail)detail;

//

@end
