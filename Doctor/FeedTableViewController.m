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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
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

-(IBAction)menu:(id)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

@end
