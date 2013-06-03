//
//  PlayViewController.h
//  CampusManager
//
//  Created by apple on 13-4-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUControlWrapper.h"
@protocol CRMapDelegate;
@interface PlayViewController : UIViewController
{
    CUControlWrapper *wrapper;
}

@property(nonatomic,assign)CUControlWrapper *wrapper;



-(id) initWithWrapper:(CUControlWrapper *)awrapper;



@end
