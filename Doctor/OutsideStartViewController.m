#import "OutsideStartViewController.h"
#import "MFSideMenu.h"
#import "Storyboards.h"
#import "Parse.h"
#import "AppDelegate.h"
#import "Envio.h"
#import "SVProgressHUD.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface OutsideStartViewController () <UITextFieldDelegate>{
    UIActivityIndicatorView* spinner;
    CGFloat animatedDistance;
}

@property (weak, nonatomic) IBOutlet UITextField* loginTextField;
@property (weak, nonatomic) IBOutlet UITextField* passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton* loginButton;

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
    self.loginButton.layer.cornerRadius = 3;
    self.menuContainerViewController.panMode = NO;
    self.passwordTextField.secureTextEntry = YES;
}

- (void) viewWillAppear:(BOOL)animated{
    [PFUser logOut];
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    if ([_loginTextField isFirstResponder] && [touch view] != _loginTextField) [_loginTextField resignFirstResponder];
    if ([_passwordTextField isFirstResponder] && [touch view] != _passwordTextField) [_passwordTextField resignFirstResponder];
}

- (void) tryToLogin{
    [self.view endEditing:YES];
    if (![self.loginTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]) {
        [SVProgressHUD show];
        [self.loginButton setEnabled:NO];
        Envio* envio = [[Envio alloc]init];
        [envio logIn:self.loginTextField.text withPassword:self.passwordTextField.text :^void (BOOL finished){
            if (finished) {
                [envio verifyAuthenticity:self.loginTextField.text :self.passwordTextField.text :^void (BOOL finished){
                    [self startFadeOutTransactionEffect];
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

#pragma mark - Private methods
- (void) startFadeOutTransactionEffect{
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

#pragma mark - UITextField
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        if ([[UIScreen mainScreen] bounds].size.height < 667){
            CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
            CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
            CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
            CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
            CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
            CGFloat heightFraction = numerator / denominator;
            if (heightFraction < 0.0){
                heightFraction = 0.0;
            }
            else if (heightFraction > 1.0){
                heightFraction = 1.0;
            }
            UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
            if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown){
                animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
            }
            else{
                animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
            }
            CGRect viewFrame = self.view.frame;
            viewFrame.origin.y -= animatedDistance;
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
            
            [self.view setFrame:viewFrame];
            
            [UIView commitAnimations];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textfield{
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField.tag == 2) {
        [textField resignFirstResponder];
        [self tryToLogin];
    }
    return YES;
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

@end
