//
//  HomeViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/12/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "HomeViewController.h"
#import "MFSideMenu.h"
#import "Storyboards.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (IBAction)didTappedPatientButton:(id)sender{
    self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kPatientsStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kPatientsNavID];
}
- (IBAction)didTappedForumButton:(id)sender{
    self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kForumStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kForumNavID];
    
}
- (IBAction)didTappedMedicationsButton:(id)sender{
    self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kMedicationsStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kMedicationsNavID];
    
}
- (IBAction)didTappedSettingsButton:(id)sender{
    self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kSettingsStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kSettingsNavID];
    
}
- (IBAction)didTappedLogoutButton:(id)sender{
    self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kOutsideStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kOutsideNavID];
    
}


@end
