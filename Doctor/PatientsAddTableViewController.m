#import "PatientsAddTableViewController.h"
#import "Patient.h"
#import "Envio.h"

@interface PatientsAddTableViewController () <UIImagePickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>{
    UIImagePickerController* imagePickerController;
    BOOL tookFromCamera;
}

@property (weak, nonatomic) IBOutlet UIImageView *cameraImageView;
@property (weak, nonatomic) IBOutlet UITextField *patientNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *patientTelephoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *patientSexLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientBloodTypeLabel;
@property (weak, nonatomic) IBOutlet UITextField *patientClinicalConditionsTextField;
@property (weak, nonatomic) IBOutlet UITextField *patientMedicationsTextField;
@property (weak, nonatomic) IBOutlet UITextField *patientAlergiesTextField;
@property (weak, nonatomic) IBOutlet UITextField *patientObservationsTextField;
@property (weak, nonatomic) IBOutlet UITextField *patientWeightTextField;
@property (weak, nonatomic) IBOutlet UITextField *patientHeightTextField;
@property (weak, nonatomic) IBOutlet UITextField *patientEmergencyContactTextField;
@property (weak, nonatomic) IBOutlet UITextField *patientAdressTextField;
@property (weak, nonatomic) IBOutlet UITextField *patientCPFTextField;
@property (weak, nonatomic) IBOutlet UIImageView *patientCPFImageView;
@property (weak, nonatomic) IBOutlet UIImageView *patientBirthdateImageView;
@property (weak, nonatomic) IBOutlet UIImageView *patientSexImageView;
@property (weak, nonatomic) IBOutlet UIImageView *patientBloodTypeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *patientClinicalConditionsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *patientMedicationsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *patientAlergiesImageView;
@property (weak, nonatomic) IBOutlet UIImageView *patientObservationsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *patientWeightImageView;
@property (weak, nonatomic) IBOutlet UIImageView *patientHeightImageView;
@property (weak, nonatomic) IBOutlet UIImageView *patientEmergencyContactImageView;
@property (weak, nonatomic) IBOutlet UIImageView *patientAdressImageView;
@property (weak, nonatomic) IBOutlet UIDatePicker *patientBirthDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *patientBirthDateLabel;

@end

@implementation PatientsAddTableViewController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.patientBirthDatePicker.hidden = YES;
    self.patientBirthDateLabel.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGestureRecognizers];
    [self.patientCPFTextField setDelegate:self];
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
}

