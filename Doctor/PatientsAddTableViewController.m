//
//  PatientsAddTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/29/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientsAddTableViewController.h"
#import "Patient.h"
#import "Envio.h"
#import "UIImageResizing.h"
#import "BirthDateViewController.h"

@interface PatientsAddTableViewController () <UITextViewDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>{
    UIImagePickerController* imagePickerController;
    BOOL tookFromCamera;
}

- (void)didClickedIntoSexLabel;
- (void)setupSexGestureRecognizer;
- (void)setupBloodGestureRecognizer;
- (void)didClickedIntoBirthDateLabel;
- (void) setBirthDateLabel:(NSNotification *)notice;

@property (weak, nonatomic) IBOutlet UIImageView* cameraImageView;

@property (weak, nonatomic) IBOutlet UITextView* patientNameTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientSurnameTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientTelephoneTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientBirthdateTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientSexTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientBloodTypeTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientClinicalConditionsTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientMedicationsTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientAlergiesTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientObservationsTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientWeightTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientHeightTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientEmergencyContactTextView;
@property (weak, nonatomic) IBOutlet UITextView* patientAdressTextView;

@property (weak, nonatomic) IBOutlet UIImageView* patientBirthdateImageView;
@property (weak, nonatomic) IBOutlet UIImageView* patientSexImageView;
@property (weak, nonatomic) IBOutlet UIImageView* patientBloodTypeImageView;
@property (weak, nonatomic) IBOutlet UIImageView* patientClinicalConditionsImageView;
@property (weak, nonatomic) IBOutlet UIImageView* patientMedicationsImageView;
@property (weak, nonatomic) IBOutlet UIImageView* patientAlergiesImageView;
@property (weak, nonatomic) IBOutlet UIImageView* patientObservationsImageView;
@property (weak, nonatomic) IBOutlet UIImageView* patientWeightImageView;
@property (weak, nonatomic) IBOutlet UIImageView* patientHeightImageView;
@property (weak, nonatomic) IBOutlet UIImageView* patientEmergencyContactImageView;
@property (weak, nonatomic) IBOutlet UIImageView* patientAdressImageView;

@end

@implementation PatientsAddTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCameraGestureRecognizer];
    [self setupSexGestureRecognizer];
    [self setupBloodGestureRecognizer];
    [self setupTextViewsDelegate];
    [self setupBirthDateGestureRecognizer];
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setBirthDateLabel:)
                                                 name:@"datePicked!" object:nil];
}


- (void) setBirthDateLabel:(NSNotification *)notice{
    NSDate* pickedDate = notice.object;
    
    NSDateFormatter* pickedDateFormatter = [[NSDateFormatter alloc]init];
    [pickedDateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    self.patientBirthdateTextView.text = [pickedDateFormatter stringFromDate:pickedDate];
    
}

- (void)setupBirthDateGestureRecognizer{
    NSLog(@"settingUp dateBirthDateGestureRecognizer");
    UITapGestureRecognizer* tapBirthDateTextField = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedIntoBirthDateLabel)];
    [self.patientBirthdateTextView setUserInteractionEnabled:YES];
    [self.patientBirthdateTextView addGestureRecognizer:tapBirthDateTextField];
}

- (void)setupBloodGestureRecognizer{
    UITapGestureRecognizer* tapBloodTypeTextView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedIntoBloodTypeLabel)];
    [self.patientBloodTypeTextView setUserInteractionEnabled:YES];
    [self.patientBloodTypeTextView addGestureRecognizer:tapBloodTypeTextView];
    
}


- (void)setupSexGestureRecognizer
{
    //Sex action sheet, gesture recognizer
    UITapGestureRecognizer* tapSexTextView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedIntoSexLabel)];
    [self.patientSexTextView setUserInteractionEnabled:YES];
    [self.patientSexTextView addGestureRecognizer:tapSexTextView];
}

