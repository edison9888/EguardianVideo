//
//  VideoNoteManager.h
//  CampusManager
//
//  Created by apple on 13-4-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VideoNote;
@interface VideoNoteManager : NSObject
{
    
    NSMutableDictionary             *notes;
    int                             max;
}

@property(nonatomic,retain)NSMutableDictionary *notes;
@property(nonatomic,assign)int max;

+ (VideoNoteManager *)sharedVideoNoteManager;

+(void) insertWithVideoNote:(VideoNote *)note;

+(void) deleteWithVideoNote:(VideoNote *)note;

+(VideoNote *) findVideoNoteWithKey:(NSString *)key;


@end




























































