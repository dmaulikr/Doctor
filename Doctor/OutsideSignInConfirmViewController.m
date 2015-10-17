//
//  OutsideSignInConfirmViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "OutsideSignInConfirmViewController.h"

@interface OutsideSignInConfirmViewController ()

@end

@implementation OutsideSignInConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.backItem.title = @"";
    self.navigationController.navigationBar.topItem.title = @"";
}

@end
