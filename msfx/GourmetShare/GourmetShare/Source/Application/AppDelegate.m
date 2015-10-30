//
//  AppDelegate.m
//  GourmetShare
//
//  Created by jang on 15/10/15.
//  Copyright (c) 2015年 jang. All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Reachability.h"
#import "RegisterDataTool.h"
#import "UserInfoModle.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    // 实例化一个网络判断工具的对象
    Reachability *ablity = [Reachability reachabilityForInternetConnection];
    
    if (ablity.currentReachabilityStatus == ReachableViaWiFi) {
        [ud setValue:@"wifi" forKey:@"curNetStatus"];
    }
    else if(ablity.currentReachabilityStatus == ReachableViaWWAN)
    {
        [ud setValue:@"3G" forKey:@"curNetStatus"];
    }
    else if(ablity.currentReachabilityStatus == NotReachable)
    {
        [ud setValue:@"none" forKey:@"curNetStatus"];
        
    }
    
    [ablity startNotifier];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkStatusChanged:) name:kReachabilityChangedNotification object:ablity];
    
    
    
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MainPageViewController *mainVC = [[MainPageViewController alloc] init];
    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
    self.window.rootViewController = self.LeftSlideVC;
    [AVOSCloud setApplicationId:@"DaQm5YhilP9COj1beEYipuM1"
                      clientKey:@"Gl0QDkWpsyzUJqPA7PSGdUyQ"];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
     
        AVQuery *queryemail = [AVQuery queryWithClassName:@"_User"];
        
        [queryemail whereKey:@"email" equalTo:currentUser.username];
        
        if ([queryemail findObjects].count > 0) {
            AVObject *q = [queryemail findObjects][0];

            [RegisterDataTool shareRegisterData].userInfo = [[UserInfoModle alloc]init];

            [[RegisterDataTool shareRegisterData].userInfo setValuesForKeysWithDictionary:[q valueForKey:@"localData"]];
            
            [RegisterDataTool shareRegisterData].userInfo.email = currentUser.username;
        }
        [RegisterDataTool shareRegisterData].LoginName = currentUser.username;
    }
     return YES;
}
-(void)networkStatusChanged:(NSNotificationCenter *)sender
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    // 实例化一个网络判断工具的对象
    Reachability *ablity = [Reachability reachabilityForInternetConnection];
    
    if (ablity.currentReachabilityStatus == ReachableViaWiFi) {
        [ud setValue:@"wifi" forKey:@"curNetStatus"];
    }
    else if(ablity.currentReachabilityStatus == ReachableViaWWAN)
    {
        [ud setValue:@"3G" forKey:@"curNetStatus"];
    }
    else if(ablity.currentReachabilityStatus == NotReachable)
    {
        [ud setValue:@"none" forKey:@"curNetStatus"];
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
       [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
       return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GourmetShare" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
   
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GourmetShare.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
      
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
       
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            
            abort();
        }
    }
}

@end
