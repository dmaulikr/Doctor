//
//  TutorialSecondPageViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/15/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "TutorialSecondPageViewController.h"

@interface TutorialSecondPageViewController (){
    int i;
}

@property (nonatomic, weak) IBOutlet UILabel* patientsLabel;
@property (nonatomic, weak) IBOutlet UILabel* medicationsLabel;
@property (nonatomic, weak) IBOutlet UILabel* forumLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsLabel;
@property (nonatomic, weak) IBOutlet UILabel* leaveLabel;
@property (nonatomic, weak) IBOutlet UITextView* instructionTextView;
@property (nonatomic, weak) IBOutlet UIImageView* pageImageView;

@end

@implementation TutorialSecondPageViewController

- (void)viewDidLoad {
    i = 0;
    [super viewDidLoad];
    self.navigationController.navigationBarHidden =  YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked)];
    [self.view addGestureRecognizer:tap];
}

- (void) clicked{
    i++;
    
    switch (i) {
        case 1:
            self.medicationsLabel.alpha = 0.0;
            self.forumLabel.alpha = 0.0;
            self.settingsLabel.alpha = 0.0;
            self.leaveLabel.alpha = 0.0;
            
            self.instructionTextView.alpha = 1.0;
            self.pageImageView.alpha = 1.0;
            break;
        case 2:
            [self performSegueWithIdentifier:@"goToThirdTutorialSegue" sender:self];
            break;
        case 3:
            break;
        default:
            break;
    }
}
@end