- (void)didClickedIntoBirthDateLabel{
    
    NSLog(@"did entered in DIDCLICKEDINTOBIRTH");
    BirthDateViewController* birthDatePickerController = [[BirthDateViewController alloc]init];
    
    [self presentViewController:birthDatePickerController animated:YES completion:nil];
    
}


- (void) didClickedIntoBloodTypeLabel
{
    [self.patientBloodTypeTextView resignFirstResponder];
    [self.patientBloodTypeTextView endEditing:YES];

    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"A+",@"A-",@"B+",@"B-",@"O+",@"O-",@"AB+",@"AB-", nil];
    actionSheet.tag = 3;
    [actionSheet becomeFirstResponder];
    [actionSheet showInView:self.view];
}

- (void) didClickedIntoSexLabel
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Masculino",@"Feminino", nil];
    actionSheet.tag = 2;
    [actionSheet becomeFirstResponder];
    [actionSheet showInView:self.view];
}


//-(void) viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}

#pragma mark - UITextViewDelegate Methods
- (void) textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        switch (textView.tag) {
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
            case 4:
                if (![textView.text isEqualToString:@"Data de nascimento"]) {
                    self.patientBirthdateImageView.image = [UIImage imageNamed:@"datadenascimento-laranja"];
                }
                break;
            case 5:
                if (![textView.text isEqualToString:@"Sexo"]) {
                    self.patientSexImageView.image = [UIImage imageNamed:@"sexo-laranja"];
                }
                break;
            case 6:
                if (![textView.text isEqualToString:@"Tipo sanguíneo"]) {
                    self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                }
                break;
            case 7:
                if (![textView.text isEqualToString:@"Condições clínicas"]) {
                    self.patientClinicalConditionsImageView.image = [UIImage imageNamed:@"condicoesclinicas-laranja"];
                }
                break;
            case 8:
                if (![textView.text isEqualToString:@"Medicamentos"]) {
                    self.patientMedicationsImageView.image = [UIImage imageNamed:@"medicamentos-laranja"];
                }
                break;
            case 9:
                if (![textView.text isEqualToString:@"Alergias"]) {
                    self.patientAlergiesImageView.image = [UIImage imageNamed:@"alergias-laranja"];
                }
                break;
            case 10:
                if (![textView.text isEqualToString:@"Observações"]) {
                    self.patientObservationsImageView.image = [UIImage imageNamed:@"observacoes-laranja"];
                }
                break;
            case 11:
                if (![textView.text isEqualToString:@"Peso"]) {
                    self.patientWeightImageView.image = [UIImage imageNamed:@"peso-laranja"];
                }
                break;
            case 12:
                if (![textView.text isEqualToString:@"Altura"]) {
                    self.patientHeightImageView.image = [UIImage imageNamed:@"altura-laranja"];
                }
                break;
            case 13:
                if (![textView.text isEqualToString:@"Contato de emergência"]) {
                    self.patientEmergencyContactImageView.image = [UIImage imageNamed:@"contatodeemergencia-laranja"];
                }
                break;
            case 14:
                if (![textView.text isEqualToString:@"Endereço"]) {
                    self.patientAdressImageView.image = [UIImage imageNamed:@"endereco-laranja"];
                }
                break;
            default:
                break;
        }
    }
    else{
        switch (textView.tag) {
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
            case 4:
                self.patientBirthdateImageView.image = [UIImage imageNamed:@"datadenascimento-cinza"];
                break;
            case 5:
                self.patientSexImageView.image = [UIImage imageNamed:@"sexo-cinza"];
                break;
            case 6:
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-cinza"];
                break;
            case 7:
                self.patientClinicalConditionsImageView.image = [UIImage imageNamed:@"condicoesclinicas-cinza"];
                break;
            case 8:
                self.patientMedicationsImageView.image = [UIImage imageNamed:@"medicamentos-cinza"];
                break;
            case 9:
                self.patientAlergiesImageView.image = [UIImage imageNamed:@"alergias-cinza"];
                break;
            case 10:
                self.patientObservationsImageView.image = [UIImage imageNamed:@"observacoes-cinza"];
                break;
            case 11:
                self.patientWeightImageView.image = [UIImage imageNamed:@"peso-cinza"];
                break;
            case 12:
                self.patientHeightImageView.image = [UIImage imageNamed:@"altura-cinza"];
                break;
            case 13:
                self.patientEmergencyContactImageView.image = [UIImage imageNamed:@"contatodeemergencia-cinza"];
                break;
            case 14:
                self.patientAdressImageView.image = [UIImage imageNamed:@"endereco-cinza"];
                break;
            default:
                break;
        }
    }
}

