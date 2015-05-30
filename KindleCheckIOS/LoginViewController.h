//
//  LogInViewController.h
//  KindleCheckIOS
//
//  Created by zCloud on 5/29/15.
//  Copyright (c) 2015 Yun.Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *pwdTextField;
@property (strong, nonatomic) IBOutlet UILabel *labelInfo;

@end
