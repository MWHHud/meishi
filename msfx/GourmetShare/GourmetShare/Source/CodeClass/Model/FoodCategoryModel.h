//
//  FoodCategoryModel.h
//  GourmetShare
//
//  Created by jang on 15/10/15.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodCategoryModel : NSObject

@property (nonatomic,strong)NSMutableArray *list;//菜品种类列表
@property (nonatomic,strong)NSString *name;//菜品分类名
@property (nonatomic,strong)NSString *parentId;//分类ID

@end
