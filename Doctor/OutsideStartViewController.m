//
//  OutsideStartViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/16/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "OutsideStartViewController.h"
#import "MFSideMenu.h"
#import "Storyboards.h"

@interface OutsideStartViewController ()

@end

@implementation OutsideStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuContainerViewController.panMode = NO;
}
- (void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)entrar:(UIButton *)sender{
    self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kFeedStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kFeedNavID];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
}

- (IBAction)didTappedSignInButton:(UIButton *)sender{
    [self performSegueWithIdentifier:@"clickedInSignInSegueId" sender:self];
}

- (IBAction)didTappedRecoverPasswordButton:(UIButton *)sender{
    [self performSegueWithIdentifier:@"clickedInRecoverPasswordSegueId" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"clickedInSignInSegueId"]) {
    
    }
    else if ([segue.identifier isEqualToString:@"clickedInRecoverPasswordSegueId"]){
        
    }
    else{
        
    }
}

@end
