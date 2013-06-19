//
//  Config.m
//  CampusManager
//
//  Created by apple on 13-4-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ConfigManager.h"
#import "SynthesizeSingleton.h"

@implementation ConfigManager
@synthesize configData;
@synthesize loginKey;
@synthesize userMessage;
@synthesize wrapper;
@synthesize isLeader;
@synthesize deviceToken;
- (void)dealloc
{
    [deviceToken release];
    [wrapper release];
    [userMessage release];
    [loginKey release];
    [configData release];
    [super dealloc];
}

SYNTHESIZE_SINGLETON_FOR_CLASS(ConfigManager);

+(NSString *)getParantMessage
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?key=%@",url,key];
    return result;
}

+(NSString *)getCommentWithString:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?action=comment&date=%@&key=%@",url,date,key];
    return result;
}



+(NSString *)getHomeWorkWithString:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;

    NSString *result = [NSString stringWithFormat:@"%@?action=work&date=%@&key=%@",url,date,key];
    return result;
}


+(NSString *)getCheckWorkWithString:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?action=kaoqin&date=%@&key=%@",url,date,key];
    return result;
}



+(NSString *)getNoticeWithString:(NSString *)date
{    
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?action=notice&key=%@",url,key];
    return result;
}


#pragma mark 座位考勤
+(NSString *)getSeatsAttendanceAddress:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?action=ex_kaoqin&key=%@&date=%@",url,key,date];
    return result;
}




//**************************************************************************************************************************
//**************************************************************************************************************************
//**************************************************************************************************************************



+(NSString *)getTHomeWorkWithString:(NSString *)date
{

    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=homework&key=%@&date=%@",url,key,date];
    return result;
}




#pragma makr 删除作业
+(NSString *)getDeleteTWorkWithIds:(NSString *)ids
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=homework_del&key=%@&id=%@",url,key,ids];
    return result;
}


#pragma mark 获取年级和班级
+(NSString *)getGradeClass
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=class&key=%@",url,key];
    return result;
}



#pragma mark 获取学生的名字
+(NSString *)getStudentsWithGradeID:(NSString *)gradeID classID:(NSString *)cls
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=student&key=%@&gradeid=%@&classid=%@",url,key,gradeID,cls];
    return result;
}




+(NSString *)getSubject
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=subject&key=%@",url,key];
    return result;
}

+(NSString *)getSendHomeWorkWithGradeID:(NSString *)gradeID classID:(NSString *)classID ids:(NSString *)ids subjectID:(NSString *)subjectID content:(NSString *)content
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:@"%@?app=teacher&action=homework_add&key=%@&gradeid=%@&classid=%@&ids=%@&subjectid=%@&content=%@",
                         url,key,gradeID,classID,ids,subjectID,content];

    restutl = [restutl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return restutl;
}


#pragma mark 获取广告地址
+(NSString *)getAdvertising
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"ads"];
    return url;
}



#pragma mark 发送评语
+(NSString *)getSendComment:(NSString *)classID content:(NSString *)content
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:@"%@?app=teacher&action=comment_add&key=%@&id=%@&content=%@",
                         url,key,classID,content];
    restutl = [restutl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return restutl;
}







+(NSString *)getTCommentWithDate:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:@"%@?app=teacher&action=comment&key=%@&date=%@",url,key,date];
    
    return restutl;
}




+(NSString *)getDeleteTCommentWithID:(NSString *)sid
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:@"%@?app=teacher&action=comment_delete&key=%@&id=%@",url,key,sid];
    return restutl;
}



+(NSString *)getTNotice
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:@"%@?app=teacher&action=notice_manage&key=%@",url,key];
    return restutl;
}




+(NSString *)getSendTNotice:(NSString *)atitle content:(NSString *)content gradeID:(NSString *)gradeID classID:(NSString *)classID
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:
                         @"%@?app=teacher&action=notice_add&goal=student&key=%@&title=%@&content=%@&gradeid=%@&classid=%@",
                         url,key,atitle,content,gradeID,classID];
    restutl = [restutl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return restutl;
}





+(NSString *)getDeleteTNoticeWithID:(NSString *)nid
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *restutl = [NSString stringWithFormat:@"%@?app=teacher&action=notice_delete&key=%@&id=%@",url,key,nid];
    return restutl;
}






+(NSString *)getTCheckWorkWithString:(NSString *)date
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action=kaoqin_me&key=%@&date=%@",url,key,date];
    return result;
}



+(NSString *)getTeacherMessage
{
    NSString *url = [[ConfigManager sharedConfigManager].configData objectForKey:@"base_url"];
    NSString *key = [ConfigManager sharedConfigManager].loginKey;
    NSString *result = [NSString stringWithFormat:@"%@?app=teacher&action&key=%@",url,key];
    return result;
}


@end























































