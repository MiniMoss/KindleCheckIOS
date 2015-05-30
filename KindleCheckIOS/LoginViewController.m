//
//  LogInViewController.m
//  KindleCheckIOS
//
//  Created by zCloud on 5/29/15.
//  Copyright (c) 2015 Yun.Zou. All rights reserved.
//

#import "LogInViewController.h"
#import "AFNetworking.h"
#import "WelcomeViewController.h"

#define LOGINAPI @"http://api.kindlecheck.dev:3000/v1/login"

@interface LogInViewController ()

@property(strong, nonatomic) NSString *secret;
@property(strong, nonatomic) NSString *currentUser;

@end

@implementation LogInViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.delegate = self;
    self.pwdTextField.delegate = self;
}

- (IBAction)btnLogIn:(id)sender {
    //dismiss the keyboard
    [self.emailTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
    
    NSString *email = self.emailTextField.text;
    NSString *pwd = self.pwdTextField.text;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *params = @{ @"user" : @{ @"email" : email, @"password" : pwd } };
    [manager POST: LOGINAPI
       parameters: params
          success: ^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"%@", responseObject);
              NSDictionary *response = responseObject;
              self.secret = [response objectForKeyedSubscript:@"secret"];
              self.currentUser = [[response objectForKeyedSubscript:@"current_user"] objectForKeyedSubscript:@"email"];
              [self performSegueWithIdentifier:@"logInSucceed" sender:self];
         }
          failure: ^( AFHTTPRequestOperation *operation , NSError *error ) {
              self.labelInfo.text = @"Login Faild.";
          }];
}

#pragma mark - UITextView Delegation

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //dismiss the keyboard
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //pass secret and current user email to welcome view
    if ([segue.identifier isEqualToString:@"logInSucceed"]) {
        WelcomeViewController *destination = [segue destinationViewController];
        destination.secret = self.secret;
        destination.currentUser = self.currentUser;
    }
}


@end
