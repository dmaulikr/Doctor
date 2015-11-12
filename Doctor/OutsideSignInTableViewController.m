//
//  OutsideSignInTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "OutsideSignInTableViewController.h"
#import "OutsideSignInConfirmViewController.h"

@interface OutsideSignInTableViewController () <UIAlertViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView* doctorNameTextView;
@property (weak, nonatomic) IBOutlet UITextView* doctorCRMTextView;
@property (weak, nonatomic) IBOutlet UITextView* doctorTelephoneTextView;
@property (weak, nonatomic) IBOutlet UITextView* doctorPasswordTextView;
@property (weak, nonatomic) IBOutlet UITextView* doctorConfirmPasswordTextView;
@property (weak, nonatomic) IBOutlet UITextView* doctorUsernameTextView;
@property (weak, nonatomic) IBOutlet UITextView* doctorEmailTextView;
@property (weak, nonatomic) IBOutlet UILabel* doctorAreaCodeLabel;

@property (weak, nonatomic) IBOutlet UIImageView* doctorNameImageView;
@property (weak, nonatomic) IBOutlet UIImageView* doctorCRMImageView;
@property (weak, nonatomic) IBOutlet UIImageView* doctorTelephoneImageView;
@property (weak, nonatomic) IBOutlet UIImageView* doctorPasswordImageView;
@property (weak, nonatomic) IBOutlet UIImageView* doctorConfirmPasswordImageView;
@property (weak, nonatomic) IBOutlet UIImageView* doctorUsernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView* doctorEmailImageView;
@property (weak, nonatomic) IBOutlet UIImageView* doctorAreaCodeImageView;

@end

NSString *const kTextToAlertViewAsBlankFields = @"Preencha todos os campos, esses dados só serão usados para verificar sua veracidade. Talvez a senha não digitada não tenha sido a mesma.";

@implementation OutsideSignInTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTextViewsDelegates];
    self.tableView.tableFooterView = [UIView new];
    self.doctorPasswordTextView.secureTextEntry = YES;
    self.doctorConfirmPasswordTextView.secureTextEntry = YES;
    self.doctorAreaCodeLabel.textColor = [UIColor grayColor];

    UITapGestureRecognizer* tapAreaCode = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedIntoAreaCodeLabel)];
    [self.doctorAreaCodeLabel setUserInteractionEnabled:YES];
    [self.doctorAreaCodeLabel addGestureRecognizer:tapAreaCode];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.topItem.title = @"Registrar";
    self.navigationController.navigationBar.backItem.title = @"";
}

#pragma mark - IBActions
- (IBAction)didTappedNextBarButton:(UIBarButtonItem *)sender{
    if ([self checkFieldsCompletion]) {
        [self showAlertViewConfirmation];
    }
    else{
        [self showAlertViewBecauseOfBlankFields];
    }
}

#pragma mark - Private Methods
- (BOOL) checkFieldsCompletion{
    BOOL returning = true;
    if (![self.doctorNameTextView.text isEqualToString:@""] && ![self.doctorCRMTextView.text isEqualToString:@""] && ![self.doctorConfirmPasswordTextView.text isEqualToString:@""] && ![self.doctorPasswordTextView.text isEqualToString:@""] && ![self.doctorTelephoneTextView.text isEqualToString:@""] && ![self.doctorUsernameTextView.text isEqualToString:@""]) {
        if ([self.doctorPasswordTextView.text isEqualToString:self.doctorConfirmPasswordTextView.text]) {
            returning = true;
        }
    }
    return returning;
}

- (void) showAlertViewConfirmation{
    
    
    NSString* stringToShow = [[NSString alloc] initWithFormat:@"Favor confirmar os dados abaixo:\nNome: %@\nCRM: %@\nNome de usuário: %@\nTelefone: +55 81 %@", self.doctorNameTextView.text, self.doctorCRMTextView.text, self.doctorUsernameTextView.text, self.doctorTelephoneTextView.text];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Os dados estão corretos?" message:stringToShow delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Confirmar", nil];
    [alert show];
}

