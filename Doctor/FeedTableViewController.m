//
//  FeedTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/16/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "FeedTableViewController.h"
#import "MFSideMenu.h"

@interface FeedTableViewController ()

@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuContainerViewController.panMode = YES;
}

- (void)viewWillAppear:(BOOL)animated{
}


/* Nexmo Integration
 [VerifyClient getVerifiedUserWithCountryCode:@"GB" phoneNumber:@"07000000000"
 verifyInProgressBlock:^{
 // called when the verification process begins
 }
 userVerifiedBlock:^{
 // called when the user has been successfully verified
 }
 errorBlock:^(VerifyError error) {
 // called when some error occurrs during verification, e.g. wrong pin entered.
 // see the VerifyError class for details on what to expect
 }
 ];
 [VerifyClient checkPinCode:@"1234"];
 */

-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

@end
