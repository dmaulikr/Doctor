//
//  OutsideSignInConfirmViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "OutsideSignInConfirmViewController.h"
#import <Parse.h>

@interface OutsideSignInConfirmViewController () <UITextViewDelegate, UIAlertViewDelegate>

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
    if (![self.firstTokenCharacterTextView.text isEqualToString:@""] && ![self.secondTokenCharacterTextView.text isEqualToString:@""] && ![self.thirdTokenCharacterTextView.text isEqualToString:@""] && ![self.fourthTokenCharacterTextView.text isEqualToString:@""]) {
        [self codeInputComplete];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Há campos do código que ainda estão em branco." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        alert.tag = 404;
        [alert show];
    }
    
}

#pragma mark - UITextViewDelegates
-(void)textViewDidChange:(UITextView *)textView{
    switch (textView.tag) {
        case 1:
            if (![textView.text isEqualToString:@""]) {
                [self.secondTokenCharacterTextView becomeFirstResponder];
            }
            break;
        case 2:
            if (![textView.text isEqualToString:@""]) {
                [self.thirdTokenCharacterTextView becomeFirstResponder];
            }
            break;
        case 3:
            if (![textView.text isEqualToString:@""]) {
                [self.fourthTokenCharacterTextView becomeFirstResponder];
            }
            break;
        case 4:
            if (![textView.text isEqualToString:@""]) {
                [self codeInputComplete];
            }
            break;
        default:
            break;
    }
}

- (void) codeInputComplete{
    NSString* codeInput = [[NSString alloc] initWithFormat:@"O código inserido:\n%@%@%@%@\n Confere?", self.firstTokenCharacterTextView.text, self.secondTokenCharacterTextView.text, self.thirdTokenCharacterTextView.text, self.fourthTokenCharacterTextView.text];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:codeInput delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
    alert.tag = 123456;
    [alert show];
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 404:
            break;
        case 123456:
            if (buttonIndex == 1) {
            //[VerifyClient checkPinCode:@"1234"];
                NSLog(@"confirmed");
            }
            break;
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    if ([_firstTokenCharacterTextView isFirstResponder] && [touch view] != _firstTokenCharacterTextView) [_firstTokenCharacterTextView resignFirstResponder];
    if ([_secondTokenCharacterTextView isFirstResponder] && [touch view] != _secondTokenCharacterTextView) [_secondTokenCharacterTextView resignFirstResponder];
    if ([_thirdTokenCharacterTextView isFirstResponder] && [touch view] != _thirdTokenCharacterTextView) [_thirdTokenCharacterTextView resignFirstResponder];
    if ([_fourthTokenCharacterTextView isFirstResponder] && [touch view] != _fourthTokenCharacterTextView) [_fourthTokenCharacterTextView resignFirstResponder];
}

@end





