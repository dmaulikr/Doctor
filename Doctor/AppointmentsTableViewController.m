//
//  AppointmentsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/28/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "AppointmentsTableViewController.h"
#import "MFSideMenu.h"

@interface AppointmentsTableViewController ()

@end

@implementation AppointmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

@end