- (void) textViewDidBeginEditing:(UITextView *)textView{
    switch (textView.tag) {
        case 1:
            if ([textView.text isEqualToString:@"Nome"]) {
                textView.text = @"";
            }
            break;
        case 2:
            if ([textView.text isEqualToString:@"Sobrenome"]) {
                textView.text = @"";
            }
            break;
        case 3:
            if ([textView.text isEqualToString:@"Telefone"]) {
                textView.text = @"";
            }
            break;
        case 4:
            if ([textView.text isEqualToString:@"Data de nascimento"]) {
                textView.text = @"";
            }
            break;
        case 5:
            if ([textView.text isEqualToString:@"Sexo"]) {
                textView.text = @"";
            }
            break;
        case 6:
            if ([textView.text isEqualToString:@"Tipo sanguíneo"]) {
                textView.text = @"";
            }
            break;
        case 7:
            if ([textView.text isEqualToString:@"Condições clínicas"]) {
                textView.text = @"";
            }
            break;
        case 8:
            if ([textView.text isEqualToString:@"Medicamentos"]) {
                textView.text = @"";
            }
            break;
        case 9:
            if ([textView.text isEqualToString:@"Alergias"]) {
                textView.text = @"";
            }
            break;
        case 10:
            if ([textView.text isEqualToString:@"Observações"]) {
                textView.text = @"";
            }
            break;
        case 11:
            if ([textView.text isEqualToString:@"Peso (kg)"]) {
                textView.text = @"";
            }
            break;
        case 12:
            if ([textView.text isEqualToString:@"Altura (cm)"]) {
                textView.text = @"";
            }
            break;
        case 13:
            if ([textView.text isEqualToString:@"Contato de emergência"]) {
                textView.text = @"";
            }
            break;
        case 14:
            if ([textView.text isEqualToString:@"Endereço"]) {
                textView.text = @"";
            }
            break;
        default:
            break;
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length > 0) {
        switch (textView.tag) {
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
            case 4:
                if (![textView.text isEqualToString:@"Data de nascimento"]) {
                    self.patientBirthdateImageView.image = [UIImage imageNamed:@"datadenascimento-laranja"];
                }
                else{
                    
                }
                break;
            case 5:
                if (![textView.text isEqualToString:@"Sexo"]) {
                    self.patientSexImageView.image = [UIImage imageNamed:@"sexo-laranja"];
                }
                break;
            case 6:
                if (![textView.text isEqualToString:@"Tipo sanguíneo"]) {
                    self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                }
                break;
            case 7:
                if (![textView.text isEqualToString:@"Condições clínicas"]) {
                    self.patientClinicalConditionsImageView.image = [UIImage imageNamed:@"condicoesclinicas-laranja"];
                }
                break;
            case 8:
                if (![textView.text isEqualToString:@"Medicamentos"]) {
                    self.patientMedicationsImageView.image = [UIImage imageNamed:@"medicamentos-laranja"];
                }
                break;
            case 9:
                if (![textView.text isEqualToString:@"Alergias"]) {
                    self.patientAlergiesImageView.image = [UIImage imageNamed:@"alergias-laranja"];
                }
                break;
            case 10:
                if (![textView.text isEqualToString:@"Observações"]) {
                    self.patientObservationsImageView.image = [UIImage imageNamed:@"observacoes-laranja"];
                }
                break;
            case 11:
                if (![textView.text isEqualToString:@"Peso"]) {
                    self.patientWeightImageView.image = [UIImage imageNamed:@"peso-laranja"];
                }
                break;
            case 12:
                if (![textView.text isEqualToString:@"Altura"]) {
                    self.patientHeightImageView.image = [UIImage imageNamed:@"altura-laranja"];
                }
                break;
            case 13:
                if (![textView.text isEqualToString:@"Contato de emergência"]) {
                    self.patientEmergencyContactImageView.image = [UIImage imageNamed:@"contatodeemergencia-laranja"];
                }
                break;
            case 14:
                if (![textView.text isEqualToString:@"Endereço"]) {
                    self.patientAdressImageView.image = [UIImage imageNamed:@"endereco-laranja"];
                }
                break;
            default:
                break;
        }
    }
    else{
        switch (textView.tag) {
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
            case 4:
                self.patientBirthdateImageView.image = [UIImage imageNamed:@"datadenascimento-cinza"];
                self.patientBirthdateTextView.text = @"Data de nascimento";
                break;
            case 5:
                self.patientSexImageView.image = [UIImage imageNamed:@"sexo-cinza"];
                self.patientSexTextView.text = @"Sexo";
                break;
            case 6:
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-cinza"];
                self.patientBloodTypeTextView.text = @"Tipo sanguíneo";
                break;
            case 7:
                self.patientClinicalConditionsImageView.image = [UIImage imageNamed:@"condicoesclinicas-cinza"];
                self.patientClinicalConditionsTextView.text = @"Condições clínicas";
                break;
            case 8:
                self.patientMedicationsImageView.image = [UIImage imageNamed:@"medicamentos-cinza"];
                self.patientMedicationsTextView.text = @"Medicamentos";
                break;
            case 9:
                self.patientAlergiesImageView.image = [UIImage imageNamed:@"alergias-cinza"];
                self.patientAlergiesTextView.text = @"Alergias";
                break;
            case 10:
                self.patientObservationsImageView.image = [UIImage imageNamed:@"observacoes-cinza"];
                self.patientObservationsTextView.text = @"Observações";
                break;
            case 11:
                self.patientWeightImageView.image = [UIImage imageNamed:@"peso-cinza"];
                self.patientWeightTextView.text = @"Peso (kg)";
                break;
            case 12:
                self.patientHeightImageView.image = [UIImage imageNamed:@"altura-cinza"];
                self.patientHeightTextView.text = @"Altura (cm)";
                break;
            case 13:
                self.patientEmergencyContactImageView.image = [UIImage imageNamed:@"contatodeemergencia-cinza"];
                self.patientEmergencyContactTextView.text = @"Contato de emergência";
                break;
            case 14:
                self.patientAdressImageView.image = [UIImage imageNamed:@"endereco-cinza"];
                self.patientAdressTextView.text = @"Endereço";
                break;
            default:
                break;
        }
    }
}

