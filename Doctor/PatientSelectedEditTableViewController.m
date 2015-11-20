//
//  PatientSelectedEditTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedEditTableViewController.h"
#import "Envio.h"

@interface PatientSelectedEditTableViewController (){
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
    self.patientCameSinceLabel.numberOfLines = 0;
    self.tableView.tableFooterView = [UIView new];
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

- (void) setupLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}
@end
