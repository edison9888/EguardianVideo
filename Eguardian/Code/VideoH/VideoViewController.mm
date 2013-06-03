//
//  VideoViewController.m
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "VideoViewController.h"
#import "HomeWorkViewController.h"
#import "CheckWorkViewController.h"
#import "CommentViewController.h"
#import "Global.h"
#import "ConfigManager.h"
#import "VideoRequestController.h"
#import "VideoNoteManager.h"
#import "VideoNote.h"
#import "VideoPlayController.h"
#import "AppDelegate.h"

@interface VideoViewController ()

@end

@implementation VideoViewController
@synthesize videoController;
@synthesize wrapper;
@synthesize mesh;
- (void)dealloc
{
    [mesh release];
    [videoController release];
    [super dealloc];
}


//*******************************************************************************************************************************************
//*******************************************************************************************************************************************
//strar
-(void) selectControllerWithTag:(int)atag
{
    UINavigationController *nav = rootNav;
    
    if ( atag == 1 )        //email
    {
        HomeWorkViewController *vc = [[HomeWorkViewController alloc] init];
        [nav pushViewController:vc animated:YES];
        [vc release];

    }
    else if ( atag == 2 )   //book
    {
        CommentViewController *vc = [[CommentViewController alloc] init];
        [nav pushViewController:vc animated:YES];
        [vc release];
    }
    else if ( atag == 3 )   //schedule
    {
        CheckWorkViewController *vc = [[CheckWorkViewController alloc] init];
        [nav pushViewController:vc animated:YES];
        [vc release];
    }
}

-(void) footButtonAction:(UIButton *)sender
{
    
    //自己点自己没有相应
    if ( sender.tag == self.controllerTag )
        return;
    //点击首页的情况
    if ( 0 == sender.tag)
    {
        [self goBackHome];
//        [nav popViewControllerAnimated:YES];
        return;
    }
    [self selectControllerWithTag:sender.tag];
}







//定制返回函数
-(void)backAction
{
    [wrapper stopRend];
    
    UINavigationController *nav = rootNav;
    int tempCount = [nav.viewControllers count];
    for (; tempCount>2; tempCount--)
    {
        [nav popViewControllerAnimated:NO];
    }
    
    
//    [self.navigationController popViewControllerAnimated:YES];
}


-(id) init
{
    self = [super init];
    if (self)
    {
        self.controllerTag = 4;
        self.title = @"监 控";
        self.mesh = nil;
        
        NSLog(@" %d", [[VideoNoteManager sharedVideoNoteManager].notes count]);
        
    }
    return self;
}




-(void)viewDidDisappear:(BOOL)animated
{
    [self.activityView stopAnimating];
}



-(void)layoutMesh
{
    if (mesh)
    {
        for (UIView *subview in mesh.subviews)
            [subview removeFromSuperview];
    }
    else
    {
        mesh = [[UIScrollView alloc] initWithFrame:CGRectMake(0, MaxMeshY, ScreenW, ScreenH - footBarH - self.navigationController.navigationBar.frame.size.height)];
        mesh.backgroundColor = [UIColor clearColor];
        mesh.contentSize = CGSizeMake(self.view.frame.size.width, MaxMeshH);
        [self.view addSubview:mesh];
        [self.view bringSubviewToFront:mesh];
    }
    

    
    
    
    float orgx = 11;
    float orgy = 24;
    int tempCount = [[VideoNoteManager sharedVideoNoteManager].notes count];
    NSArray *tempArray = [[VideoNoteManager sharedVideoNoteManager].notes allKeys];
    
    
    if (tempCount > 0 )
    {
        for (int i=0; i<tempCount; i++)
        {
            if (i%2)
                orgx = 169;
            else
                orgx = 11;
            VideoButtonEx *temp = [[VideoButtonEx alloc] initWithFrame:CGRectMake(orgx, orgy, 137, 129) flag:TRUE];
            VideoNote *tempNote = [[VideoNoteManager sharedVideoNoteManager].notes objectForKey:[tempArray objectAtIndex:i]];
            temp.name.text = tempNote.name;
            temp.bgButton.tag = i;
            [temp.bgButton addTarget:self action:@selector(doSome:) forControlEvents:UIControlEventTouchDown];
            [mesh addSubview:temp];
            [temp release];
            
            if ( i %2 )
                orgy += 150;
        }
    }

    
    

}



-(void)viewWillAppear:(BOOL)animated
{
    
    if (!self.isFirst)
    {
        if (mesh) [self layoutMesh];        //刷新UI
        return;
    }
    self.isFirst = FALSE;
    
    float currentH = 0;
    self.navigationController.navigationBarHidden = NO;
    
    
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
    
    float navh = self.navigationController.navigationBar.frame.size.height;
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-navh-currentH);
    
    {
        UIImageView *tempImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"浏览过图标.png"]];
        tempImgView.frame = CGRectMake(19, 22, tempImgView.frame.size.width, tempImgView.frame.size.height);
        [self.view addSubview:tempImgView]; [tempImgView release];
        
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake( 52,tempImgView.frame.origin.y, 200, 18)];
        tempLabel.text = @"我浏览过的视频路线";
        tempLabel.textColor = [UIColor colorWithRed:87/255.0 green:79/255.0 blue:77/255.0 alpha:1.0];
        tempLabel.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tempLabel]; [tempLabel release];
    }
        
//    [self layoutMesh];

 
    
    [self openVideo];
    
}



-(void)doSome:(id)send
{
    NSArray *tempArray = [[VideoNoteManager sharedVideoNoteManager].notes allKeys];
    VideoNote *tempNote = [[VideoNoteManager sharedVideoNoteManager].notes objectForKey:[tempArray objectAtIndex:[send tag]]];
    if (tempNote)
    {
        videoController = [[VideoPlayController alloc] initWithNibName:@"VideoPlayController"
                                                                                     bundle:nil];
        [self.view addSubview:videoController.view];
        [wrapper rend:tempNote.puid index:tempNote.ucIdx target:videoController.view];
    }
    
    
}





- (void)connectError:(NSInteger)error
{
    
}


-(void)openVideo
{
    [self.activityView startAnimating];
    
    if ( FALSE == [ConfigManager sharedConfigManager].isLeader)
    {
        CUControlWrapper *aWrapper = [[CUControlWrapper alloc] init];
        [ConfigManager sharedConfigManager].wrapper = aWrapper;
        [aWrapper release];
        self.wrapper = [ConfigManager sharedConfigManager].wrapper;
        self.wrapper.delegate = self;
        
    }
    else
    {
        self.wrapper = [ConfigManager sharedConfigManager].wrapper;
    }
    
    


    VideoRequestController *nav = [[VideoRequestController alloc] init];
    nav.videoParent = self;
    [self.navigationController pushViewController:nav animated:NO];
    [nav release];
}


















@end










































