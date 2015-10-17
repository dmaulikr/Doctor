//
//  ForumViewController.m
//  Doctor
//
//  Created by Matheus_Lins on 10/16/15.
//  Copyright (c) 2015 Doctr. All rights reserved.
//

#import "ForumViewController.h"
#import "MFSideMenu.h"

@interface ForumViewController ()

@end

@implementation ForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

@end
