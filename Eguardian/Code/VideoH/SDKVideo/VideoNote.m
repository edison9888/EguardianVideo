//
//  VideoNote.m
//  CampusManager
//
//  Created by apple on 13-4-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "VideoNote.h"
@implementation VideoNote
@synthesize date;
@synthesize puid;
@synthesize ucIdx;
@synthesize path;
@synthesize name;
- (void)dealloc
{
    [name release];
    [path release];
    [date release];
    [puid release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        puid = nil;
        date = nil;
        name = nil;
        ucIdx = 0;
    }
    return self;
}

-(id) initWithUID:(NSString *)uid time:(NSDate *)adate index:(int)aucIdx name:(NSString *)aname 
{
    self = [super init];
    if (self)
    {
        self.puid = uid;
        self.date = adate;
        self.ucIdx = aucIdx;
        self.name = aname;
    }
    return self;
}


-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:date forKey:@"date"];
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:puid forKey:@"puid"];
    [aCoder encodeObject:[NSNumber numberWithInt:ucIdx] forKey:@"ucIdx"];
    [aCoder encodeObject:path forKey:@"path"];
}



-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.puid = [aDecoder decodeObjectForKey:@"puid"];
        self.ucIdx = [[aDecoder decodeObjectForKey:@"ucIdx"] intValue];
        self.path = [aDecoder decodeObjectForKey:@"path"];
    }
    return self;
}




-(NSString*) description
{
	NSString *description = [NSString stringWithFormat:@"date is  %@, name is  %@,  puid is %@   path is %@", date, name, puid, path,nil];
	return description;
}



@end







































































