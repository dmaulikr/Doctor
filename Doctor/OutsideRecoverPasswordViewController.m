#import "OutsideRecoverPasswordViewController.h"
#import "OutsideRecoverNewPasswordViewController.h"
#import "Envio.h"
#import "Doctor.h"
#import "SVProgressHUD.h"

@import VerifyIosSdk;
@interface OutsideRecoverPasswordViewController () <UITextViewDelegate>{
    Doctor* doctorBeingRecovered;
}

@property (weak, nonatomic) IBOutlet UITextView* loginToRecoverTextView;
@property (weak, nonatomic) IBOutlet UIButton *confirmLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmTokenButton;
@property (weak, nonatomic) IBOutlet UITextView* firstTokenTextView;
@property (weak, nonatomic) IBOutlet UITextView* secondTokenTextView;
@property (weak, nonatomic) IBOutlet UITextView* thirdTokenTextView;
@property (weak, nonatomic) IBOutlet UITextView* fourTokenTextView;

@property (weak, nonatomic) IBOutlet UILabel* labelFirstToken;
@property (weak, nonatomic) IBOutlet UILabel* labelSecondToken;
@property (weak, nonatomic) IBOutlet UILabel* labelThirdToken;
@property (weak, nonatomic) IBOutlet UILabel* labelFourthToken;

@end

@implementation OutsideRecoverPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.navigationController.navigationBarHidden = NO;
    self.confirmTokenButton.layer.cornerRadius = 3;
    [self textViewSetups];
    [self.confirmLoginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self setupAlphas];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(5/255.0f) green:(65/255.0f) blue:(93/255.0f) alpha:1.0f]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.backItem.title = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
   // if ([_loginTextField isFirstResponder] && [touch view] != _loginTextField) [_loginTextField resignFirstResponder];
   // if ([_passwordTextField isFirstResponder] && [touch view] != _passwordTextField) [_passwordTextField resignFirstResponder];
}

