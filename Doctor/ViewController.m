//
//  ViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/14/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "ViewController.h"
#import "MFSideMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
