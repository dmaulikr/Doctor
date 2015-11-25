//
//  PatientSelectedExamSelectedTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedExamSelectedTableViewController.h"

@interface PatientSelectedExamSelectedTableViewController ()

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;
@property (nonatomic, weak) IBOutlet UIImageView* patientImageView;

@end

@implementation PatientSelectedExamSelectedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPatientHeaderData];
    self.tableView.tableFooterView = [UIView new];
}

- (void) loadPatientHeaderData{
    self.patientNameLabel.text = self.patient.patientNameString;
    self.patientCameSinceLabel.text = self.patient.patientCameSinceString;
}

@end