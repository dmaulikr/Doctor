//
//  PatientSelectedEditTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedEditTableViewController.h"
#import "Envio.h"

@interface PatientSelectedEditTableViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate> {
    UIImagePickerController* imagePickerController;
    UIActivityIndicatorView* spinner;
}

@property (nonatomic, weak) IBOutlet UITextView* birthDateTextView;
@property (nonatomic, weak) IBOutlet UITextView* sexTextView;
@property (nonatomic, weak) IBOutlet UITextView* bloodTypeTextView;
@property (nonatomic, weak) IBOutlet UITextView* clinicalConditionsTextView;
@property (nonatomic, weak) IBOutlet UITextView* medicationsTextView;
@property (nonatomic, weak) IBOutlet UITextView* alergiesTextView;
@property (nonatomic, weak) IBOutlet UITextView* observationsTextView;
@property (nonatomic, weak) IBOutlet UITextView* weightTextView;
@property (nonatomic, weak) IBOutlet UITextView* heightTextView;
@property (nonatomic, weak) IBOutlet UITextView* emergencyContactTextView;
@property (nonatomic, weak) IBOutlet UITextView* addressTextView;
@property (nonatomic, weak) IBOutlet UITextView* cpfTextView;

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;
@property (nonatomic, weak) IBOutlet UIImageView* patientImageView;

@end

@implementation PatientSelectedEditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPatientData];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedPatientImage)];
    [self.patientImageView setUserInteractionEnabled:YES];
    [self.patientImageView addGestureRecognizer:tap];
    self.patientCameSinceLabel.numberOfLines = 0;
    self.tableView.tableFooterView = [UIView new];
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
}

- (void) loadPatientData{
    
    self.patientNameLabel.text = self.patient.patientNameString;
    self.patientCameSinceLabel.text = self.patient.patientCameSinceString;
    //self.patientImageView.image = self.patient.patientImage;
    
    self.birthDateTextView.text = self.patient.patientBirthDateString;
    self.sexTextView.text = self.patient.patientGenderString;
    self.bloodTypeTextView.text = self.patient.patientBloodTypeString;
    self.clinicalConditionsTextView.text = self.patient.patientClinicalConditionsString;
    self.medicationsTextView.text = self.patient.patientMedicationsString;
    self.alergiesTextView.text = self.patient.patientAlergiesString;
    self.observationsTextView.text = self.patient.patientObservationsString;
    self.weightTextView.text = self.patient.patientWeightString;
    self.heightTextView.text = self.patient.patientHeightString;
    self.emergencyContactTextView.text = self.patient.patientEmergencyContactString;
    self.addressTextView.text = self.patient.patientAdressString;
    self.cpfTextView.text = self.patient.patientCPFString;
}

- (IBAction)didTappedSaveButton:(id)sender{
    [self setupLoadingAnimation];
    Patient *patient = [[Patient alloc] init];
    patient.patientBirthDateString = self.birthDateTextView.text;
    patient.patientBloodTypeString = self.bloodTypeTextView.text;
    patient.patientGenderString = self.sexTextView.text;
    patient.patientClinicalConditionsString = self.clinicalConditionsTextView.text;
    patient.patientMedicationsString = self.medicationsTextView.text;
    patient.patientAlergiesString = self.alergiesTextView.text;
    patient.patientObservationsString = self.observationsTextView.text;
    patient.patientWeightString = self.weightTextView.text;
    patient.patientHeightString = self.heightTextView.text;
    patient.patientEmergencyContactString = self.emergencyContactTextView.text;
    patient.patientAdressString = self.addressTextView.text;
    patient.patientCPFString = self.cpfTextView.text;
    
    Envio* envio = [[Envio alloc] init];
    [envio updatePatient:self.patient.patientObjectId withPatient:patient withCompletion:^void(BOOL finished){
        if (finished) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void) didTappedPatientImage{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Usar do rolo da câmera", @"Tirar uma foto", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1) {
        switch (buttonIndex) {
            case 0:
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentModalViewController:imagePickerController animated:YES];
                break;
            case 1:
                @try{
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
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
    }
}

- (void) setupLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // UIImage* smallImage = [image scaleToSize:CGSizeMake(180,640)];
    // NSData* photoData = UIImagePNGRepresentation(smallImage);
    
    self.patientImageView.layer.cornerRadius = self.patientImageView.frame.size.height/2;
    self.patientImageView.layer.masksToBounds = YES;
    
    //  if (tookFromCamera) self.cameraImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    //  [self.cameraImageView setImage:smallImage];
    [self.patientImageView setImage:image];
    [self.patientImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
