//
//  OutsideSignInConfirmViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

@import VerifyIosSdk;

#import "OutsideSignInConfirmViewController.h"

@interface OutsideSignInConfirmViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel* cellPhoneToSendConfirmationLabel;
@property (weak, nonatomic) IBOutlet UITextField* firstTokenCharacterTextField;
@property (weak, nonatomic) IBOutlet UITextField* secondTokenCharacterTextField;
@property (weak, nonatomic) IBOutlet UITextField* thirdTokenCharacterTextField;
@property (weak, nonatomic) IBOutlet UITextField* fourthTokenCharacterTextField;
@property (weak, nonatomic) IBOutlet UIButton* confirmButton;

@end

@implementation OutsideSignInConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* cellPhoneSentWas = [[NSString alloc] initWithFormat:@"+ 55 81 %@", self.phoneAsAParameter];
    self.cellPhoneToSendConfirmationLabel.text = cellPhoneSentWas;
    self.confirmButton.layer.cornerRadius = 3;
}

#pragma mark - Setups
- (void) textFieldDidChangeSetup{
    
    [self.firstTokenCharacterTextField addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    
    [self.secondTokenCharacterTextField addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];

    [self.thirdTokenCharacterTextField addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    
    [self.fourthTokenCharacterTextField addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - UITextFieldDelegates
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    switch (textField.tag) {
//        case 1:
//            break;
//        case 2:
//            break;
//        case 3:
//            break;
//        case 4:
//            break;
//        default:
//            break;
//    }
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    switch (textField.tag) {
//        case 1:
//            NSLog(@"TESTE");
//            break;
//        case 2:
//            break;
//        case 3:
//            break;
//        case 4:
//            break;
//        default:
//            break;
//    }
//}

- (IBAction)didTappedConfirmButton:(UIButton *)sender{
    //    [VerifyClient checkPinCode:@"1234"];
}

-(void)textFieldDidChange:(UITextField *)theTextField
{
    NSLog( @"text changed: %@", theTextField.text);
//    self.quantityTextField = theTextField;
//    self.actField = theTextField;
}

@end
