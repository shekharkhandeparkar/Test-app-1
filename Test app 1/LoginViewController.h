//
//  LoginViewController.h
//  Test app 1
//
//  Created by Mobile Developer on 3/6/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usern;
@property (weak, nonatomic) IBOutlet UILabel *passw;

- (IBAction)userSwitch:(id)sender;

- (IBAction)loginClicked:(id)sender;

@end
