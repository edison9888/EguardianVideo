//
//  HomeWorkViewController.h
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ZoneController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView             *mainTableView;
        
    float                   currentH ;
    
    NSArray                 *info;
    
}

@property(nonatomic, retain)UITableView *mainTableView;
@property(nonatomic, retain)NSArray *info;

-(void) loadTableView;

-(id) initWithZones:(NSArray *)tempData;

@end
