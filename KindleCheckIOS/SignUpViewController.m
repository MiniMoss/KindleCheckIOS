//
//  SignUpViewController.m
//  KindleCheckIOS
//
//  Created by zCloud on 5/29/15.
//  Copyright (c) 2015 Yun.Zou. All rights reserved.
//

#import "SignUpViewController.h"
#import "AFNetworking.h"
#import "WelcomeViewController.h"

#define SIGNUPAPI @"http://api.kindlecheck.dev:3000/v1/sign_up"

@interface SignUpViewController ()

@property(strong, nonatomic) NSString *secret;
@property(strong, nonatomic) NSString *currentUser;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextfield.delegate = self;
    self.pwdTextField.delegate = self;
    self.pwdConfirmTextField.delegate = self;
}

- (IBAction)btnSignUp:(id)sender {
    //dismiss keyboard
    [self.emailTextfield resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
    [self.pwdConfirmTextField resignFirstResponder];
    
    NSString *email = self.emailTextfield.text;
    NSString *pwd = self.pwdTextField.text;
    NSString *pwdConfirm = self.pwdConfirmTextField.text;
    
    if (email && pwd && pwdConfirm) {
        if ([pwd isEqualToString:pwdConfirm]) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            NSDictionary *params = @{ @"user" : @{ @"email" : email, @"password" : pwd } };
            [manager POST: SIGNUPAPI
               parameters: params
                  success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                      NSLog(@"%@", responseObject);
                      NSDictionary *response = responseObject;
                      self.secret = [response objectForKeyedSubscript:@"secret"];
                      self.currentUser = [[response objectForKeyedSubscript:@"current_user"] objectForKeyedSubscript:@"email"];
                      [self performSegueWithIdentifier:@"signUpSucceed" sender:self];
                  }
                  failure: ^( AFHTTPRequestOperation *operation , NSError *error ) {
                      self.labelInfo.text = @"Sign Up faild.";
                  }];
        }else {
            self.labelInfo.text = @"Pwds do not match.";
        }
    }else{
        self.labelInfo.text = @"Sign up faild";
    }
    
}

#pragma mark - UITextField Delegation

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //dismiss keyboard
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //pass secret and current user email to welcome view
    if ([segue.identifier isEqualToString:@"signUpSucceed"]) {
        WelcomeViewController *destination = [segue destinationViewController];
        destination.secret = self.secret;
        destination.currentUser = self.currentUser;
    }
}

@end
