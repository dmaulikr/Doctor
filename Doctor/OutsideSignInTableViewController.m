//
//  OutsideSignInTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "OutsideSignInTableViewController.h"
#import "OutsideSignInConfirmViewController.h"

@interface OutsideSignInTableViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField* doctorNameTextField;
@property (weak, nonatomic) IBOutlet UITextField* doctorCRMTextField;
@property (weak, nonatomic) IBOutlet UITextField* doctorTelephoneTextField;
@property (weak, nonatomic) IBOutlet UITextField* doctorPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField* doctorConfirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField* doctorUsernameTextField;

@end

NSString *const kTextToAlertViewAsBlankFields = @"Preencha todos os campos, esses dados só serão usados para verificar sua veracidade. Talvez a senha não digitada não tenha sido a mesma.";

@implementation OutsideSignInTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.doctorPasswordTextField.secureTextEntry = YES;
    self.doctorConfirmPasswordTextField.secureTextEntry = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.topItem.title = @"Registrar";
}

#pragma mark - IBActions
- (IBAction)didTappedNextBarButton:(UIBarButtonItem *)sender{
    if ([self checkFieldsCompletion]) {
        [self showAlertViewConfirmation];
    }
    else{
        [self showAlertViewBecauseOfBlankFields];
    }
}

#pragma mark - Private Methods
- (BOOL) checkFieldsCompletion{
    BOOL returning = true;
    if (![self.doctorNameTextField.text isEqualToString:@""] && ![self.doctorCRMTextField.text isEqualToString:@""] && ![self.doctorConfirmPasswordTextField.text isEqualToString:@""] && ![self.doctorPasswordTextField.text isEqualToString:@""] && ![self.doctorTelephoneTextField.text isEqualToString:@""] && ![self.doctorUsernameTextField.text isEqualToString:@""]) {
        if ([self.doctorPasswordTextField.text isEqualToString:self.doctorConfirmPasswordTextField.text]) {
            returning = true;
        }
    }
    return returning;
}

- (void) showAlertViewConfirmation{
    
    
    NSString* stringToShow = [[NSString alloc] initWithFormat:@"Favor confirmar os dados abaixo:\nNome: %@\nCRM: %@\nNome de usuário: %@\nTelefone: +55 81 %@", self.doctorNameTextField.text, self.doctorCRMTextField.text, self.doctorUsernameTextField.text, self.doctorTelephoneTextField.text];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Os dados estão corretos?" message:stringToShow delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Confirmar", nil];
    [alert show];
}

- (void) showAlertViewBecauseOfBlankFields{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ops! Esqueceu algo?" message:kTextToAlertViewAsBlankFields delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

//- (void) sendVerifyingMessage{
//    //SEM O NOVE NA FRENTE!
//    NSString* phoneNumberToCheck = [[NSString alloc] initWithFormat:@"81%@", self.doctorTelephoneTextField.text];
//    [VerifyClient getVerifiedUserWithCountryCode:@"BR" phoneNumber:phoneNumberToCheck verifyInProgressBlock:^{
//            // called when the verification process begins
//        }
//                               userVerifiedBlock:^{
//                                   // called when the user has been successfully verified
//                               }
//                                      errorBlock:^(VerifyError error) {
//                                          // called when some error occurrs during verification, e.g. wrong pin entered.
//                                          // see the VerifyError class for details on what to expect
//                                      }];
//}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
    //    [self sendVerifyingMessage];
        [self performSegueWithIdentifier:@"clickedInNextSignInSegueId" sender:self];
    }
}

#pragma mark - Storyboard Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"clickedInNextSignInSegueId"]) {
        OutsideSignInConfirmViewController* confirmVC = segue.destinationViewController;
        [confirmVC setPhoneAsAParameter:self.doctorTelephoneTextField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    if ([_doctorNameTextField isFirstResponder] && [touch view] != _doctorNameTextField) [_doctorNameTextField resignFirstResponder];
    if ([_doctorCRMTextField isFirstResponder] && [touch view] != _doctorCRMTextField) [_doctorCRMTextField resignFirstResponder];
    if ([_doctorPasswordTextField isFirstResponder] && [touch view] != _doctorPasswordTextField) [_doctorPasswordTextField resignFirstResponder];
    if ([_doctorUsernameTextField isFirstResponder] && [touch view] != _doctorUsernameTextField) [_doctorUsernameTextField resignFirstResponder];
    if ([_doctorConfirmPasswordTextField isFirstResponder] && [touch view] != _doctorConfirmPasswordTextField) [_doctorConfirmPasswordTextField resignFirstResponder];
    if ([_doctorTelephoneTextField isFirstResponder] && [touch view] != _doctorTelephoneTextField) [_doctorTelephoneTextField resignFirstResponder];
}

@end
