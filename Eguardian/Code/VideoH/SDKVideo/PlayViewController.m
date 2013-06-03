//
//  PlayViewController.m
//  CampusManager
//
//  Created by apple on 13-4-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PlayViewController.h"
#import "Global.h"
#import "VideoView.h"
@interface PlayViewController ()

@end

@implementation PlayViewController
@synthesize wrapper;



-(id) initWithWrapper:(CUControlWrapper *)awrapper
{
    if (self = [super init])
    {
        self.wrapper = wrapper;
        
    }
    return self;
}



//定制返回函数
-(void)backAction
{
    [wrapper stopRend];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *temp = [[VideoView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    temp.backgroundColor = [UIColor clearColor];
    self.view = temp;
    [temp release];
    
    //定制返回按钮
    {
        UIImage* image= [UIImage imageNamed:@"NavBack.png"];
        CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
        UIButton* backButton= [[UIButton alloc] initWithFrame:frame_1];
        [backButton setBackgroundImage:image forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
        [someBarButtonItem release];
        [backButton release];
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBG.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
