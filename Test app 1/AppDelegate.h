//
//  AppDelegate.h
//  Test app 1
//
//  Created by Mobile Developer on 3/6/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@class LoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) LoginViewController *loginViewController;

@end

