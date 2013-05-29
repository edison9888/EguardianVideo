//
//  ResEntity.h
//  iMcuSdk
//
//  Created by mac on 12-9-12.
//  Copyright (c) 2012年 Crearo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum // 云台的转动的方向
{
	kPtzUp = 0,				
	kPtzDown,									
	kPtzLeft,							
	kPtzRight,						
}PtzTurnDirection;

typedef enum // 资源类型
{
	kDomain = 0, // 域				
	kPeerUnit,	 // 设备								
	kCamera,     // 摄像头											
}IResType;

// 资源的基类
@interface NSResEntity : NSObject
{
    BOOL            enable;
    char            cIdx;
    NSString        *puid;
    BOOL            online;
    IResType        resType;
    NSString        *resName;
    NSResEntity     *parent;
    NSMutableArray  *childrenArray;
}
@property (nonatomic, assign)   BOOL            enable;            // 资源是否使能
@property (nonatomic, assign)   char            cIdx;              // 资源的序号
@property (nonatomic, copy)     NSString        *puid;             // PUID
@property (nonatomic, assign)   BOOL            online;            // 是否在线
@property (nonatomic, assign)   IResType        resType;         	
@property (nonatomic, copy)     NSString        *resName;          // 资源名称
@property (nonatomic, assign)   NSResEntity     *parent;           // 父节点
@property (nonatomic, retain)   NSMutableArray  *childrenArray;    // 子节点集合

@end

/**
 *	@brief	设备资源
 */
@interface NSPeerUnit : NSResEntity
{
    NSString *modelType;
}
@property (nonatomic, copy) NSString *modelType;
@end

/**
 *	@brief	域节点
 */
@interface NSDomainNode : NSResEntity

{
    
}
@end