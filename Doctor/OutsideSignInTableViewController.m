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

- (IBAction)didTappedNextBarButton:(UIBarButtonItem *)sender{
    if ([self checkFieldsCompletion]) {
        NSString* stringToShow = [[NSString alloc] initWithFormat:@"Para prosseguir, verifique se os dados inseridos estão corretos:\nNome: %@\nCRM: %@\nNome de usuário: %@\nTelefone: %@", self.doctorNameTextField.text, self.doctorCRMTextField.text, self.doctorUsernameTextField.text, self.doctorTelephoneTextField.text];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Os dados estão corretos?" message:stringToShow delegate:self cancelButtonTitle:@"Ops, esqueci algo..." otherButtonTitles:@"Sim, prosseguir.", nil];
        [alert show];
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ops! Esqueceu algo?" message:@"Preencha todos os campos, esses dados só serão usados para verificar sua veracidade. Talvez a senha não digitada não tenha sido a mesma." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (BOOL) checkFieldsCompletion{
    BOOL returning = false;
    if (![self.doctorNameTextField.text isEqualToString:@""] && ![self.doctorCRMTextField.text isEqualToString:@""] && ![self.doctorConfirmPasswordTextField.text isEqualToString:@""] && ![self.doctorPasswordTextField.text isEqualToString:@""] && ![self.doctorTelephoneTextField.text isEqualToString:@""] && ![self.doctorUsernameTextField.text isEqualToString:@""]) {
        if ([self.doctorPasswordTextField.text isEqualToString:self.doctorConfirmPasswordTextField.text]) {
            returning = true;
        }
    }
    return returning;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self performSegueWithIdentifier:@"clickedInNextSignInSegueId" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"clickedInNextSignInSegueId"]) {
        OutsideSignInConfirmViewController* confirmVC = segue.destinationViewController;
        confirmVC.cellPhoneToSendConfirmationLabel.text = self.doctorTelephoneTextField.text;
    }
}

@end
