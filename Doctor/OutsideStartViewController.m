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
#import "Authentication.h"
#import "Parse.h"
#import "Envio.h"

@interface OutsideStartViewController () <UITextFieldDelegate>{
    Authentication* authentication;
}

@property (weak, nonatomic) IBOutlet UITextField* loginTextField;
@property (weak, nonatomic) IBOutlet UITextField* passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton* loginButton;

@end

@implementation OutsideStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.layer.cornerRadius = 3;
    self.menuContainerViewController.panMode = NO;
    [self setupTextFieldDelegates];
    authentication = [[Authentication alloc] init];
    
  //IN CASE OF NEED:
//    PFObject *gameScore = [PFObject objectWithClassName:@"User"];
//    gameScore[@"username"] = @"bm";
//    gameScore[@"password"] = @"bm";
//    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            // The object has been saved.
//        } else {
//            // There was a problem, check error.description
//        }
//    }];
//    
    
}

- (void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - IBActions
- (IBAction)didTappedLoginButton:(UIButton *)sender{
//    
//    Doctor* doctor = [[Doctor alloc]init];
//    doctor.doctorUsernameString = self.loginTextField.text;
//    doctor.doctorPasswordString = self.passwordTextField.text;
//    
//    Envio* envio = [[Envio alloc]init];
//    [envio signIn:doctor];
//    
    [authentication verifyAuthenticity:self.loginTextField.text :self.passwordTextField.text :^void (BOOL finished){
        if (finished) {
            self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kFeedStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kFeedNavID];
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
        }else{
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Houve algo errado." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];

    

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

#pragma mark - Setups
- (void)setupTextFieldDelegates{
    [self.loginTextField addTarget:self action:@selector(textFieldDidBeginEditing:)forControlEvents:UIControlEventEditingDidBegin];
    [self.passwordTextField addTarget:self action:@selector(textFieldDidBeginEditing:)forControlEvents:UIControlEventEditingDidBegin];
    [self.loginTextField addTarget:self action:@selector(textFieldDidEndEditing:)forControlEvents:UIControlEventEditingDidEnd];
    [self.passwordTextField addTarget:self action:@selector(textFieldDidEndEditing:)forControlEvents:UIControlEventEditingDidEnd];
}

#pragma mark - UITextFieldDelegates
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@"Login"]) {
        textField.text = @"";
    }
    else if ([textField.text isEqualToString:@"Senha"]){
        textField.text = @"";
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        switch (textField.tag) {
            case 0:
                textField.text = @"Login";
                break;
            case 1:
                textField.text = @"Senha";
                break;
            default:
                break;
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    if ([_loginTextField isFirstResponder] && [touch view] != _loginTextField) [_loginTextField resignFirstResponder];
    if ([_passwordTextField isFirstResponder] && [touch view] != _passwordTextField) [_passwordTextField resignFirstResponder];
}
@end
