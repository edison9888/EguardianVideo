//
//  BaseViewController.h
//  RDOA
//
//  Created by apple on 13-3-19.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADScrollView;
@interface BaseViewController : UIViewController
{
    int                              controllerTag;     //控制器自身的tag 与 button的对应
    BOOL                             isFirst;
    UIActivityIndicatorView          *activityView;
    ADScrollView                     *adScrollView;
    
}

@property(nonatomic, assign)int                     controllerTag;
@property(nonatomic, assign)BOOL                    isFirst;
@property(nonatomic,retain)UIActivityIndicatorView  *activityView;
@property(nonatomic,retain)ADScrollView             *adScrollView;






-(void )loadData;

-(void) goBackHome;

-(void) showError;

-(void)backAction;

-(void)showErrorMessage:(NSString *)message;


@end

