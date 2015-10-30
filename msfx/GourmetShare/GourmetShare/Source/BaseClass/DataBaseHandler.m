//
//  DataBaseHandler.m
//  GourmetShare
//
//  Created by jang on 15/10/16.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "DataBaseHandler.h"
static DataBaseHandler *dbh;

@implementation DataBaseHandler

//单例初始化工具类
+(DataBaseHandler *)shareGetFoodData
{
    static dispatch_once_t once_token;
    if (dbh == nil) {
        dispatch_once(&once_token, ^{
            dbh = [[DataBaseHandler alloc]init];
        });
    }
    return dbh;
}

- (NSString *)databaseFilePath
{
    //数据库路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingString:@"/food.sqlite"];
    return dbPath;
}

- (NSString *)dataImageFilePath
{
    //图片文件夹
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingString:@"/food.sqlite"];
    return dbPath;
}

-(FMDatabase *)db
{
    if (_db == nil) {
        self.db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    }
    return _db;
}


#pragma mark ========================Category

- (void)createTable
{
    self.db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![_db open]) {
        return;
    }
    
    //为数据库设置缓存，提高查询效率
    [_db setShouldCacheStatements:YES];
    
    //判断数据库中是否已经存在这个表，如果不存在则创建该表
    if(![_db tableExists:@"postCategory"])
    {
        if ([_db executeUpdate:@"CREATE TABLE postCategory(name TEXT, parentId TEXT) "]) {
        }
    }
}

- (void)insertFoodCategoryWith:(NSArray *)foodArr;
{
    [self createTable];
    if (![_db open]) {
        // error
        return;
    }
    
    for (FoodCategoryModel *f in foodArr) {
        
        NSString *sql = @"insert into postCategory (name, parentId) values (?, ?)";
        [_db executeUpdate:sql, f.name, f.parentId];
        
    }
    
    [_db close];
}
- (NSArray *)getAllCategory
{
    self.db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    if (![_db open]) {
        return nil;
    }
    
    
    if(![_db tableExists:@"postCategory"])
    {
        return nil;
    }
    
    //定义一个可变数组，用来存放查询的结果，返回给调用者
    NSMutableArray *CategoryArray = [NSMutableArray array];
    //定义一个结果集，存放查询的数据
    FMResultSet *rs = [_db executeQuery:@"select * from postCategory"];
    //判断结果集中是否有数据，如果有则取出数据
    while ([rs next]) {
        FoodCategoryModel *f = [[FoodCategoryModel alloc] init];
        
        f.name = [rs stringForColumn:@"name"];
        f.parentId = [rs stringForColumn:@"parentId"];
        //将查询到的数据放入数组中。
        [CategoryArray addObject:f];
    }
    return CategoryArray;
}

#pragma mark ========================List

- (void)createPostListTable
{
    self.db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![_db open]) {
        return;
    }
    
    //为数据库设置缓存，提高查询效率
    [_db setShouldCacheStatements:YES];
    
    //判断数据库中是否已经存在这个表，如果不存在则创建该表
    if(![_db tableExists:@"postList"])
    {
        if ([_db executeUpdate:@"CREATE TABLE postList(lid TEXT ,name TEXT, parentId TEXT) "]) {
        }
    }
}

- (void)insertPostListWith:(NSArray *)listArr
{
    [self createPostListTable];
    if (![_db open]) {
        // error
        return;
    }
    
    for (FoodListModle *f in listArr) {
        
        NSString *sql = @"insert into postList (lid, name, parentId) values (?, ?, ?)";
        [_db executeUpdate:sql, f.lid, f.name, f.parentId];
        
    }
    
    [_db close];
}

- (NSArray *)findListByName:(NSString *)name
{
    self.db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    if (![_db open]) {
        return nil;
    }
    
    
    if(![_db tableExists:@"postList"])
    {
        return nil;
    }
    
    //定义一个可变数组，用来存放查询的结果，返回给调用者
    NSMutableArray *ListArray = [NSMutableArray array];
    //定义一个结果集，存放查询的数据
    FMResultSet *rs = [_db executeQuery:@"select * from postList where name = ?",name];
    //判断结果集中是否有数据，如果有则取出数据
    while ([rs next]) {
        FoodListModle *f = [[FoodListModle alloc] init];
        
        f.lid = [rs stringForColumn:@"lid"];
        f.name = [rs stringForColumn:@"name"];
        f.parentId = [rs stringForColumn:@"parentId"];
        //将查询到的数据放入数组中。
        [ListArray addObject:f];
    }
    return ListArray;
}

