#import "PatientsAddTableViewController.h"
#import "Patient.h"
#import "Envio.h"
#import "UIImageResizing.h"
#import <SSFlatDatePicker/SSFlatDatePicker.h>
#import "HSDatePickerViewController.h"

@interface PatientsAddTableViewController () <UITextViewDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate, HSDatePickerViewControllerDelegate>{
    UIImagePickerController* imagePickerController;
    BOOL tookFromCamera;
}

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
@property (weak, nonatomic) IBOutlet UITextView* patientCPFTextView;

@property (weak, nonatomic) IBOutlet UIImageView* patientCPFImageView;
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

- (void) viewWillAppear:(BOOL)animated{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCameraGestureRecognizer];
    [self setupSexGestureRecognizer];
    [self setupBloodGestureRecognizer];
    [self setupTextViewsDelegate];
    [self setupBirthDateGestureRecognizer];
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
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

- (void)setupSexGestureRecognizer{
    //Sex action sheet, gesture recognizer
    UITapGestureRecognizer* tapSexTextView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedIntoSexLabel)];
    [self.patientSexTextView setUserInteractionEnabled:YES];
    [self.patientSexTextView addGestureRecognizer:tapSexTextView];
}

- (void)didClickedIntoBirthDateLabel{
   // HSDatePickerViewController* hs = [HSDatePickerViewController new];
   // hs.delegate = self;
  //  [self presentViewController:hs animated:YES completion:nil];
    SSFlatDatePicker *datePicker = [[SSFlatDatePicker alloc] initWithFrame:CGRectMake(10, 10, 400, 120)];
    [self.view addSubview:datePicker];
}

- (void) didClickedIntoBloodTypeLabel{
    [self.patientBloodTypeTextView resignFirstResponder];
    [self.patientBloodTypeTextView endEditing:YES];

    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"A+",@"A-",@"B+",@"B-",@"O+",@"O-",@"AB+",@"AB-", nil];
    actionSheet.tag = 3;
    [actionSheet becomeFirstResponder];
    [self.view endEditing:YES];
    [actionSheet showInView:self.view];
}

- (void) didClickedIntoSexLabel{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Masculino",@"Feminino", nil];
    actionSheet.tag = 2;
    [actionSheet becomeFirstResponder];
    [self.view endEditing:YES];
    [actionSheet showInView:self.view];
}

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
            case 15:
                if (![textView.text isEqualToString:@"CPF"]) {
                    self.patientCPFImageView.image = [UIImage imageNamed:@"CPF-laranja"];
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
            case 15:
                self.patientCPFImageView.image = [UIImage imageNamed:@"CPF-cinza"];
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
            case 15:
            if ([textView.text isEqualToString:@"CPF"]) {
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
                case 15:
                if (![textView.text isEqualToString:@"CPF"]) {
                    self.patientCPFImageView.image = [UIImage imageNamed:@"CPF-laranja"];
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
                case 15:
                self.patientCPFImageView.image = [UIImage imageNamed:@"CPF-cinza"];
                self.patientCPFTextView.text = @"CPF";
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
    [self.patientCPFTextView setDelegate:self];
    
    
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
    [self.patientCPFTextView setTag:15];
}

- (void) setupCameraGestureRecognizer{
    UITapGestureRecognizer* tapCamera = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnCameraIcon)];
    [self.cameraImageView setUserInteractionEnabled:YES];
    [self.cameraImageView addGestureRecognizer:tapCamera];
}

- (void) tappedOnCameraIcon{
    [self.view endEditing:YES];
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Usar do rolo da câmera", @"Tirar uma foto", nil];
    actionSheet.tag = 1;
    [self.view endEditing:YES];
    [actionSheet showInView:self.view];
}

- (IBAction)didTappedForSaveNewPatient:(id)sender{
    Patient* patient = [[Patient alloc] init];
    if (![self.patientNameTextView.text isEqualToString:@"Nome"])  patient.patientNameString =  self.patientNameTextView.text;
    if (![self.patientSexTextView.text isEqualToString:@"Sexo"]) patient.patientGenderString = self.patientSexTextView.text;
   // patient.patientRGString = self.patientRGTextView.text;
   if (![self.patientCPFTextView.text isEqualToString:@"CPF"])  patient.patientCPFString = self.patientCPFTextView.text;
   // patient.patientAgeString = self.patientAgeTextView.text;
    if (![self.cameraImageView.image isEqual:[UIImage imageNamed:@"icone-foto"]]) {
        UIImage* patientImage = self.cameraImageView.image;
        patient.patientPhotoData = UIImageJPEGRepresentation(patientImage, 0.8);
    }
    if (![self.patientBirthdateTextView.text isEqualToString:@"Nome"]) patient.patientBirthDateString = self.patientBirthdateTextView.text;
    if (![self.patientAdressTextView.text isEqualToString:@"Endereço"]) patient.patientAdressString = self.patientAdressTextView.text;
    if (![self.patientWeightTextView.text isEqualToString:@"Peso (kg)"]) patient.patientWeightString = self.patientWeightTextView.text;
    if (![self.patientHeightTextView.text isEqualToString:@"Altura (cm)"]) patient.patientHeightString = self.patientHeightTextView.text;
    if (![self.patientBloodTypeTextView.text isEqualToString:@"Tipo sanguíneo"]) patient.patientBloodTypeString = self.patientBloodTypeTextView.text;
    if (![self.patientEmergencyContactTextView.text isEqualToString:@"Contato de emergência"]) patient.patientEmergencyContactString = self.patientEmergencyContactTextView.text;
    if (![self.patientMedicationsTextView.text isEqualToString:@"Medicamentos"]) patient.patientMedicationsString = self.patientMedicationsTextView.text;
    if (![self.patientObservationsTextView.text isEqualToString:@"Observações"]) patient.patientObservationsString = self.patientObservationsTextView.text;
    if (![self.patientAlergiesTextView.text isEqualToString:@"Alergias"]) patient.patientAlergiesString = self.patientAlergiesTextView.text;
    if (![self.patientClinicalConditionsTextView.text isEqualToString:@"Condições clínicas"]) patient.patientClinicalConditionsString = self.patientClinicalConditionsTextView.text;
    
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
   // UIImage* smallImage = [image scaleToSize:CGSizeMake(180,640)];
   // NSData* photoData = UIImagePNGRepresentation(smallImage);
    
    self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.size.height/2;
    self.cameraImageView.layer.masksToBounds = YES;
   
    //  if (tookFromCamera) self.cameraImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
  //  [self.cameraImageView setImage:smallImage];
    [self.cameraImageView setImage:image];
    [self.cameraImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    BOOL aproval = false;
    switch (textView.tag) {
        case 15:
            if(range.length + range.location > textView.text.length)
            {
                return NO;
            }
            aproval = newLength <= 11;
            break;
        //Peso
        case 11:
            if(range.length + range.location > textView.text.length)
            {
                return NO;
            }
            aproval = newLength <=3;
            
            break;
        //Altura
        case 12:
            if(range.length + range.location > textView.text.length)
            {
                return NO;
            }
            aproval = newLength <= 3;
            
            break;
        default:
            return YES;
            break;
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return aproval;
}


#pragma mark - HSDatePickerViewControllerDelegate
- (void)hsDatePickerPickedDate:(NSDate *)date {
    NSLog(@"Date picked %@", date);
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    dateFormater.dateFormat = @"dd.MM.yyyy";
//    self.dateLabel.text = [dateFormater stringFromDate:date];
//    self.selectedDate = date;
}

@end