#pragma mark - IBAction
- (IBAction)didTappedForSaveNewPatient:(id)sender{
    Patient* patient = [[Patient alloc] init];
    if (![self.patientNameTextField.text isEqualToString:@""])  patient.patientNameString =  self.patientNameTextField.text;
    if (![self.patientSexLabel.text isEqualToString:@""]) patient.patientGenderString = self.patientSexLabel.text;
    if (![self.patientCPFTextField.text isEqualToString:@""])  patient.patientCPFString = self.patientCPFTextField.text;
    if (![self.cameraImageView.image isEqual:[UIImage imageNamed:@""]]) {
        UIImage* patientImage = self.cameraImageView.image;
        patient.patientPhotoData = UIImageJPEGRepresentation(patientImage, 0.8);
    }
    if (![self.patientTelephoneTextField.text isEqualToString:@""]) patient.patientTelephoneNumber = self.patientTelephoneTextField.text;
    if (![self.patientAdressTextField.text isEqualToString:@""]) patient.patientAdressString = self.patientAdressTextField.text;
    if (![self.patientWeightTextField.text isEqualToString:@""]) patient.patientWeightString = self.patientWeightTextField.text;
    if (![self.patientHeightTextField.text isEqualToString:@""]) patient.patientHeightString = self.patientHeightTextField.text;
    if (![self.patientBloodTypeLabel.text isEqualToString:@""]) patient.patientBloodTypeString = self.patientBloodTypeLabel.text;
    if (![self.patientEmergencyContactTextField.text isEqualToString:@""]) patient.patientEmergencyContactString = self.patientEmergencyContactTextField.text;
    if (![self.patientMedicationsTextField.text isEqualToString:@""]) patient.patientMedicationsString = self.patientMedicationsTextField.text;
    if (![self.patientObservationsTextField.text isEqualToString:@""]) patient.patientObservationsString = self.patientObservationsTextField.text;
    if (![self.patientAlergiesTextField.text isEqualToString:@""]) patient.patientAlergiesString = self.patientAlergiesTextField.text;
    if (![self.patientClinicalConditionsTextField.text isEqualToString:@""]) patient.patientClinicalConditionsString = self.patientClinicalConditionsTextField.text;
    if ([self.patientBirthDatePicker date]) patient.patientBirthDate = [self.patientBirthDatePicker date];
    
    Envio* envio = [[Envio alloc] init];
    [envio newPatient:patient];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIActionSheet
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
                self.patientSexLabel.text = @"Masculino";
                self.patientSexImageView.image = [UIImage imageNamed:@"sexo-laranja"];
                break;
            case 1:
                self.patientSexLabel.text = @"Feminino";
                self.patientSexImageView.image = [UIImage imageNamed:@"sexo-laranja"];
                break;
            default:
                break;
        }
    } else if(actionSheet.tag == 3){
        switch (buttonIndex) {
            case 0:
                self.patientBloodTypeLabel.text = @"A+";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 1:
                self.patientBloodTypeLabel.text = @"A-";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 2:
                self.patientBloodTypeLabel.text = @"B+";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 3:
                self.patientBloodTypeLabel.text = @"B-";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 4:
                self.patientBloodTypeLabel.text = @"O+";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 5:
                self.patientBloodTypeLabel.text = @"O-";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 6:
                self.patientBloodTypeLabel.text = @"AB+";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            case 7:
                self.patientBloodTypeLabel.text = @"AB-";
                self.patientBloodTypeImageView.image = [UIImage imageNamed:@"tiposanguineo-laranja"];
                break;
            default:
                break;
        }
    }
}

#pragma mark - UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.size.height/2;
    self.cameraImageView.layer.masksToBounds = YES;
    [self.cameraImageView setImage:image];
    [self.cameraImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Methods
- (void) setupGestureRecognizers{
    UITapGestureRecognizer* tapBloodTypeLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedIntoBloodTypeLabel)];
    [self.patientBloodTypeLabel setUserInteractionEnabled:YES];
    [self.patientBloodTypeLabel addGestureRecognizer:tapBloodTypeLabel];
    
    UITapGestureRecognizer* tapSexLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedIntoSexLabel)];
    [self.patientSexLabel setUserInteractionEnabled:YES];
    [self.patientSexLabel addGestureRecognizer:tapSexLabel];
    
    UITapGestureRecognizer* tapCamera = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedIntoCameraIcon)];
    [self.cameraImageView setUserInteractionEnabled:YES];
    [self.cameraImageView addGestureRecognizer:tapCamera];

    UITapGestureRecognizer* tapBirthDateLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedIntoBirthLabel)];
    [self.patientBirthDateLabel setUserInteractionEnabled:YES];
    [self.patientBirthDateLabel addGestureRecognizer:tapBirthDateLabel];
}

- (void) didTappedIntoBloodTypeLabel{
    [self.patientBloodTypeLabel resignFirstResponder];
    [self.patientBloodTypeLabel endEditing:YES];
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"A+",@"A-",@"B+",@"B-",@"O+",@"O-",@"AB+",@"AB-", nil];
    actionSheet.tag = 3;
    [actionSheet becomeFirstResponder];
    [self.view endEditing:YES];
    [actionSheet showInView:self.view];
}

- (void) didTappedIntoSexLabel{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Masculino",@"Feminino", nil];
    actionSheet.tag = 2;
    [actionSheet becomeFirstResponder];
    [self.view endEditing:YES];
    [actionSheet showInView:self.view];
}

- (void) didTappedIntoCameraIcon{
    [self.view endEditing:YES];
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Usar do rolo da câmera", @"Tirar uma foto", nil];
    actionSheet.tag = 1;
    [self.view endEditing:YES];
    [actionSheet showInView:self.view];
}

- (void) didTappedIntoBirthLabel{
    [self.view endEditing:YES];
    self.patientBirthDateLabel.hidden = YES;
    self.patientBirthDatePicker.hidden = NO;
}

@end
