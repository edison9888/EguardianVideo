//
//  LoginBaseViewController.h
//  CampusManager
//
//  Created by Deathman on 13-4-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginedUsersHistoryController.h"
#import "ConfigManager.h"

#import "SchoolPickedController.h"
#import "LSchoolController.h"

#define User_AutoLogin               @"AutoLogin"
#define User_AutoLoginCheck          @"AutoLogin_Check"
#define User_AutoLoginRole           @"AutoLogin_Role"

#define User_UserNumber              @"UserNumber"
#define User_SchoolID                @"SchoolID"
#define User_SchoolName              @"SchoolName"
#define User_Password                @"Password"

#define User_LoginedUsers_Teachers   @"LoginedUsers_Teachers"
#define User_LoginedUsers_Parents    @"LoginedUsers_Parents"
#define User_LoginedUsers_Leaders    @"LoginedUsers_Leaders"

enum LoginRole {
    LoginRoleParents = 1,
    LoginRoleTeacher = 2,
    LoginRoleLeader = 3,
};

@class LoginBaseViewController;

@protocol LoginControllerDelegate <NSObject>

- (void)loginViewController:(LoginBaseViewController *)controller switchRole:(enum LoginRole)role;

@end

@interface LoginBaseViewController : UIViewController<UITextFieldDelegate,SchoolPickedDelegate,SchoolControllerDelegate> {
    
    IBOutlet UIButton       *autoLoginCheckbox_;
    
    IBOutlet UIButton       *loginButton_;
    
    LoginedUsersHistoryController *loginedUsersController_;
    
    SchoolPickedController *schoolPickedController_;
    
    
}
@property (nonatomic,assign) id<LoginControllerDelegate> delegate;

@property (nonatomic,retain) NSDictionary           *selectedUser;
@property (nonatomic,retain) NSMutableArray         *loginedUsers;
@property (nonatomic,retain) IBOutlet UITextField   *userNameTextfield;
@property (nonatomic,retain) IBOutlet UITextField   *schoolTextfield;

@property (nonatomic,copy) NSString *schoolID;

@property (nonatomic,copy) NSString *loginedKey;

+ (BOOL)wasSwitchRole;

+ (void)setWasSwitchRole:(BOOL)flag;

- (IBAction)chooseSchool:(id)sender;
- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)checkboxClicked:(id)sender;
- (IBAction)showLoginedUsersHistory;
- (IBAction)switchRole:(id)sender;
//保存登录数据，用于自动登录
- (void)storageLoginData;

//for subClass to overRight
- (NSDictionary *)userFromText;
- (void)selectedUser:(NSDictionary *)user;
- (void)sendLoginRequest;
- (NSString *)loginRequestURL;

@end
