//
//  OutsideRecoverPasswordViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/16/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "OutsideRecoverPasswordViewController.h"

@interface OutsideRecoverPasswordViewController () <UITextViewDelegate>

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
    self.navigationController.navigationBarHidden = NO;
    self.confirmTokenButton.layer.cornerRadius = 3;
    [self textViewSetups];
    [self.confirmLoginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self setupAlphas];
}

- (void)viewWillAppear:(BOOL)animated{
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
    if (textView.tag == 100) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
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
    if (self.confirmLoginButton.titleLabel.textColor != [UIColor grayColor]) {
        [UIView animateWithDuration:.5f animations:^{
            [self liberateAlphas];
        } completion:^(BOOL finished) {}];
    }
}

- (IBAction)confirmTokenButtonTapped:(id)sender{
    if (self.confirmTokenButton.backgroundColor != [UIColor grayColor]) {
        [self performSegueWithIdentifier:@"tokenConfirmedSegue" sender:self];
    }
}

@end