- (void) showAlertViewBecauseOfBlankFields{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ops! Esqueceu algo?" message:kTextToAlertViewAsBlankFields delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

//- (void) sendVerifyingMessage{
//    //SEM O NOVE NA FRENTE!
//    NSString* phoneNumberToCheck = [[NSString alloc] initWithFormat:@"81%@", self.doctorTelephonetextview.text];
//    [VerifyClient getVerifiedUserWithCountryCode:@"BR" phoneNumber:phoneNumberToCheck verifyInProgressBlock:^{
//            // called when the verification process begins
//        }
//                               userVerifiedBlock:^{
//                                   // called when the user has been successfully verified
//                               }
//                                      errorBlock:^(VerifyError error) {
//                                          // called when some error occurrs during verification, e.g. wrong pin entered.
//                                          // see the VerifyError class for details on what to expect
//                                      }];
//}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
    //    [self sendVerifyingMessage];
        [self performSegueWithIdentifier:@"clickedInNextSignInSegueId" sender:self];
    }
}

#pragma mark - Storyboard Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"clickedInNextSignInSegueId"]) {
        OutsideSignInConfirmViewController* confirmVC = segue.destinationViewController;
        [confirmVC setPhoneAsAParameter:self.doctorTelephoneTextView.text];
    }
}

