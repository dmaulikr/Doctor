#import "OutsideSignInConfirmViewController.h"
#import <Parse.h>
#import "Envio.h"
#import "AppDelegate.h"
#import "Storyboards.h"
#import "MFSideMenu.h"

@import VerifyIosSdk;
@interface OutsideSignInConfirmViewController () <UITextViewDelegate, UIAlertViewDelegate>{
    NSString* token;
}

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
    [self sendVerifyingMessage];
    [self textViewSetups];
    self.confirmButton.backgroundColor = [UIColor grayColor];
    NSString* cellPhoneSentWas = [[NSString alloc] initWithFormat:@"+55 %@", self.doctorBeingCreated.doctorContactString];
    self.cellPhoneToSendConfirmationLabel.text = cellPhoneSentWas;
    self.confirmButton.layer.cornerRadius = 3;
    self.navigationController.navigationBar.backItem.title = @"";
}

- (void) sendVerifyingMessage{
//    //SEM O NOVE NA FRENTE!
    NSString* phoneNumberToCheck = [[NSString alloc] initWithFormat:@"%@", self.doctorBeingCreated.doctorContactString];
    [VerifyClient getVerifiedUserWithCountryCode:@"BR" phoneNumber:phoneNumberToCheck verifyInProgressBlock:^{
        // called when the verification process begins
    }
                               userVerifiedBlock:^{
                                   [self userVerifySuccess];
                               }
                                      errorBlock:^(VerifyError error) {
                                          [VerifyClient cancelVerificationWithBlock:^(NSError *error){
                                              [self userVerifyFailed];
                                          }];
                                        }];
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
    if (self.confirmButton.backgroundColor != [UIColor grayColor]) {
        [self codeInputComplete];
    }
}

#pragma mark - UITextViewDelegates
-(void)textViewDidChange:(UITextView *)textView{
    switch (textView.tag) {
        case 1:
            if (textView.text.length > 1) {
                textView.text = [textView.text substringWithRange:NSMakeRange(0, 1)];
            }
            if (![self.firstTokenCharacterTextView.text isEqualToString:@""] && ![self.secondTokenCharacterTextView.text isEqualToString:@""] && ![self.thirdTokenCharacterTextView.text isEqualToString:@""] && ![self.fourthTokenCharacterTextView.text isEqualToString:@""]) {
                self.confirmButton.backgroundColor = [UIColor colorWithRed:(222/255.0f) green:(132/255.0f) blue:(45/255.0f) alpha:1.0f];
                [self codeInputComplete];
            }
            else{
                if (![textView.text isEqualToString:@""]) {
                    [self.secondTokenCharacterTextView becomeFirstResponder];
                 }
                else{
                    self.confirmButton.backgroundColor = [UIColor grayColor];
                }
            }
            break;
        case 2:
            if (textView.text.length > 1) {
                textView.text = [textView.text substringWithRange:NSMakeRange(0, 1)];
            }
            if (![self.firstTokenCharacterTextView.text isEqualToString:@""] && ![self.secondTokenCharacterTextView.text isEqualToString:@""] && ![self.thirdTokenCharacterTextView.text isEqualToString:@""] && ![self.fourthTokenCharacterTextView.text isEqualToString:@""]) {
                self.confirmButton.backgroundColor = [UIColor colorWithRed:(222/255.0f) green:(132/255.0f) blue:(45/255.0f) alpha:1.0f];
                [self codeInputComplete];
            }
            else{
                if (![textView.text isEqualToString:@""]) {
                    [self.thirdTokenCharacterTextView becomeFirstResponder];
                }
                else{
                    self.confirmButton.backgroundColor = [UIColor grayColor];
                }
            }

            break;
        case 3:
            if (textView.text.length > 1) {
                textView.text = [textView.text substringWithRange:NSMakeRange(0, 1)];
            }
            if (![self.firstTokenCharacterTextView.text isEqualToString:@""] && ![self.secondTokenCharacterTextView.text isEqualToString:@""] && ![self.thirdTokenCharacterTextView.text isEqualToString:@""] && ![self.fourthTokenCharacterTextView.text isEqualToString:@""]) {
                [self codeInputComplete];
                self.confirmButton.backgroundColor = [UIColor colorWithRed:(222/255.0f) green:(132/255.0f) blue:(45/255.0f) alpha:1.0f];
            }
            else{
                if (![textView.text isEqualToString:@""]) {
                    [self.fourthTokenCharacterTextView becomeFirstResponder];
                }
                else{
                    self.confirmButton.backgroundColor = [UIColor grayColor];
                }
            }

            break;
        case 4:
            if (textView.text.length > 1) {
                textView.text = [textView.text substringWithRange:NSMakeRange(0, 1)];
            }
            if (![self.firstTokenCharacterTextView.text isEqualToString:@""] && ![self.secondTokenCharacterTextView.text isEqualToString:@""] && ![self.thirdTokenCharacterTextView.text isEqualToString:@""] && ![self.fourthTokenCharacterTextView.text isEqualToString:@""]) {
                [self codeInputComplete];
                self.confirmButton.backgroundColor = [UIColor colorWithRed:(222/255.0f) green:(132/255.0f) blue:(45/255.0f) alpha:1.0f];
            }
            else{
                self.confirmButton.backgroundColor = [UIColor grayColor];
            }
            break;
        default:
            break;
    }
}

- (void) codeInputComplete{
    NSString* codeInput = [[NSString alloc] initWithFormat:@"O código inserido:\n%@%@%@%@\n Confere?", self.firstTokenCharacterTextView.text, self.secondTokenCharacterTextView.text, self.thirdTokenCharacterTextView.text, self.fourthTokenCharacterTextView.text];
    
    token = [NSString stringWithFormat:@"%@%@%@%@", self.firstTokenCharacterTextView.text, self.secondTokenCharacterTextView.text, self.thirdTokenCharacterTextView.text, self.fourthTokenCharacterTextView.text];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:codeInput delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Confirmar", nil];
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
                if (token) [VerifyClient checkPinCode:token];
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

- (void) userVerifySuccess{
    Envio* envio = [[Envio alloc]init];
    [envio newDoctor:self.doctorBeingCreated withCompletion:^void (BOOL* finished){
        if (finished) {
            [envio verifyAuthenticity:self.doctorBeingCreated.doctorUsernameString :self.doctorBeingCreated.doctorPasswordString :^void (BOOL finished){
                
                AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                self.menuContainerViewController.centerViewController = [[UIStoryboard
                                                                          storyboardWithName:kFeedStoryboard
                                                                          bundle:nil]
                                                                         instantiateViewControllerWithIdentifier:appDelegate.doctor.isFirstTime ? kFeedFTNavID: kFeedNavID];
                
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
            }];
        }
    }];
}

- (void) userVerifyFailed{
    UIAlertView* alert = [[UIAlertView alloc]
                          initWithTitle:@"Atenção"
                          message:@"Não foi possível verificar o seu nome de usuário, tente novamente mais tarde."
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil];
    [alert show];
}


@end





