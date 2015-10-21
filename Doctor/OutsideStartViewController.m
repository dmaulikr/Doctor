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

@interface OutsideStartViewController () <UITextFieldDelegate>

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
    
}

- (void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - IBActions
- (IBAction)didTappedLoginButton:(UIButton *)sender{
    self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kFeedStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kFeedNavID];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
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
    
    //
    
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

@end