#pragma mark - Setups
- (void) setupTextViewsDelegate{
    [self.patientNameTextView setDelegate:self];
    [self.patientSurnameTextView setDelegate:self];
    [self.patientTelephoneTextView setDelegate:self];
    [self.patientBirthdateTextView setDelegate:self];
    [self.patientSexTextView setDelegate:self];
    [self.patientBloodTypeTextView setDelegate:self];
    [self.patientClinicalConditionsTextView setDelegate:self];
    [self.patientMedicationsTextView setDelegate:self];
    [self.patientAlergiesTextView setDelegate:self];
    [self.patientObservationsTextView setDelegate:self];
    [self.patientWeightTextView setDelegate:self];
    [self.patientHeightTextView setDelegate:self];
    [self.patientEmergencyContactTextView setDelegate:self];
    [self.patientAdressTextView setDelegate:self];
    
    [self.patientNameTextView setTag:1];
    [self.patientSurnameTextView setTag:2];
    [self.patientTelephoneTextView setTag:3];
    [self.patientBirthdateTextView setTag:4];
    [self.patientSexTextView setTag:5];
    [self.patientBloodTypeTextView setTag:6];
    [self.patientClinicalConditionsTextView setTag:7];
    [self.patientMedicationsTextView setTag:8];
    [self.patientAlergiesTextView setTag:9];
    [self.patientObservationsTextView setTag:10];
    [self.patientWeightTextView setTag:11];
    [self.patientHeightTextView setTag:12];
    [self.patientEmergencyContactTextView setTag:13];
    [self.patientAdressTextView setTag:14];
}

