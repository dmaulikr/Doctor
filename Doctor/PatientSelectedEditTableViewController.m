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
//    self.bloodTypeTextView.text = self.patient.patientBloodTypeString;
//    self.clinicalConditionsTextView.text = self.patient.patientClinicalConditionsString;
//    self.medicationsTextView.text = self.patient.patientMedicationsString;
//    self.alergiesTextView.text = self.patient.patientAlergiesString;
//    self.observationsTextView.text = self.patient.patientObservationsString;
//    self.weightTextView.text = self.patient.patientWeightString;
//    self.heightTextView.text = self.patient.patientHeightString;
//    self.emergencyContactTextView.text = self.patient.patientEmergencyContactString;
  //  self.nameLabel.text = self.patient.patientNameString;
  //  self.lastSeenLabel.text = self.patient.patientLastSeenString;
    
    
    self.addressTextView.text = self.patient.patientAdressString;

}

- (IBAction)didTappedSaveButton:(id)sender{
    [self setupLoadingAnimation];
    Patient *patient = [[Patient alloc] init];
    patient.patientBirthDateString = self.birthDateTextView.text;
  //  patient.patientNameString = self.nameLabel.text;
    patient.patientGenderString = self.sexTextView.text;
    
    Envio* envio = [[Envio alloc] init];
    
//    [envio updateThisPatient:self.patient withThis:patient withCompletion:^void(BOOL finished){
//        if (finished) {
//            [self.navigationController popViewControllerAnimated:YES];
//            [spinner stopAnimating];
//        }
//    }];

    [envio updatePatient:self.patient.patientObjectId withPatient:patient withCompletion:^void(BOOL* finished){
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
