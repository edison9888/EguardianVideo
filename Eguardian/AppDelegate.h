//
//  AppDelegate.h
//  CampusManager
//
//  Created by apple on 13-3-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayPanel.h"
#import "CUControlWrapper.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    DisplayPanel                     *displayPanel;
    CUControlWrapper                 *wrapper;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DisplayPanel *displayPanel;
@property (retain, nonatomic) CUControlWrapper *wrapper;
@end
