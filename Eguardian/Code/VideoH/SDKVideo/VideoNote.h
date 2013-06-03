//
//  VideoNote.h
//  CampusManager
//
//  Created by apple on 13-4-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoNote : NSObject<NSCoding>
{
    NSString        *puid;
    NSDate          *date;
    int             ucIdx;
    NSString        *path;          //被存储的路径
    NSString        *name;           //设备名称
}

@property(nonatomic,retain)NSString *puid;
@property(nonatomic,retain)NSDate *date;
@property(nonatomic,assign)int  ucIdx;
@property(nonatomic,retain)NSString *path;
@property(nonatomic,retain)NSString *name;


-(id) initWithUID:(NSString *)uid time:(NSDate *)adate index:(int)aucIdx name:(NSString *)aname ;


































@end
































