- (NSArray *)findListByParentId:(NSString *)parentId
{
    self.db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    if (![_db open]) {
        return nil;
    }
    
    
    if(![_db tableExists:@"postList"])
    {
        return nil;
    }
    
    //定义一个可变数组，用来存放查询的结果，返回给调用者
    NSMutableArray *ListArray = [NSMutableArray array];
    //定义一个结果集，存放查询的数据
    FMResultSet *rs = [_db executeQuery:@"select * from postList where parentId = ?",parentId];
    //判断结果集中是否有数据，如果有则取出数据
    while ([rs next]) {
        FoodListModle *f = [[FoodListModle alloc] init];
        
        f.lid = [rs stringForColumn:@"lid"];
        f.name = [rs stringForColumn:@"name"];
        f.parentId = [rs stringForColumn:@"parentId"];
        //将查询到的数据放入数组中。
        [ListArray addObject:f];
    }
    if (ListArray.count == 0) {
        return nil;
    }
    return ListArray;
}

#pragma mark ========================Stuff

- (void)createPostStuffTable
{
    self.db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![_db open]) {
        return;
    }
    
    //为数据库设置缓存，提高查询效率
    [_db setShouldCacheStatements:YES];
    
    //判断数据库中是否已经存在这个表，如果不存在则创建该表
    if(![_db tableExists:@"postStuff"])
    {
        if ([_db executeUpdate:@"CREATE TABLE postStuff(lid TEXT ,albums TEXT, burden TEXT,sid TEXT ,imtro TEXT, ingredients TEXT,steps TEXT ,tags TEXT, title TEXT) "]) {
 
        }
    }
}


- (void)insertPostStuffWithStuffArr:(NSArray *)stuff lib:(NSString *)lib;
{
    
    [self createPostStuffTable];
    if (![_db open]) {
      
        return;
    }
    
    for (StuffModle *s in stuff) {
        
        [self insertSql:s lid:lib];
    }
    
    [_db close];
    
}
- (void)insertPostStuffWithStuffModle:(StuffModle *)stuffModle lib:(NSString *)lib;
{
    [self createPostStuffTable];
    if (![_db open]) {
       
        return;
    }
    [self insertSql:stuffModle lid:lib];
    
    [_db close];
}


-(void)insertSql:(StuffModle *)s lid:(NSString *)lid
{
    
    NSString *sql = @"insert into postStuff (lid, albums, burden, sid, imtro, ingredients, steps, tags, title) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    NSError *err = nil;
    
    NSData *stepsJsonData = [NSJSONSerialization dataWithJSONObject:s.steps options:NSJSONWritingPrettyPrinted error:&err];
    
    NSString *jsonStrSteps = [[NSString alloc] initWithData:stepsJsonData encoding:NSUTF8StringEncoding];
    
    NSData *albumsJsonData = [NSJSONSerialization dataWithJSONObject:s.albums options:NSJSONWritingPrettyPrinted error:&err];
    
    NSString *jsonStrAlbums = [[NSString alloc] initWithData:albumsJsonData encoding:NSUTF8StringEncoding];
    
    
    [_db executeUpdate:sql, lid, jsonStrAlbums, s.burden, s.sid, s.imtro, s.ingredients, jsonStrSteps, s.tags, s.title];
}

- (NSArray *)findStuffByLid:(NSString *)lid
{
    NSString *sql =[NSString stringWithFormat:@"select * from postStuff where lid = %@",lid] ;
    return [self findStuffSql:sql];
}
- (StuffModle *)findStuffBySid:(NSString *)sid
{
    NSString *sql = [NSString stringWithFormat:@"select * from postStuff where sid = %@",sid];
    ;
    return (StuffModle *)[self findStuffSql:sql][0];
}

-(NSArray *)findStuffSql:(NSString *)sql
{
    self.db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    if (![_db open]) {
        return nil;
    }
    
    if(![_db tableExists:@"postStuff"])
    {
        return nil;
    }
    
    //定义一个可变数组，用来存放查询的结果，返回给调用者
    NSMutableArray *ListArray = [NSMutableArray array];
    //定义一个结果集，存放查询的数据
    FMResultSet *rs = [_db executeQuery:sql];
    //判断结果集中是否有数据，如果有则取出数据
    while ([rs next]) {
        StuffModle *s = [[StuffModle alloc] init];
        
        NSString *strAlbums = [rs stringForColumn:@"albums"];
        NSMutableArray *arrAlbums =(NSMutableArray *)[strAlbums objectFromJSONString];
        s.albums = arrAlbums;
        s.burden = [rs stringForColumn:@"burden"];
        s.sid = [rs stringForColumn:@"sid"];
        s.imtro = [rs stringForColumn:@"imtro"];
        s.ingredients = [rs stringForColumn:@"ingredients"];
        NSString *str = [rs stringForColumn:@"steps"];
        NSDictionary *d =(NSDictionary *)[str objectFromJSONString];
        NSMutableArray *arr = [NSMutableArray array];
        for (StepModle *st in d) {
            [arr addObject:st];
        }
        s.steps = arr;
        s.tags = [rs stringForColumn:@"tags"];
        s.title = [rs stringForColumn:@"title"];
        
        //将查询到的数据放入数组中。
        [ListArray addObject:s];
    }
    if (ListArray.count == 0) {
        return nil;
    }
    return ListArray;
}

