//
//  SignUpViewController.h
//  KindleCheckIOS
//
//  Created by zCloud on 5/29/15.
//  Copyright (c) 2015 Yun.Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelInfo;
@property (strong, nonatomic) IBOutlet UITextField *emailTextfield;
@property (strong, nonatomic) IBOutlet UITextField *pwdTextField;
@property (strong, nonatomic) IBOutlet UITextField *pwdConfirmTextField;

@end
