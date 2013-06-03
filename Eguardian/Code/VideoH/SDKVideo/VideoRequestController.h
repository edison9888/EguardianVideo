//
//  CheckWorkViewController.h
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CUControlWrapper.h"
@class VideoViewController;
@interface VideoRequestController :  BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView             *mainTableView;
    UILabel                 *userMessageLabel;
    UILabel                 *dateLable;
    float                   currentH ;
    
    NSMutableArray *resArray;
    CUControlWrapper *wrapper;
    NSResEntity *rootNode;
    VideoViewController         *videoParent;
    
}

@property(nonatomic, retain)UITableView *mainTableView;



@property(nonatomic, retain)UILabel *userMessageLabel;
@property(nonatomic, retain)UILabel *dateLable;

@property(nonatomic, assign)VideoViewController *videoParent;


@end