#pragma mark ========================User
- (void)createUserTable
{
    self.db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![_db open]) {
        return;
    }
    
    //为数据库设置缓存，提高查询效率
    [_db setShouldCacheStatements:YES];
    
    //判断数据库中是否已经存在这个表，如果不存在则创建该表
    if(![_db tableExists:@"User"])
    {
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE User (albums TEXT, burden TEXT,sid TEXT ,imtro TEXT, ingredients TEXT,steps TEXT ,tags TEXT, title TEXT) "];
        if ([_db executeUpdate:sql]) {
        }
    }
}

//下载到本地的菜谱
- (BOOL)insertDownloadWithStuffModle:(StuffModle *)s
{
    [self createUserTable];
    if (![_db open]) {
        // error
        return NO;
    }
    if ([self findDownloadStuffBySid:s.sid]) {
        return YES;
    }
    NSString *sql = [NSString stringWithFormat:@"insert into User (albums, burden, sid, imtro, ingredients, steps, tags, title) values (?, ?, ?, ?, ?, ?, ?, ?)"];
    NSError *err = nil;
    
    NSData *stepsJsonData = [NSJSONSerialization dataWithJSONObject:s.steps options:NSJSONWritingPrettyPrinted error:&err];
    

    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    dispatch_async(globl_t, ^{
        for (StepModle *st in s.steps) {
            [self downloadWithURL:[st valueForKey:@"img"] Sid:s.sid];
        }
        
        for (NSString *str in s.albums) {
            [self downloadWithURL:str Sid:s.sid];
        }
    });
    NSString *jsonStrSteps = [[NSString alloc] initWithData:stepsJsonData encoding:NSUTF8StringEncoding];
    
    NSData *albumsJsonData = [NSJSONSerialization dataWithJSONObject:s.albums options:NSJSONWritingPrettyPrinted error:&err];
    
    NSString *jsonStrAlbums = [[NSString alloc] initWithData:albumsJsonData encoding:NSUTF8StringEncoding];
    
    BOOL isInsert =  [_db executeUpdate:sql,jsonStrAlbums, s.burden, s.sid, s.imtro, s.ingredients, jsonStrSteps, s.tags, s.title];
    
    [_db close];
    
    return isInsert;
}

- (NSArray *)findStuff
{
    NSString *sql =[NSString stringWithFormat:@"select * from User"] ;
    return [self findStuffSql:sql];
}

- (BOOL)findDownloadStuffBySid:(NSString *)sid
{
    NSString *sql = [NSString stringWithFormat:@"select * from User where sid = %@",sid];
    ;
    if ([self findStuffSql:sql] != 0) {
        return YES;
    }
    return NO;
}


//删除下载
- (BOOL)deleteDownloadWithStuffModle:(StuffModle *)s
{
    [self createUserTable];
    if (![_db open]) {
        // error
        return NO;
    }
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    dispatch_async(globl_t, ^{
        for (NSString *str in s.albums) {
            [self deleteFile:str Sid:s.sid];
        }
        for (StepModle *st in s.steps) {
            [self deleteFile:[st valueForKey:@"img"] Sid:s.sid];
        }
    });
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM User WHERE sid = %@",s.sid];
    return [self.db executeUpdate:sql];
}

-(void)deleteFile:(NSString *)aURL Sid:(NSString *)sid
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    //文件名
    NSString *uniquePath = [self imageFilePath:aURL Sid:sid];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        return ;
    }else {
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {

        }else {
        }
        
    }
}


//返回图片文件路径
- (NSString *)imageFilePath:(NSString *)aURL Sid:(NSString *)sid
{
    
    //新建文件夹
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSFileManager *managerFile = [NSFileManager defaultManager];
    
    if (![managerFile fileExistsAtPath:[documentPath stringByAppendingString:@"/FoodImage"]]) {
        [managerFile createDirectoryAtPath:[documentPath stringByAppendingString:@"/FoodImage"] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //并给文件起个文件名
    NSArray *parArray = [aURL componentsSeparatedByString:@"/"];
    NSString *fileName = [NSString stringWithFormat:@"/FoodImage/%@-%@",sid,[parArray lastObject]];
    NSString *filePath = [documentPath stringByAppendingString:fileName];
    
    return filePath;
}


//下载到本地的图片
- (void)downloadWithURL:(NSString *)aURL  Sid:(NSString *)sid
{
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    dispatch_async(globl_t, ^{
        
        NSFileManager *managerFile = [NSFileManager defaultManager];
        
        NSString *filePath = [self imageFilePath:aURL Sid:sid];
        
        if (![managerFile fileExistsAtPath:filePath]) {
            //将图片下载下来
            UIImage *fileImage = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:aURL]]];
            
            //将图片写到Documents文件
            [UIImagePNGRepresentation(fileImage)writeToFile: filePath  atomically:YES];
        }
    });
}



@end