- (BOOL)textviewShouldReturn:(UITextView *)textview{
    [textview resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    if ([_doctorNameTextView isFirstResponder] && [touch view] != _doctorNameTextView) [_doctorNameTextView resignFirstResponder];
    if ([_doctorCRMTextView isFirstResponder] && [touch view] != _doctorCRMTextView) [_doctorCRMTextView resignFirstResponder];
    if ([_doctorPasswordTextView isFirstResponder] && [touch view] != _doctorPasswordTextView) [_doctorPasswordTextView resignFirstResponder];
    if ([_doctorUsernameTextView isFirstResponder] && [touch view] != _doctorUsernameTextView) [_doctorUsernameTextView resignFirstResponder];
    if ([_doctorConfirmPasswordTextView isFirstResponder] && [touch view] != _doctorConfirmPasswordTextView) [_doctorConfirmPasswordTextView resignFirstResponder];
    if ([_doctorTelephoneTextView isFirstResponder] && [touch view] != _doctorTelephoneTextView) [_doctorTelephoneTextView resignFirstResponder];
}

#pragma mark PhotoPicker

- (IBAction)takePhoto:(UIButton *)sender{
    UIImagePickerController* takePhotoView = [[UIImagePickerController alloc] init];
    takePhotoView.delegate = self;
    takePhotoView.allowsEditing = YES;
    takePhotoView.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:takePhotoView animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(UIButton *)sender{
    
    UIImagePickerController *selectPhotoView = [[UIImagePickerController alloc] init];
    selectPhotoView.delegate = self;
    selectPhotoView.allowsEditing = YES;
    selectPhotoView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:selectPhotoView animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSData* photoData = [[NSData alloc]init];
    photoData = UIImageJPEGRepresentation(chosenImage, 0.5f );
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void) didClickedIntoAreaCodeLabel{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Pernambuco (81)",@"Pernambuco (87)", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            self.doctorAreaCodeLabel.text = @"81";
            break;
        case 1:
            self.doctorAreaCodeLabel.text = @"87";
            break;
        default:
        break;
    }
    self.doctorAreaCodeImageView.image = [UIImage imageNamed:@"registrar-telefone-laranjaw"];
}

- (void) setTextViewsDelegates{
    self.doctorNameTextView.delegate = self;
    self.doctorNameTextView.tag = 1;
    
    self.doctorCRMTextView.delegate = self;
    self.doctorCRMTextView.tag = 2;
    
    self.doctorTelephoneTextView.delegate = self;
    self.doctorTelephoneTextView.tag = 3;
    
    self.doctorPasswordTextView.delegate = self;
    self.doctorPasswordTextView.tag = 4;
    
    self.doctorConfirmPasswordTextView.delegate = self;
    self.doctorConfirmPasswordTextView.tag = 5;
    
    self.doctorUsernameTextView.delegate = self;
    self.doctorUsernameTextView.tag = 6;
    
    self.doctorEmailTextView.delegate = self;
    self.doctorEmailTextView.tag = 7;
}

#pragma mark - UITextView Delegates
- (void)textViewDidChange:(UITextView *)textView{
    switch (textView.tag) {
        case 1:
            self.doctorNameImageView.image = [UIImage imageNamed:@"registrar-nome-laranja"];
            break;
        case 2:
            self.doctorCRMImageView.image = [UIImage imageNamed:@"registrar-crm-laranja"];
            break;
        case 3:
            self.doctorTelephoneImageView.image = [UIImage imageNamed:@"registrar-telefone-laranja"];
            break;
        case 4:
            self.doctorPasswordImageView.image = [UIImage imageNamed:@"registrar-senha-laranja"];
            break;
        case 5:
            self.doctorConfirmPasswordImageView.image = [UIImage imageNamed:@"registrar-senha-laranja"];
            break;
        case 6:
            self.doctorUsernameImageView.image = [UIImage imageNamed:@"registrar-pessoinha-laranja"];
            break;
        case 7:
            self.doctorEmailImageView.image = [UIImage imageNamed:@"registrar-email-laranja"];
            break;
        default:
            break;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    switch (textView.tag) {
        case 1:
            if ([textView.text isEqualToString:@"Nome"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor];
            }
            break;
        case 2:
            if ([textView.text isEqualToString:@"CRM"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor];
            }
            break;
        case 3:
            if ([textView.text isEqualToString:@"Telefone"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor];
            }
            break;
        case 4:
            if ([textView.text isEqualToString:@"Senha"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor];
            }
            break;
        case 5:
            if ([textView.text isEqualToString:@"Confirme senha"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor];
            }
            break;
        case 6:
            if ([textView.text isEqualToString:@"Nome de usuário"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor];
            }
            break;
        case 7:
            if ([textView.text isEqualToString:@"E-mail"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor];
            }
            break;
            
        default:
            break;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    switch (textView.tag) {
        case 1:
            if ([textView.text isEqualToString:@""]) {
                textView.textColor = [UIColor grayColor];
                textView.text = @"Nome";
                self.doctorNameImageView.image = [UIImage imageNamed:@"registrar-nome"];
            }
            break;
        case 2:
            if ([textView.text isEqualToString:@""]) {
                textView.textColor = [UIColor grayColor];
                textView.text = @"CRM";
                self.doctorCRMImageView.image = [UIImage imageNamed:@"registrar-crm"];
            }
            break;
        case 3:
            if ([textView.text isEqualToString:@""]) {
                textView.textColor = [UIColor grayColor];
                textView.text = @"Telefone";
                self.doctorTelephoneImageView.image = [UIImage imageNamed:@"registrar-telefone"];
            }
            break;
        case 4:
            if ([textView.text isEqualToString:@""]) {
                textView.textColor = [UIColor grayColor];
                textView.text = @"Senha";
                self.doctorPasswordImageView.image = [UIImage imageNamed:@"home-lock"];
            }
            break;
        case 5:
            if ([textView.text isEqualToString:@""]) {
                textView.textColor = [UIColor grayColor];
                textView.text = @"Confirme senha";
                self.doctorConfirmPasswordImageView.image = [UIImage imageNamed:@"home-lock"];
            }
            break;
        case 6:
            if ([textView.text isEqualToString:@""]) {
                textView.textColor = [UIColor grayColor];
                textView.text = @"Nome de usuário";
                self.doctorUsernameImageView.image = [UIImage imageNamed:@"home-usuario"];
            }
        case 7:
            if ([textView.text isEqualToString:@""]) {
                textView.textColor = [UIColor grayColor];
                textView.text = @"E-mail";
                self.doctorEmailImageView.image = [UIImage imageNamed:@"icone-email"];
            }
            break;
        default:
            break;
    }
}

@end