#pragma mark - UITextViewDelegates
-(void)textViewDidChange:(UITextView *)textView{
    switch (textView.tag) {
        case 1:
            if (textView.text.length > 1) {
                textView.text = [textView.text substringWithRange:NSMakeRange(0, 1)];
            }
            if (![self.firstTokenTextView.text isEqualToString:@""] && ![self.secondTokenTextView.text isEqualToString:@""] && ![self.thirdTokenTextView.text isEqualToString:@""] && ![self.fourTokenTextView.text isEqualToString:@""]) {
                self.confirmTokenButton.backgroundColor = [UIColor colorWithRed:(245/255.0f) green:(146/255.0f) blue:(49/255.0f) alpha:1.0f];
               // [self codeInputComplete];
            }
            else{
                if (![textView.text isEqualToString:@""]) {
                    [self.secondTokenTextView becomeFirstResponder];
                }
                else{
                    self.confirmTokenButton.backgroundColor = [UIColor grayColor];
                }
            }
            break;
        case 2:
            if (textView.text.length > 1) {
                textView.text = [textView.text substringWithRange:NSMakeRange(0, 1)];
            }
            if (![self.firstTokenTextView.text isEqualToString:@""] && ![self.secondTokenTextView.text isEqualToString:@""] && ![self.thirdTokenTextView.text isEqualToString:@""] && ![self.fourTokenTextView.text isEqualToString:@""]) {
                self.confirmTokenButton.backgroundColor = [UIColor colorWithRed:(245/255.0f) green:(146/255.0f) blue:(49/255.0f) alpha:1.0f];
              //  [self codeInputComplete];
            }
            else{
                if (![textView.text isEqualToString:@""]) {
                    [self.thirdTokenTextView becomeFirstResponder];
                }
                else{
                    self.confirmTokenButton.backgroundColor = [UIColor grayColor];
                }
            }
            
            break;
        case 3:
            if (textView.text.length > 1) {
                textView.text = [textView.text substringWithRange:NSMakeRange(0, 1)];
            }
            if (![self.firstTokenTextView.text isEqualToString:@""] && ![self.secondTokenTextView.text isEqualToString:@""] && ![self.thirdTokenTextView.text isEqualToString:@""] && ![self.fourTokenTextView.text isEqualToString:@""]) {
               // [self codeInputComplete];
                self.confirmTokenButton.backgroundColor = [UIColor colorWithRed:(245/255.0f) green:(146/255.0f) blue:(49/255.0f) alpha:1.0f];
            }
            else{
                if (![textView.text isEqualToString:@""]) {
                    [self.fourTokenTextView becomeFirstResponder];
                }
                else{
                    self.confirmTokenButton.backgroundColor = [UIColor grayColor];
                }
            }
            
            break;
        case 4:
            if (textView.text.length > 1) {
                textView.text = [textView.text substringWithRange:NSMakeRange(0, 1)];
            }
            if (![self.firstTokenTextView.text isEqualToString:@""] && ![self.secondTokenTextView.text isEqualToString:@""] && ![self.thirdTokenTextView.text isEqualToString:@""] && ![self.fourTokenTextView.text isEqualToString:@""]) {
              //  [self codeInputComplete];
                self.confirmTokenButton.backgroundColor = [UIColor colorWithRed:(245/255.0f) green:(146/255.0f) blue:(49/255.0f) alpha:1.0f];
            }
            else{
                self.confirmTokenButton.backgroundColor = [UIColor grayColor];
            }
            break;
            
            case 100:
            if (textView.text.length > 0 && ![textView.text isEqualToString:@"Nome de usuário"]) {
                [self.confirmLoginButton setTitleColor:[UIColor colorWithRed:(245/255.0f) green:(146/255.0f) blue:(49/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            }
            else{
               [self.confirmLoginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            break;
        default:
            break;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.tag == 1 || textView.tag == 2 || textView.tag == 3 || textView.tag == 4) {
        //Scroll view when taps in the first textField
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.35f];
        CGRect frame = self.view.frame;
        frame.origin.y = -20;
        [self.view setFrame:frame];
        [UIView commitAnimations];
    }
    
    if (textView.tag == 100) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
//    if (textView.tag == 1 || textView.tag == 2 || textView.tag == 3 || textView.tag == 4) {
//        //Scroll view when taps in the first textField
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.35f];
//        CGRect frame = self.view.frame;
//        frame.origin.y = 20;
//        [self.view setFrame:frame];
//        [UIView commitAnimations];
//    }
    
    if (textView.tag == 100 && [textView.text isEqualToString:@""]) {
        textView.textColor = [UIColor grayColor];
        textView.text = @"Nome de usuário";
    }
}

#pragma mark - Setups
- (void) textViewSetups{
    [self.firstTokenTextView setDelegate:self];
    self.firstTokenTextView.tag = 1;
    [self.secondTokenTextView setDelegate:self];
    self.secondTokenTextView.tag = 2;
    [self.thirdTokenTextView setDelegate:self];
    self.thirdTokenTextView.tag = 3;
    [self.fourTokenTextView setDelegate:self];
    self.fourTokenTextView.tag = 4;
    
    [self.loginToRecoverTextView setDelegate:self];
    self.loginToRecoverTextView.tag = 100;
    self.loginToRecoverTextView.textColor = [UIColor grayColor];
}

- (void) setupAlphas{
    self.confirmTokenButton.hidden = YES;
    self.firstTokenTextView.hidden = YES;
    self.secondTokenTextView.hidden = YES;
    self.thirdTokenTextView.hidden = YES;
    self.fourTokenTextView.hidden = YES;
    self.labelFirstToken.hidden = YES;
    self.labelSecondToken.hidden = YES;
    self.labelThirdToken.hidden = YES;
    self.labelFourthToken.hidden = YES;
    
    self.confirmTokenButton.alpha = 0.0;
    self.firstTokenTextView.alpha = 0.0;
    self.secondTokenTextView.alpha = 0.0;
    self.thirdTokenTextView.alpha = 0.0;
    self.fourTokenTextView.alpha = 0.0;
    self.labelFirstToken.alpha = 0.0;
    self.labelSecondToken.alpha = 0.0;
    self.labelThirdToken.alpha = 0.0;
    self.labelFourthToken.alpha = 0.0;
}

- (void) liberateAlphas{
    self.confirmTokenButton.hidden = NO;
    self.firstTokenTextView.hidden = NO;
    self.secondTokenTextView.hidden = NO;
    self.thirdTokenTextView.hidden = NO;
    self.fourTokenTextView.hidden = NO;
    self.labelFirstToken.hidden = NO;
    self.labelSecondToken.hidden = NO;
    self.labelThirdToken.hidden = NO;
    self.labelFourthToken.hidden = NO;
    
    self.confirmTokenButton.alpha = 1.0;
    self.firstTokenTextView.alpha = 1.0;
    self.secondTokenTextView.alpha = 1.0;
    self.thirdTokenTextView.alpha = 1.0;
    self.fourTokenTextView.alpha = 1.0;
    self.labelFirstToken.alpha = 1.0;
    self.labelSecondToken.alpha = 1.0;
    self.labelThirdToken.alpha = 1.0;
    self.labelFourthToken.alpha = 1.0;
}

- (IBAction)confirmLoginButtonTapped:(id)sender{
    if (![[self.confirmLoginButton titleColorForState:UIControlStateNormal] isEqual:[UIColor grayColor]]) {
      //  [spinner startAnimating];
          [SVProgressHUD show];
        [self checkLoginInsert];
    }
}
    
    

- (IBAction)confirmTokenButtonTapped:(id)sender{
    if (self.confirmTokenButton.backgroundColor != [UIColor grayColor]) {
        NSString* token = [NSString stringWithFormat:@"%@%@%@%@", self.firstTokenTextView.text, self.secondTokenTextView.text, self.thirdTokenTextView.text, self.fourTokenTextView.text];
        [VerifyClient checkPinCode:token];
}
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"O código sms não foi inserido, complete o código e tente novamente." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - Private Methods
- (void) checkLoginInsert{
    [self.view endEditing:YES];
    Envio* envio = [[Envio alloc] init];
    [envio askedForRecoveringPassword:self.loginToRecoverTextView.text withCompletion: ^void(Doctor* doctor){
        
        [SVProgressHUD dismiss];
        if (doctor) {
            [UIView animateWithDuration:.5f animations:^{
                [self liberateAlphas];
                [self sendVerifyingMessage];
            } completion:^(BOOL finished) {
                doctorBeingRecovered = doctor;
            }];
        }
        else{
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção"
        message:@"Não encontramos ninguém na nossa base de dados com esse nome de usuário, que tal tentarmos de novo?"
        delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"tokenConfirmedSegue"]) {
        OutsideRecoverNewPasswordViewController* vc = segue.destinationViewController;
        [vc setDoctor:doctorBeingRecovered];
    }
}

- (void) sendVerifyingMessage{
    [VerifyClient getVerifiedUserWithCountryCode:@"BR" phoneNumber:doctorBeingRecovered.doctorContactString verifyInProgressBlock:^{} userVerifiedBlock:^{
        [self userVerifySuccess];
    }
    errorBlock:^(VerifyError error) {
        [VerifyClient cancelVerificationWithBlock:^(NSError *error){
            [self userVerifyFailed];
        }];
    }];
}

- (void) userVerifySuccess{
    [PFUser logInWithUsernameInBackground:doctorBeingRecovered.doctorUsernameString
                                 password:doctorBeingRecovered.doctorPasswordString
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self performSegueWithIdentifier:@"tokenConfirmedSegue" sender:self];
                                        }
                                    }];
}

- (void) userVerifyFailed{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"O código inserido está errado! Tem certeza de que o nome de usuário inserido está correto?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
