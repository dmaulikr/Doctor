//
//  MedicationsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "MedicationsTableViewController.h"
#import "MFSideMenu.h"

@interface MedicationsTableViewController ()

@end

@implementation MedicationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

@end
