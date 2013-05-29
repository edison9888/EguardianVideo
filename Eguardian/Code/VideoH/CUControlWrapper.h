//
//  iMcuSdk.h
//  iMcuSdk
//
//  Created by mac on 12-9-7.
//  Copyright (c) 2012年 Crearo. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ResEntity.h"

#define NC_CU_OK                            0				// 成功
#define NC_CU_VERIFY_USERNOTEXIST			1				// 用户不存在
#define NC_CU_VERIFY_USERINACTIVE			2				// 用户被禁用
#define NC_CU_VERIFY_PASSWORDWRONG			6				// 密码错误
#define NC_CU_VERIFY_TIMEOUT				9				// 认证超时
#define NC_CU_VERIFY_ROUTEFAILED			10				// 路由失败
#define NC_CU_RecvNotify_Error              -3              // 连接超时
#define DC7_E_TCPSEND                       -7              // 数据发送出错
#define DC7_E_TCPRECV                       -8              // 数据接收出错
#define NC7_E_REQTIMEOUT                    3               // 请求超时
#define NC_NU_ERROR_TIMEOUT                 0x2209          // 命令超时
#define NC_NU_ERROR_ROUTEFAILED             0x220A          // 路由失败
#define NC_NU_ERROR_NOVALIDDISPATCHER       0x2221          // 没有可用的分发单元

@class VideoView;
@protocol CUControlWrapperDelegate;

@interface CUControlWrapper : NSObject
{
    NSString                            *_version;
    NSDomainNode                        *_rootDomain;
    id<CUControlWrapperDelegate>        _delegate;
}
@property (nonatomic, readonly) NSDomainNode                 *rootDomain;// 域节点, 默认为空, 在调用fetchDomainNode后才会有效
@property (nonatomic, readonly) NSString                     *version;   // 版本号
@property (nonatomic, assign) id<CUControlWrapperDelegate>   delegate;   // 代理

/**
 *	@brief              连接服务器
 *
 *	@param 	address     地址
 *	@param 	usPort      端口
 *	@param 	userName 	用户名
 *	@param 	password 	密码
 *	@param 	epid        epid
 *
 *	@return             返回的错误码 0表示登录成功
 */
- (NSInteger)login:(NSString *)address
              port:(unsigned short)usPort
              user:(NSString *)userName
               psd:(NSString *)password
              epid:(NSString *)epid;

/**
 *	@brief	退出服务器
 */
- (void)loginOut;

/**
 *	@brief	获取服务器下的域节点, 获取成功以后可通过rootDomain来获取.
 *
 *	@return	0表示成功
 */
- (NSInteger)fetchDomainNode;

/**
 *	@brief	获取当前域下所有的设备, 确保之前已经调用了fetchDomainNode,获取成功以后可以在rootDomain的childrenArray集合中查找
 *
 *	@param 	pDomain 	域节点
 *
 *	@return	错误码; 0表示成功
 */
- (NSInteger)fetchPeerUnits;

/**
 *	@brief	获取摄像头资源，确保之前已经调用了fetchDomainNode和fetchPeerUnits。
 *          这个函数会去发网络远程命令,第一次调用该函数会获取域下所有的摄像头资源,所以全局只需要调用一次,此时peerUnit参数可为NULL; 如果想刷新某个PU下的摄像头资源,
 *          需再次调用,此时就需要传入具体NSPeerUnit实例. 获取成功以后如果想要查找某个摄像头,应该通过PUID和cIdx在对应的NSPeerUnit实例的childrenArray集合中查找
 *          
 *  @param 	pPU 	可为NULL或者域下某个具体的设备对象
 *
 *	@return	错误码; 0表示成功
 */
- (NSInteger)fetchCameras:(NSPeerUnit *)peerUnit;

/**
 *	@brief	渲染视频接口.
 *
 *	@param 	puid 	视频资源的PUID
 *	@param 	ucIdx 	视频资源的index
 *	@param 	renderView 	播放窗口, renderView必须是VideoView类的实例. 
 *
 *	@return	0 成功
 */
- (NSInteger)rend:(NSString *)puid index:(unsigned char)ucIdx target:(UIView *)renderView;

/**
 *	@brief	设置渲染视频的区域
 *
 *	@param 	rect 	区域
 */
- (void)setRendRect:(CGRect)rect;

/**
 *	@brief	停止视频
 */
- (void)stopRend;

/**
 *	@brief	转动摄像头
 *
 *	@param 	pVideo 	摄像头对象
 *	@param 	direction 	转动的方向
 *
 *	@return	0表示成功
 */
- (NSInteger)ptzStartTurn:(NSResEntity *)pVideo direction:(PtzTurnDirection)direction;

/**s
 *	@brief	停止转动摄像头
 *
 *	@param 	pVideo 	摄像头对象
 *
 *	@return	0 表示成功
 */
- (NSInteger)ptzStopTurn:(NSResEntity *)pVideo;

/**
 *	@brief	缩放图像
 *
 *	@param 	pVideo 	进行缩放的摄像头对象
 *	@param 	zoomIn 	YES表示放大图像, NO表示缩小图像
 *
 *	@return	0 返回成功
 */
- (NSInteger)ptzStartZoom:(NSResEntity *)pVideo zoomIn:(BOOL)zoomIn;

/**
 *	@brief	停止缩放
 *
 *	@param 	pVideo 	摄像头对象
 *
 *	@return	0返回成功
 */
- (NSInteger)ptzStopZoom:(NSResEntity *)pVideo;

@end

/**
 *	@brief	代理类
 */
@protocol CUControlWrapperDelegate <NSObject>

/**
 *	@brief	这个代理方法是执行在子线程中,主要是侦测连接服务器,接受数据出错时返回的错误码
 *
 *	@param 	error 	返回的错误码
 */
- (void)connectError:(NSInteger)error;

@end


