//
//  OutsideRecoverPasswordViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/16/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "OutsideRecoverPasswordViewController.h"

@interface OutsideRecoverPasswordViewController ()

@end

@implementation OutsideRecoverPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;

}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(5/255.0f) green:(65/255.0f) blue:(93/255.0f) alpha:1.0f]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.backItem.title = @"";
}

@end
