//
//  SettingsChangePasswordTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/16/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "SettingsChangePasswordTableViewController.h"
#import "Envio.h"
#import "AppDelegate.h"

@interface SettingsChangePasswordTableViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView* currentPasswordTextView;
@property (nonatomic, weak) IBOutlet UITextView* novoPasswordTextView;
@property (nonatomic, weak) IBOutlet UITextView* confirmNewPasswordTextView;

@end

@implementation SettingsChangePasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextViewsDelegates];
    self.tableView.tableFooterView = [UIView new];
}

- (IBAction)savePasswordChanged:(id)sender{
    if ([self.currentPasswordTextView.text isEqualToString:self.doctor.doctorPasswordString]) {
        
        if([self.novoPasswordTextView.text isEqualToString:self.confirmNewPasswordTextView.text]){
            Envio* envio = [[Envio alloc] init];
            [envio askedForChangingPassword:self.doctor :self.confirmNewPasswordTextView.text withCompletion:^void(BOOL finished){
                if (finished) {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Sua senha foi alterada com sucesso!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                    appDelegate.doctor.doctorPasswordString = self.confirmNewPasswordTextView.text;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else{
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Algo aconteceu e sua nova senha não foi salva, tente novamente!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }];

        
        }else{
            UIAlertView *alert2 = [[UIAlertView alloc]
                                  initWithTitle:@"Atenção"
                                  message:@"As senhas inseridas não são iguais, tente novamente!"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil, nil];
            [alert2 show];
        }
    
    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Atenção"
                              message:@"A senha atual não confere, tente novamente!"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)setupTextViewsDelegates{
    self.currentPasswordTextView.delegate = self;
    self.currentPasswordTextView.tag = 1;
    
    self.novoPasswordTextView.delegate = self;
    self.novoPasswordTextView.tag = 2;
    
    self.confirmNewPasswordTextView.delegate = self;
    self.confirmNewPasswordTextView.tag = 3;
}

- (void) textViewDidBeginEditing:(UITextView *)textView{
    switch (textView.tag) {
        case 1:
            textView.textColor = [UIColor blackColor];
            textView.text = @"";
            break;
        case 2:
            textView.textColor = [UIColor blackColor];
            textView.text = @"";
            break;
        case 3:
            textView.textColor = [UIColor blackColor];
            textView.text = @"";
            break;
        default:
            break;
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView{
    switch (textView.tag) {
        case 1:
            if ([textView.text isEqualToString:@""]) {
                textView.textColor = [UIColor darkGrayColor];
                textView.text = @"Senha atual";
            }
            break;
        case 2:
            if ([textView.text isEqualToString:@""]) {
                textView.textColor = [UIColor darkGrayColor];
                textView.text = @"Nova senha";
            }
            break;
        case 3:
            if ([textView.text isEqualToString:@""]) {
                textView.textColor = [UIColor darkGrayColor];
                textView.text = @"Repetir nova senha";
            }
            break;
        default:
            break;
    }
}

@end