- (void) setupCameraGestureRecognizer{
    UITapGestureRecognizer* tapAreaCode = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnCameraIcon)];
    [self.cameraImageView setUserInteractionEnabled:YES];
    [self.cameraImageView addGestureRecognizer:tapAreaCode];
}

- (void) tappedOnCameraIcon{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Usar do rolo da câmera", @"Tirar uma foto", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

- (IBAction)didTappedForSaveNewPatient:(id)sender{
    Patient* patient = [[Patient alloc] init];
    patient.patientNameString =  self.patientNameTextView.text;
    patient.patientGenderString = self.patientSexTextView.text;
   // patient.patientRGString = self.patientRGTextView.text;
   // patient.patientCPFString = self.patienCPFTextView.text;
   // patient.patientAgeString = self.patientAgeTextView.text;
    UIImage* patientImage = self.cameraImageView.image;
    patient.patientPhotoData = UIImagePNGRepresentation(patientImage);
    patient.patientBirthDateString = self.patientBirthdateTextView.text;
    patient.patientAdressString = self.patientAdressTextView.text;
    patient.patientWeightString = self.patientWeightTextView.text;
    patient.patientHeightString = self.patientHeightTextView.text;
    patient.patientBloodTypeString = self.patientBloodTypeTextView.text;
    patient.patientEmergencyContactString = self.patientEmergencyContactTextView.text;
    patient.patientMedicationsString = self.patientMedicationsTextView.text;
    patient.patientObservationsString = self.patientObservationsTextView.text;
    patient.patientAlergiesString = self.patientAlergiesTextView.text;
    
    
    Envio* envio = [[Envio alloc] init];
    [envio newPatient:patient];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if(actionSheet.tag == 1) {
        switch (buttonIndex) {
            case 0:
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                tookFromCamera = false;
                [self presentModalViewController:imagePickerController animated:YES];
                break;
            case 1:
                @try{
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    tookFromCamera = true;
                    [self presentModalViewController:imagePickerController animated:YES];
                }
                @catch (NSException *exception){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sem câmera!" message:@"Algo ocorreu, e a câmera não está disponível." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                break;
            default:
                break;
        }

    } else if(actionSheet.tag == 2) {
        switch (buttonIndex) {
            case 0:
                self.patientSexTextView.text = @"Masculino";
                self.patientSexImageView.image = [UIImage imageNamed:@"sexo-laranja"];
                break;
            case 1:
                self.patientSexTextView.text = @"Feminino";
                self.patientSexImageView.image = [UIImage imageNamed:@"sexo-laranja"];
                break;
            default:
                break;
        }
    } else if(actionSheet.tag == 3){
        switch (buttonIndex) {
            case 0:
                self.patientBloodTypeTextView.text = @"A+";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 1:
                self.patientBloodTypeTextView.text = @"A-";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 2:
                self.patientBloodTypeTextView.text = @"B+";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 3:
                self.patientBloodTypeTextView.text = @"B-";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 4:
                self.patientBloodTypeTextView.text = @"O+";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 5:
                self.patientBloodTypeTextView.text = @"O-";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 6:
                self.patientBloodTypeTextView.text = @"AB+";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 7:
                self.patientBloodTypeTextView.text = @"AB-";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            default:
                break;
        }

    }
    
   }

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage* smallImage = [image scaleToSize:CGSizeMake(180,640)];
    NSData* photoData = UIImagePNGRepresentation(smallImage);
    
    self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.size.height/2;
    self.cameraImageView.layer.masksToBounds = YES;
    if (tookFromCamera) self.cameraImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    [self.cameraImageView setImage:smallImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
