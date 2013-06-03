//
//  VideoNoteManager.m
//  CampusManager
//
//  Created by apple on 13-4-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "VideoNoteManager.h"
#import "VideoNote.h"
#import "Global.h"
#import "FileSystemManager.h"
#import "VideoNoteManager.h"
#import "SynthesizeSingleton.h"

@implementation VideoNoteManager
@synthesize notes;
@synthesize max;

SYNTHESIZE_SINGLETON_FOR_CLASS(VideoNoteManager);


-(void) loadData
{
    //获取相关文件路径
    NSString *uq = [FileSystemManager filePathName:@"VideNote" index:appDocuments];
    NSArray *tempArray = [FileSystemManager allFilesAtPath:uq];
    for ( NSString *name in tempArray)
    {
        NSData *tempData = [NSData dataWithContentsOfFile:name];
        VideoNote *msg = [NSKeyedUnarchiver unarchiveObjectWithData:tempData];
        [notes setValue:msg forKey:msg.path];
    }
    
}

- (id)init
{
    self = [super init];
    if (self)
    {
        notes = [[NSMutableDictionary alloc] init];
        max = 10;
        [self loadData];
    }
    return self;
}



- (void)dealloc
{
    [notes release];
    [super dealloc];
}


+(void) insertWithVideoNote:(VideoNote *)note
{
    NSString *path = nil;
    NSString *tempName = [[NSString alloc] initWithFormat:@"%@%d",note.puid,note.ucIdx];
    NSString *type = @"";
    NSString *dic = @"VideNote";
    path = Custom_File_Path(tempName, type, dic);
    note.path = path;
    [tempName release];
    if ( [[VideoNoteManager sharedVideoNoteManager].notes count] == [VideoNoteManager sharedVideoNoteManager].max )
    {
        [VideoNoteManager deleteNote];
    }
    [[VideoNoteManager sharedVideoNoteManager].notes setObject:note forKey:path];
    [FileSystemManager serializedObject:note filePath:path];
}

+(void) deleteWithVideoNote:(VideoNote *)note
{
    NSString *path = nil;
    NSString *tempName = [[NSString alloc] initWithFormat:@"%@%d",note.puid,note.ucIdx];
    NSString *type = @"";
    NSString *dic = @"VideNote";
    path = Custom_File_Path(tempName, type, dic);
    [tempName release];
    [FileSystemManager deleteWithPath:path];
    [[VideoNoteManager sharedVideoNoteManager].notes removeObjectForKey:path];
}

+(void) deleteNote
{
    NSArray *array = [[VideoNoteManager sharedVideoNoteManager].notes allKeys];
    [[VideoNoteManager sharedVideoNoteManager].notes removeObjectForKey:[array objectAtIndex:0]];
}




+(VideoNote *) findVideoNoteWithKey:(NSString *)key
{
    VideoNote *resutl;
    resutl = [[VideoNoteManager sharedVideoNoteManager].notes objectForKey:key];
    return resutl;
}

























































@end























































