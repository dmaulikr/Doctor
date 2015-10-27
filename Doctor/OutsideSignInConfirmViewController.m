//
//  OutsideSignInConfirmViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "OutsideSignInConfirmViewController.h"

@interface OutsideSignInConfirmViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel* cellPhoneToSendConfirmationLabel;
@property (weak, nonatomic) IBOutlet UITextView* firstTokenCharacterTextView;
@property (weak, nonatomic) IBOutlet UITextView* secondTokenCharacterTextView;
@property (weak, nonatomic) IBOutlet UITextView* thirdTokenCharacterTextView;
@property (weak, nonatomic) IBOutlet UITextView* fourthTokenCharacterTextView;
@property (weak, nonatomic) IBOutlet UIButton* confirmButton;

@end

@implementation OutsideSignInConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self textViewSetups];
    NSString* cellPhoneSentWas = [[NSString alloc] initWithFormat:@"+ 55 81 %@", self.phoneAsAParameter];
    self.cellPhoneToSendConfirmationLabel.text = cellPhoneSentWas;
    self.confirmButton.layer.cornerRadius = 3;
}

#pragma mark - Setups
- (void) textViewSetups{
    [self.firstTokenCharacterTextView setDelegate:self];
    self.firstTokenCharacterTextView.tag = 1;
    [self.secondTokenCharacterTextView setDelegate:self];
    self.secondTokenCharacterTextView.tag = 2;
    [self.thirdTokenCharacterTextView setDelegate:self];
    self.thirdTokenCharacterTextView.tag = 3;
    [self.fourthTokenCharacterTextView setDelegate:self];
    self.fourthTokenCharacterTextView.tag = 4;
}

- (IBAction)didTappedConfirmButton:(UIButton *)sender{
    //    [VerifyClient checkPinCode:@"1234"];
}

#pragma mark - UITextViewDelegates
-(void)textViewDidChange:(UITextView *)textView{
    switch (textView.tag) {
        case 1:
            [self.secondTokenCharacterTextView becomeFirstResponder];
            break;
        case 2:
            [self.thirdTokenCharacterTextView becomeFirstResponder];
            break;
        case 3:
            [self.fourthTokenCharacterTextView becomeFirstResponder];
            break;
        case 4:
            //SHOW ALERT VIEW CONFIRMATION.
            break;
        default:
            break;
    }
}

@end
