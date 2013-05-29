//
//  VideoView.h
//  iMobileMonitor
//
//  Created by crearo on 1/29/10.
//  Copyright 2010 crearo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VideoView : UIView
{
	CGImageRef  _imageRef;
    CGRect      _rendRect;
}

@property (nonatomic, readonly) CGImageRef  imageRef;

// 不推荐通过rendRect去设置渲染区域，应该用CUControlWrapper中的- (void)setRendRect:(CGRect)rect;方法
@property (nonatomic, assign)   CGRect      rendRect;

@end
