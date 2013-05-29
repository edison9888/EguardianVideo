//
//  Global.h
//  RDOA
//
//  Created by apple on 13-3-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
//获取默认文件设置 默认是 0
#define DefaultFileIndex 0

//获取默认路径字符串
#define Default_File_Path [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:DefaultFileIndex]


#define Custom_File_Path(afileName,afileFormat,adirectory) 	[FileSystemManager fileName:afileName fileFormat:afileFormat directory:adirectory]


//屏幕宽高
#define ScreenH  [[UIScreen mainScreen] applicationFrame].size.height
#define ScreenW  [[UIScreen mainScreen] applicationFrame].size.width


//获取 根的 UINavigationController
#define rootNav (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController




//footBarH的高度， 默认宽度是 屏幕宽
#define footBarH 50

#define BARBUTTON(TITLE, SELECTOR) 	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]


#define CellCornerRadius 10


static  UIImage* MTDContextCreateRoundedMask( CGRect rect, CGFloat radius_tl, CGFloat radius_tr, CGFloat radius_bl, CGFloat radius_br )
{
    
    CGContextRef context;
    CGColorSpaceRef colorSpace;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    context = CGBitmapContextCreate( NULL, rect.size.width, rect.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast );
    CGColorSpaceRelease(colorSpace);
    
    if ( context == NULL ) {
        return NULL;
    }
    
    // cerate mask
    
    CGFloat minx = CGRectGetMinX( rect ), midx = CGRectGetMidX( rect ), maxx = CGRectGetMaxX( rect );
    CGFloat miny = CGRectGetMinY( rect ), midy = CGRectGetMidY( rect ), maxy = CGRectGetMaxY( rect );
    
    CGContextBeginPath( context );
    CGContextSetGrayFillColor( context, 1.0, 0.0 );
    CGContextAddRect( context, rect );
    CGContextClosePath( context );
    CGContextDrawPath( context, kCGPathFill );
    
    CGContextSetGrayFillColor( context, 1.0, 1.0 );
    CGContextBeginPath( context );
    CGContextMoveToPoint( context, minx, midy );
    CGContextAddArcToPoint( context, minx, miny, midx, miny, radius_bl );
    CGContextAddArcToPoint( context, maxx, miny, maxx, midy, radius_br );
    CGContextAddArcToPoint( context, maxx, maxy, midx, maxy, radius_tr );
    CGContextAddArcToPoint( context, minx, maxy, minx, midy, radius_tl );
    CGContextClosePath( context );
    CGContextDrawPath( context, kCGPathFill );
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef bitmapContext = CGBitmapContextCreateImage( context );
    CGContextRelease( context );
    
    // convert the finished resized image to a UIImage
    UIImage *theImage = [UIImage imageWithCGImage:bitmapContext];
    // image is retained by the property setting above, so we can
    // release the original
    CGImageRelease(bitmapContext);
    
    // return the image
    return theImage;
}






static void CusstomCellRounde(UITableViewCell *cell, float radius, BOOL top )
{
    UIImage *mask;
    if ( top )
        mask =  MTDContextCreateRoundedMask( cell.bounds, radius, radius, 0.0, 0.0);
    else
        mask =  MTDContextCreateRoundedMask( cell.bounds, 0.0, 0.0, radius, radius );
    CALayer *layerMask = [CALayer layer];
    layerMask.frame = cell.bounds;
    layerMask.contents = (id)mask.CGImage;
    cell.layer.mask = layerMask;
}





static NSDate* GetYesterday(NSDate *date)
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date ];
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [cal dateByAddingComponents:components toDate:date options:0];
    
    [components setHour:-24];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *yesterday = [cal dateByAddingComponents:components toDate: today options:0];
//    NSDate *date = yesterday;
//    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
//    [dateformat setDateFormat:@"yyyy-MM-dd"];
//    NSString *result = [dateformat stringFromDate:date];
    
    return yesterday;    
}




static NSDate* GetTomorrow(NSDate *date)
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date ];
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [cal dateByAddingComponents:components toDate:date options:0];
    
    [components setHour:+24];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *resutl = [cal dateByAddingComponents:components toDate: today options:0];
    return resutl;
}





static NSString* GetWeekDay(NSDate *date)
{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    NSInteger weekDay = [components weekday];
    
    NSString *result;
    
    switch (weekDay) {
        case 1:
            result = @"星期日";
            break;
        case 2:
            result = @"星期一";
            break;
        case 3:
            result = @"星期二";
            break;
        case 4:
            result = @"星期三";
            break;
        case 5:
            result = @"星期四";
            break;
        case 6:
            result = @"星期五";
            break;
        default:
            result = @"星期六";
            break;
    }
    return result;
}














































