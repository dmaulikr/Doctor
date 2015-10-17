//
//  OutsideSignInTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "OutsideSignInTableViewController.h"

@interface OutsideSignInTableViewController () <UITextFieldDelegate>

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
    [self setupTextFieldsActions];
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.topItem.title = @"Registrar";
}

#pragma mark - UITextField Delegate
- (void)setupTextFieldsActions{
    [self.doctorNameTextField addTarget:self action:@selector(textFieldDidBeginEditing:)forControlEvents:UIControlEventEditingDidBegin];
    
    [self.doctorCRMTextField addTarget:self action:@selector(textFieldDidBeginEditing:)forControlEvents:UIControlEventEditingDidBegin];
    
    [self.doctorTelephoneTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    
    [self.doctorPasswordTextField addTarget:self action:@selector(textFieldDidBeginEditing:)forControlEvents:UIControlEventEditingDidBegin];
    
    [self.doctorConfirmPasswordTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    
    [self.doctorUsernameTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];

    //
    
    [self.doctorNameTextField addTarget:self action:@selector(textFieldDidEndEditing:)forControlEvents:UIControlEventEditingDidEnd];
    
    [self.doctorCRMTextField addTarget:self action:@selector(textFieldDidEndEditing:)forControlEvents:UIControlEventEditingDidEnd];
    
    [self.doctorTelephoneTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    [self.doctorPasswordTextField addTarget:self action:@selector(textFieldDidEndEditing:)forControlEvents:UIControlEventEditingDidEnd];
    
    [self.doctorConfirmPasswordTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    [self.doctorUsernameTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@"Nome"]) {
        textField.text = @"";
    }
    else if ([textField.text isEqualToString:@"CRM"]){
        textField.text = @"";
    }
    
    else if ([textField.text isEqualToString:@"Telefone"]){
        textField.text = @"";
    }
    
    else if ([textField.text isEqualToString:@"Senha"]){
        textField.text = @"";
    }
    
    else if ([textField.text isEqualToString:@"Confirmar senha"]){
        textField.text = @"";
    }
    
    else if ([textField.text isEqualToString:@"Nome de usuário"]){
        textField.text = @"";
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        switch (textField.tag) {
            case 0:
                textField.text = @"Nome";
                break;
            case 1:
                textField.text = @"CRM";
                break;
            case 2:
                textField.text = @"Telefone";
                break;
            case 3:
                textField.text = @"Senha";
                break;
            case 4:
                textField.text = @"Confirmar senha";
                break;
            case 5:
                textField.text = @"Nome de usuário";
                break;
            default:
                break;
        }
    }
}

- (IBAction)didTappedNextBarButton:(UIBarButtonItem *)sender{
    [self performSegueWithIdentifier:@"clickedInNextSignInSegueId" sender:self];
}

@end
