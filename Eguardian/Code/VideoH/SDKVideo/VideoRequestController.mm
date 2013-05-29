//
//  CheckWorkViewController.m
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "VideoRequestController.h"


#import "NetTools.h"
#import "ConfigManager.h"
#import "StringExpand.h"
#import "JSONProcess.h"
#import "AppDelegate.h"
#import "DisplayPanel.h"
#import "VideoViewController.h"
#import "VideoCameraController.h"



@interface VideoRequestController ()

@end

@implementation VideoRequestController
@synthesize mainTableView;
@synthesize userMessageLabel;
@synthesize dateLable;
@synthesize videoParent;

- (void)dealloc
{
    [resArray release];
    [userMessageLabel release];
    [dateLable release];
    [mainTableView release];
    [super dealloc];
}






//定制返回函数
-(void)backAction
{
    UINavigationController *nav = rootNav;
    int tempCount = [nav.viewControllers count];
    for (; tempCount>2; tempCount--)
    {
        [nav popViewControllerAnimated:NO];
    }

}




-(id) init
{
    self = [super init];
    if (self)
    {
        self.controllerTag = 99;
        self.title = @"视频列表";
    }
    return self;
}


//end
//*******************************************************************************************************************************************
//*******************************************************************************************************************************************




- (void)viewDidLoad
{
    [super viewDidLoad];
    resArray = [[NSMutableArray alloc] init];
    wrapper = videoParent.wrapper;
}



#pragma mark 重新加载数据
- (void)reLoadResList
{
    
    [resArray removeAllObjects];
    [resArray addObject:rootNode.resName];
    int nCount = [rootNode.childrenArray count];
    for (int i=0; i<nCount; i++)
    {
        NSPeerUnit *peerUnit = [rootNode.childrenArray objectAtIndex:i];
        [resArray addObject:peerUnit.resName];
    }
    [self.mainTableView reloadData];
}


#pragma mark 登陆
-(void)login
{
    NSString *strEPID = [[ConfigManager sharedConfigManager].configData objectForKey:@"video_epid"];
    NSString *strIPAddress = [[ConfigManager sharedConfigManager].configData objectForKey:@"video_addr"];
    NSString *strUsername = [[ConfigManager sharedConfigManager].configData objectForKey:@"video_username"];
    NSString *strPassword = [[ConfigManager sharedConfigManager].configData objectForKey:@"video_pwd"];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    int nRet = 0;
    if ( nil == app.wrapper )
    {
        nRet = [wrapper login:strIPAddress port:28866 user:strUsername psd:strPassword epid:strEPID];
    }
    
    
    if (nRet == 0)
    {
        nRet = [wrapper fetchDomainNode];
        if (nRet == 0)
        {
            [wrapper fetchPeerUnits];
            rootNode = wrapper.rootDomain;
            [self reLoadResList];
        }
    }
    [self.mainTableView reloadData];
    
    
    self.activityView.hidden = YES;
    [self.activityView stopAnimating];
}



- (void)selectCell:(int)nSelect
{
    
    if (rootNode.resType == kDomain)
    {
        // 如果根节点是域节点,则显示的肯定是设备级和子域,在查看点击的一行显示的节点类型
        NSDomainNode *pDomain = (NSDomainNode *)rootNode;
        int nSize = [pDomain.childrenArray count];
        
        if (nSelect <= nSize)
        {
            NSPeerUnit *currentNode = [pDomain.childrenArray objectAtIndex:(nSelect - 1)];
            [wrapper fetchCameras:nil];
            
            
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            int nCount = [currentNode.childrenArray count];
            for (int i=0; i<nCount; i++)
            {
                NSPeerUnit *peerUnit = [currentNode.childrenArray objectAtIndex:i];
                [tempArray addObject:peerUnit.resName];
            }
            VideoCameraController *nav = [[VideoCameraController alloc] initWithArray:tempArray cUControlWrapper:wrapper entity:currentNode];
            [tempArray release];
            [self.navigationController pushViewController:nav animated:YES];
            [nav release];
            
        }
    }
    else if (rootNode.resType == kPeerUnit)
    {
        NSPeerUnit *pPU = (NSPeerUnit *)rootNode;
        VideoPlayController *videoController = [[VideoPlayController alloc] initWithNibName:@"VideoPlayController"
                                                                                     bundle:nil];
        [self.view addSubview:videoController.view];
        [wrapper rend:pPU.puid index:nSelect - 1 target:videoController.view];
    }
}







-(void)viewWillAppear:(BOOL)animated
{
    
    if (!self.isFirst) return;
    self.isFirst = FALSE;
    
    
    currentH = 0;
    self.navigationController.navigationBarHidden = NO;
    
    
    //定制返回按钮
    {
        UIImage* image= [UIImage imageNamed:@"NavBack.png"];
        CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
        UIButton* backButton= [[UIButton alloc] initWithFrame:frame_1];
        [backButton setBackgroundImage:image forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
        [someBarButtonItem release];
        [backButton release];
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBG.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    float navh = self.navigationController.navigationBar.frame.size.height;
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-navh-currentH);
    
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(7, currentH+12, ScreenW-14,
                                                                  ScreenH-self.navigationController.navigationBar.frame.size.height-30)
                                                                style:UITableViewStylePlain];
    mainTableView.backgroundColor = [UIColor clearColor];
    mainTableView.rowHeight = 48;
    mainTableView.layer.cornerRadius = CellCornerRadius;
    mainTableView.layer.masksToBounds = YES;
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    
    [self.view addSubview:mainTableView];
    
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
//    [self login];
}





#pragma makr cell自定义
-(void)initCustomCell:(UITableViewCell *)cell
{
    
    UIColor *tempColor = [UIColor colorWithRed:143/255.0 green:136/255.0 blue:130/255.0 alpha:1.0];
    UIImageView *cellBg = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"CellBG.png"] ];
    cellBg.frame = CGRectMake(0, 0, ScreenW-14, mainTableView.rowHeight);
    
    
    
    {
        //内容
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(19, 0, 260, cell.frame.size.height)];
        label.textColor = tempColor;
        label.tag = 90;
        label.backgroundColor = [UIColor clearColor];
        [cellBg addSubview:label]; [label release];
        
    }
    
    {
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arrow.png"]];
        arrow.frame = CGRectMake(276, 17, arrow.frame.size.width, arrow.frame.size.height);
        [cellBg addSubview:arrow];
        [arrow release];
    }
    
    
    
    [cell.contentView addSubview:cellBg]; [cellBg release];
}















//**************************************************************************************************************
//**************************************************************************************************************
//Table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return [resArray count];
}


-(NSIndexPath *)tableView:(UITableView *)tableView
 willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 设置第一行无法点击
	NSUInteger row = [indexPath row];
	if (row == 0)
	{
		return nil;
	}
    return indexPath;
}



-(UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"BaseCell";
    UITableViewCell *cell = (UITableViewCell*)[atableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, atableView.frame.size.width, cell.frame.size.height);
        [self initCustomCell:cell];
    }
    
    
    
    if ([resArray count] >0 && indexPath.row == [resArray count]-1 )
    {
        CusstomCellRounde(cell, CellCornerRadius, NO);
    }
    
    
        
    UILabel *ptable = (UILabel *)[cell viewWithTag:90];
    ptable.text = [resArray objectAtIndex:indexPath.row];
    
    return cell;
}



#pragma mark 选中
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int nRow = [indexPath row];
    [self selectCell:nRow];
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    
}












@end































































