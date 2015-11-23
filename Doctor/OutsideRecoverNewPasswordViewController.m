//
//  OutsideRecoverNewPasswordViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/12/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "Doctor.h"
#import "OutsideRecoverNewPasswordViewController.h"
#import "Envio.h"


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
    self.itsFineTextView.text = [NSString stringWithFormat:@"Olá, %@. Sua senha foi resetada com sucesso e você agora pode criar uma nova", self.doctor.doctorNameString];
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
    if (![self.passwordTextView.text isEqualToString:@""] && ![self.passwordConfirmTextView.text isEqualToString:@""]) {
        [self confirmPasswordChanging];
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Há campos em branco, por favor preencha os dois campos com a mesma senha." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
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

- (void) confirmPasswordChanging{
    if ([self.passwordTextView.text isEqualToString:self.passwordConfirmTextView.text]) {
        Envio* envio = [[Envio alloc] init];
        [envio askedForChangingPassword:self.doctor :self.passwordConfirmTextView.text withCompletion:^void(BOOL finished){
            if (finished) {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Sua senha foi alterada com sucesso!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else{
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Algo aconteceu e sua nova senha não foi salva, tente novamente!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
        
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"As senhas inseridas não são iguais, por favor: tente novamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
