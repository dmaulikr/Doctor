//
//  TutorialFirstPageViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/15/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "TutorialFirstPageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TutorialViewController.h"

@interface TutorialFirstPageViewController ()

@property (nonatomic, weak) IBOutlet UILabel* nonThanksLabel;
@property (nonatomic, weak) IBOutlet UIButton* goToTutoButton;

@end

@implementation TutorialFirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden =  YES;
    
    self.nonThanksLabel.backgroundColor = [UIColor clearColor];
    self.nonThanksLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.nonThanksLabel.layer.borderWidth = 3.0;
    
    [self.goToTutoButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
}

- (IBAction)clickedNonTapped:(id)sender{
    [self performSegueWithIdentifier:@"goToAppSegue" sender:self];
}

- (IBAction)clickedIntoTutorial:(id)sender{
    [self performSegueWithIdentifier:@"goToTutorialSegue" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    segue.destinationViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

@end
