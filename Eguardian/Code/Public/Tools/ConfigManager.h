//
//  Config.h
//  CampusManager
//
//  Created by apple on 13-4-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigManager : NSObject
{
    NSDictionary             *configData;          //配置信息
    NSString                 *loginKey;
    NSDictionary             *userMessage;         //绑定后用户的信息
    
}

@property(nonatomic,retain)NSDictionary     *configData;
@property(nonatomic,retain)NSString     *loginKey;
@property(nonatomic,retain)NSDictionary     *userMessage;

+ (ConfigManager *)sharedConfigManager;

+(NSString *)getParantMessage;

+(NSString *)getCheckWorkWithString:(NSString *)date;

+(NSString *)getHomeWorkWithString:(NSString *)date;

+(NSString *)getCommentWithString:(NSString *)date;

+(NSString *)getNoticeWithString:(NSString *)date;




+(NSString *)getTHomeWorkWithString:(NSString *)date;

+(NSString *)getDeleteTWorkWithIds:(NSString *)ids;




+(NSString *)getGradeClass;

+(NSString *)getStudentsWithGradeID:(NSString *)gradeID classID:(NSString *)cls;

+(NSString *)getSubject;


+(NSString *)getSendHomeWorkWithGradeID:(NSString *)gradeID classID:(NSString *)classID ids:(NSString *)ids subjectID:(NSString *)subjectID content:(NSString *)content;








+(NSString *)getAdvertising;


+(NSString *)getSendComment:(NSString *)classID content:(NSString *)content;


+(NSString *)getTCommentWithDate:(NSString *)date;

+(NSString *)getDeleteTCommentWithID:(NSString *)sid;


+(NSString *)getTNotice;

+(NSString *)getSendTNotice:(NSString *)atitle content:(NSString *)content gradeID:(NSString *)gradeID classID:(NSString *)classID;


+(NSString *)getDeleteTNoticeWithID:(NSString *)nid;


+(NSString *)getTCheckWorkWithString:(NSString *)date;

+(NSString *)getTeacherMessage;


@end
























































