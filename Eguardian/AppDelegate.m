//
//  AppDelegate.m
//  CampusManager
//
//  Created by apple on 13-3-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "THomeViewController.h"
#import "InitProject.h"
#import "NetTools.h"
#import "JSONProcess.h"
#import "LoginManager.h"
#import "ConfigManager.h"
#import "AdvertisingManager.h"

@implementation AppDelegate
@synthesize displayPanel;
@synthesize window = _window;
- (void)dealloc
{
    [displayPanel release];
    [_window release];
    [super dealloc];
}


//delegate


- (void) N_didFinsh:(id)tempData dataMessage:(NSString *) msg
{
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [JSONProcess configProcess:tempData];
                       [[AdvertisingManager sharedAdvertisingManager] request];
                       sleep(2.0);
                       
                       [[self.window viewWithTag:11] removeFromSuperview];
                       UINavigationController *nav = [[UINavigationController alloc] init];
                       self.window.rootViewController = nav;
                       [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBG.png"] forBarMetrics:UIBarMetricsDefault];
                       
                       LoginManager *manager = [LoginManager sharedLoginManager];
                       [nav pushViewController:manager.loginViewController animated:YES];
                       [nav release];
                       
                       //                        THomeViewController *vc = [[THomeViewController alloc] init];
                       //                        UINavigationController *nav = [[UINavigationController alloc] init];
                       //                        self.window.rootViewController = nav;
                       //                        [nav pushViewController:vc animated:YES];
                       //                        [vc release];
                       //                        [nav release];
                       
                       
                       
                       
                       
                   });
}

- (void) N_Error:(NSError *)error dataMessage:(NSString *) msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉，无法正常获取服务器数据"
                                                   message:@"请您检查一下网络是否正常"
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"确认",nil];
    [alert show];
    [alert release];
}


-(void) firstRequest
{
    //加载配置文件
    InitProject *it = [[InitProject alloc] init];
    [it loadConfig];
    [it release];
    
    
    
    
    
    //访问网络
    NSString *dynamic_config_url = [[ConfigManager sharedConfigManager].configData objectForKey:@"dynamic_config_url"];
    NSString *date_created = [[ConfigManager sharedConfigManager].configData objectForKey:@"date_created"];
    NSString *new_url = [NSString stringWithFormat:@"%@?date_created=%@",dynamic_config_url,date_created];
    NSString *api_key_name = [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_name"];
    NSString *api_key_value = [[ConfigManager sharedConfigManager].configData objectForKey:@"api_key_value"];
    NSMutableDictionary *msg = [NSMutableDictionary dictionaryWithObjectsAndKeys:api_key_value,api_key_name, nil];
    
    NetTools *netTools = [[NetTools alloc] initWithURL:new_url httpMsg:msg delegate:self];
    [netTools downloadAndSave:@"config"];
    [netTools release];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    {
        displayPanel = [[DisplayPanel alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
        displayPanel.userInteractionEnabled = YES;
        displayPanel.hidden = YES;
        [self.window addSubview:displayPanel];
    }
    
    UIImageView *tempView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
    tempView.tag = 11;
    tempView.frame = CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height);
    [self.window addSubview:tempView]; [tempView release];
    [self.window makeKeyAndVisible];
    [ConfigManager sharedConfigManager].isLeader = FALSE;
    [self firstRequest];
    
    
    {
        //通知
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
        
        NSDictionary* payload = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        //后台通知弹出
        if (payload)
        {
            NSString* alertStr = nil;
            NSDictionary *apsInfo = [payload objectForKey:@"aps"];
            NSObject *alert = [apsInfo objectForKey:@"alert"];
            if ([alert isKindOfClass:[NSString class]])
            {
                alertStr = (NSString*)alert;
            }
            else if ([alert isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* alertDict = (NSDictionary*)alert;
                alertStr = [alertDict objectForKey:@"body"];
            }
            application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
            if ([application applicationState] == UIApplicationStateActive && alertStr != nil)
            {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:alertStr delegate:nil
                                                          cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }
        }
        
    }
    
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}



//通知
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString* deviceTokenString = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    [ConfigManager sharedConfigManager].deviceToken = deviceTokenString;
    NSLog(@"设备信息 %@", deviceTokenString);
}

//注册push功能失败 后 返回错误信息，执行相应的处理
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSLog(@"Push Register Error:%@", err.description);
}


//前台通知处理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)payload
{
    
    NSString* alertStr = nil;
    NSDictionary *apsInfo = [payload objectForKey:@"aps"];
    NSObject *alert = [apsInfo objectForKey:@"alert"];
    if ([alert isKindOfClass:[NSString class]])
    {
        alertStr = (NSString*)alert;
    }
    else if ([alert isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* alertDict = (NSDictionary*)alert;
        alertStr = [alertDict objectForKey:@"body"];
    }
    application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
    if ([application applicationState] == UIApplicationStateActive && alertStr != nil)
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:alertStr delegate:nil
                                                  cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
}


@end











