//
//  BaseViewController.m
//  RDOA
//
//  Created by apple on 13-3-19.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "Global.h"
#import "UIButtonEx.h"
#import "ADScrollView.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize controllerTag;
@synthesize isFirst;
@synthesize activityView;
@synthesize adScrollView;
- (void)dealloc
{

    if (adScrollView)
        [adScrollView stopDisplayLink];
    if (adScrollView)
    {
        [adScrollView release];
        adScrollView = nil;
    }
    
    
    

    
    
    
    [activityView removeFromSuperview];
    [activityView release];
    
    [super dealloc];
}


- (id)init
{
    self = [super init];
    if (self)
    {
        self.adScrollView = nil;
        isFirst = TRUE;
        controllerTag = 0;
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self loadData];
    }
    return self;
}




-(void) loadView
{
    [super loadView];
    UIImage *tempImageBG = [UIImage imageNamed:@"BgImage.png"];
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    bg.image = tempImageBG;
    bg.userInteractionEnabled = YES;
    self.view = bg;
    [bg release];
    self.activityView.frame = CGRectMake((ScreenW-100)/2, (ScreenH-100)/2, 100, 100);
    [self.view addSubview:self.activityView];
    
    
}



#pragma mark 网络下载或者读取本地数据
-(void )loadData
{
}

-(void) goBackHome
{
    UINavigationController *nav = rootNav;
    int tempCount = [nav.viewControllers count];
    for (; tempCount>2; tempCount--)
    {
        [nav popViewControllerAnimated:NO];
    }
    
}








-(void)showError
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉，无法正常获取服务器数据"
                                                   message:@"请您检查一下网络是否正常"
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"确认",nil];
    [alert show];
    [alert release];
}

-(void)showErrorMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"确认",nil];
    [alert show];
    [alert release];
}




//定制返回函数
-(void)backAction
{
    UINavigationController *nav = rootNav;
    int tempCount = [nav.viewControllers count];
    if (tempCount > 4)
        [nav popViewControllerAnimated:YES];
    else
        [nav popViewControllerAnimated:NO];
}


















@end




















































