//
//  OutsideRecoverNewPasswordViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/12/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "OutsideRecoverNewPasswordViewController.h"

@interface OutsideRecoverNewPasswordViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView* itsFineTextView;

@property (nonatomic, weak) IBOutlet UITextView* passwordTextView;
@property (nonatomic, weak) IBOutlet UIImageView* passwordImageView;

@property (nonatomic, weak) IBOutlet UITextView* passwordConfirmTextView;
@property (nonatomic, weak) IBOutlet UIImageView* passwordConfirmImageView;

@end

@implementation OutsideRecoverNewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDelegates];
    self.passwordConfirmTextView.secureTextEntry = YES;
    self.passwordTextView.secureTextEntry = YES;
}

- (void) setupDelegates{
    self.itsFineTextView.delegate = self;
    self.passwordTextView.delegate = self;
    self.passwordConfirmTextView.delegate = self;
    
    self.itsFineTextView.tag = 1;
    self.passwordTextView.tag = 2;
    self.passwordConfirmTextView.tag = 3;
}

- (IBAction)didTappedNextButton:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) textViewDidBeginEditing:(UITextView *)textView{
    switch (textView.tag) {
        case 2:
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
            break;
        case 3:
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
            break;
        default:
            break;
    }
}
- (void)textViewDidChange:(UITextView *)textView{
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    switch (textView.tag) {
        case 2:
            if ([textView.text isEqualToString:@""]) {
                textView.textColor = [UIColor grayColor];
                textView.text = @"Nova senha";
            }
            break;
            case 3:
            if ([textView.text isEqualToString:@""]) {
                textView.textColor = [UIColor grayColor];
                textView.text = @"Confirme senha";
            }
            break;
        default:
            break;
    }
}

@end
