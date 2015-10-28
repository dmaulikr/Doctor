//
//  InboxTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/28/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "InboxTableViewController.h"
#import "MFSideMenu.h"

@interface InboxTableViewController ()

@end

@implementation InboxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

@end
