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
#import "AppDelegate.h"
#import "Envio.h"
#import "SVProgressHUD.h"

@interface OutsideStartViewController () <UITextFieldDelegate>{
    Authentication* authentication;
    UIActivityIndicatorView* spinner;
}

@property (weak, nonatomic) IBOutlet UITextField* loginTextField;
@property (weak, nonatomic) IBOutlet UITextField* passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton* loginButton;

//Only fade elements
@property (weak, nonatomic) IBOutlet UIImageView* logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView* fieldsBgImageView;
@property (weak, nonatomic) IBOutlet UIButton* recoverPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton* signInButton;
@property (weak, nonatomic) IBOutlet UILabel* separatorLabel;
@property (weak, nonatomic) IBOutlet UIImageView* lockImageView;
@property (weak, nonatomic) IBOutlet UIImageView* userImageView;



@end

@implementation OutsideStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLoadingAnimation];
    self.loginButton.layer.cornerRadius = 3;
    self.menuContainerViewController.panMode = NO;
// [self setupTextFieldDelegates];
    authentication = [[Authentication alloc] init];
    self.passwordTextField.secureTextEntry = YES;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
  //IN CASE OF NEED:
//    PFObject *gameScore = [PFObject objectWithClassName:@"Users"];
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
    [PFUser logOut];
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - IBActions
- (IBAction)didTappedLoginButton:(UIButton *)sender{
    [self tryToLogin];
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
    self.loginTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [self.loginTextField addTarget:self action:@selector(textFieldDidBeginEditing:)forControlEvents:UIControlEventEditingDidBegin];
    [self.passwordTextField addTarget:self action:@selector(textFieldDidBeginEditing:)forControlEvents:UIControlEventEditingDidBegin];
    [self.loginTextField addTarget:self action:@selector(textFieldDidEndEditing:)forControlEvents:UIControlEventEditingDidEnd];
    [self.passwordTextField addTarget:self action:@selector(textFieldDidEndEditing:)forControlEvents:UIControlEventEditingDidEnd];
}

#pragma mark - UITextFieldDelegates
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if ([textField.text isEqualToString:@"Login"]) {
//        textField.text = @"";
//    }
//    else if ([textField.text isEqualToString:@"Senha"]){
//        textField.text = @"";
//    }
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if ([textField.text isEqualToString:@""]) {
//        switch (textField.tag) {
//            case 0:
//                textField.text = @"Login";
//                break;
//            case 1:
//                textField.text = @"Senha";
//                break;
//            default:
//                break;
//        }
//    }
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    switch (textField.tag) {
        case 1:
        //    [self.passwordTextField becomeFirstResponder];
            break;
        case 2:
            [textField resignFirstResponder];
            [self tryToLogin];
            break;
        default:
            break;
    }
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    if ([_loginTextField isFirstResponder] && [touch view] != _loginTextField) [_loginTextField resignFirstResponder];
    if ([_passwordTextField isFirstResponder] && [touch view] != _passwordTextField) [_passwordTextField resignFirstResponder];
}


- (void) setupLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
}

- (BOOL) checkFieldCompletion{
    BOOL returning = false;
    if (![self.loginTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]) {
        returning = true;
    }
    return returning;
}


- (void) tryToLogin{
    
        [self.view endEditing:YES];
        if ([self checkFieldCompletion]) {
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
            [SVProgressHUD setForegroundColor:[UIColor orangeColor]];
            [SVProgressHUD show];
            [self.loginButton setEnabled:NO];
    
            Envio* envio = [[Envio alloc]init];
            Authentication* auth = [Authentication alloc];
            [envio logIn:self.loginTextField.text withPassword:self.passwordTextField.text :^void (BOOL finished){
                if (finished) {
                    [auth verifyAuthenticity:self.loginTextField.text :self.passwordTextField.text :^void (BOOL finished){
                        [self fadeOutGUI];
                        [SVProgressHUD dismiss];
                        [self.loginButton setEnabled:YES];
                    }];
                }
                else{
                    [self.view endEditing:YES];
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Não foi possível realizar o login, verifique seu usuário/senha e tente novamente." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alert show];
                    [self.loginButton setEnabled:YES];
                    
                    [SVProgressHUD dismiss];
                }
            }];
        }
        else{
            [self.view endEditing:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Preencha os campos em branco e tente novamente." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    [self.view endEditing:YES];
}

- (void) fadeOutGUI{
    [UIView animateWithDuration:.3f animations:^{
        self.loginTextField.alpha = 0;
        self.passwordTextField.alpha = 0;
        self.loginButton.alpha = 0;
        self.signInButton.alpha = 0;
        self.recoverPasswordButton.alpha = 0;
        self.fieldsBgImageView.alpha = 0;
        self.separatorLabel.alpha = 0;
        self.lockImageView.alpha = 0;
        self.userImageView.alpha = 0;
        
        } completion:^(BOOL finished){
            AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
            self.menuContainerViewController.centerViewController = [[UIStoryboard
                                                                      storyboardWithName:kFeedStoryboard
                                                                      bundle:nil]
                                                                     instantiateViewControllerWithIdentifier:appDelegate.doctor.isFirstTime ? kFeedFTNavID: kFeedNavID];
            
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
    }];
}
@end
