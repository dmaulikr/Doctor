//
//  PatientSelectedTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/20/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedTableViewController.h"
#import "Patient.h"

@interface PatientSelectedTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel* patientSelectedNameLabel;
@property (weak, nonatomic) IBOutlet UILabel* patientSelectedAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel* patientSelectedGenderLabel;
@property (weak, nonatomic) IBOutlet UILabel* patientSelectedAddressLabel;

@end

@implementation PatientSelectedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.navigationController.navigationBar.topItem.title = @"";
    
    self.patientSelectedNameLabel.text = self.patient.patientNameString;
    self.patientSelectedAgeLabel.text = self.patient.patientAgeString;
    self.patientSelectedGenderLabel.text = self.patient.patientGenderString;
    self.patientSelectedAddressLabel.text = self.patient.patientAdressString;
}

@end
