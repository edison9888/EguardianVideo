//
//  CheckWorkViewController.m
//  CampusManager
//
//  Created by apple on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "VideoCameraController.h"


#import "NetTools.h"
#import "ConfigManager.h"
#import "StringExpand.h"
#import "JSONProcess.h"
#import "AppDelegate.h"
#import "DisplayPanel.h"
#import "PlayViewController.h"
#import "FileSystemManager.h"
#import "VideoNote.h"
#import "VideoNoteManager.h"


@interface VideoCameraController ()

@end

@implementation VideoCameraController
@synthesize mainTableView;
@synthesize userMessageLabel;
@synthesize dateLable;
@synthesize resArray;

- (void)dealloc
{
    
    [videoController release];
    [resArray release];
    [userMessageLabel release];
    [dateLable release];
    [mainTableView release];
    [super dealloc];
}






//定制返回函数
-(void)backAction
{
    [wrapper stopRend];   
    [videoController.view removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}




-(id) initWithArray:(NSMutableArray *)array cUControlWrapper:(CUControlWrapper *)apper entity:(NSResEntity *)node
{
    self = [super init];
    if (self)
    {
        self.controllerTag = 98;
        self.title = @"设备名称";
        self.resArray = array;
        wrapper = apper;
        rootNode = node;
    }
    return self;
}


//end
//*******************************************************************************************************************************************
//*******************************************************************************************************************************************




- (void)viewDidLoad
{
    [super viewDidLoad];
}








- (void)selectCell:(int)nSelect
{

    if (rootNode.resType == kPeerUnit)
    {
        NSPeerUnit *pPU = (NSPeerUnit *)rootNode;
        videoController = [[VideoPlayController alloc] initWithNibName:@"VideoPlayController" bundle:nil];
        [self.view addSubview:videoController.view];
        [wrapper rend:pPU.puid index:nSelect target:videoController.view];
        
        NSString *tempName = [resArray objectAtIndex:nSelect];
        VideoNote *tempNote = [[VideoNote alloc] initWithUID:pPU.puid time:[NSDate date] index:nSelect name:tempName];
        [VideoNoteManager insertWithVideoNote:tempNote];
        [tempNote release];
        
        
//        NSLog(@"类型是  %@, %d",pPU.puid, nSelect);
        
        
//        PlayViewController *playController = [[PlayViewController alloc] initWithWrapper:wrapper];
//        [wrapper rend:pPU.puid index:nSelect - 1 target:playController.view];
//        [self.navigationController pushViewController:playController animated:YES];
//        [playController release];
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
        label.text = @"";
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































































