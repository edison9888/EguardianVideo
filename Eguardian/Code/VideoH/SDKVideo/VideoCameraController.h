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
#import "VideoPlayController.h"
@interface VideoCameraController :  BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView             *mainTableView;
    UILabel                 *userMessageLabel;
    UILabel                 *dateLable;
    float                   currentH ;
    
    NSMutableArray *resArray;
    CUControlWrapper *wrapper;
    NSResEntity *rootNode;
    VideoPlayController *videoController;
    
}

@property(nonatomic, retain)UITableView *mainTableView;



@property(nonatomic, retain)UILabel *userMessageLabel;
@property(nonatomic, retain)UILabel *dateLable;

@property(nonatomic, retain)NSMutableArray *resArray;



-(id) initWithArray:(NSMutableArray *)array cUControlWrapper:(CUControlWrapper *)apper entity:(NSResEntity *)node ;



@end
