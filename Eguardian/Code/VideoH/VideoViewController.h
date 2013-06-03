//
//  VideoViewController.h
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CUControlWrapper.h"
#import "VideoButtonEx.h"

#define  MaxMeshH 1000
#define  MaxMeshY 50

@class VideoPlayController;
@interface VideoViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, CUControlWrapperDelegate,UIApplicationDelegate>
{
        
    VideoPlayController   *videoController;
    CUControlWrapper *wrapper;
    UIScrollView     *mesh;
}



@property (strong, nonatomic) VideoPlayController *videoController;
@property (nonatomic, assign) CUControlWrapper  *wrapper;
@property (nonatomic, retain) UIScrollView  *mesh;


@end

















































