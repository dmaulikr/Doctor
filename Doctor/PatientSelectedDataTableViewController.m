//
//  PatientSelectedDataTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedDataTableViewController.h"

@interface PatientSelectedDataTableViewController ()
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

@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UILabel* lastSeenLabel;

@end

@implementation PatientSelectedDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPatientData];
    self.tableView.tableFooterView = [UIView new];
}

- (void) loadPatientData{
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
    self.nameLabel.text = self.patient.patientNameString;
    //  self.lastSeenLabel.text = self.patient.patientLastSeenString;
    
    
    self.addressTextView.text = self.patient.patientAdressString;
    
}
@end