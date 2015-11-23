//
//  PatientSelectedTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/20/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedTableViewController.h"
#import "Patient.h"
#import "PatientSelectedAppointmentsTableViewController.h"
#import "PatientSelectedExamsTableViewController.h"
#import "PatientSelectedEditTableViewController.h"
#import "PatientSelectedDataTableViewController.h"
#import "PatientSelectedTreatmentsTableViewController.h"
#import "Doctor.h"
#import "Envio.h"
#import "AppDelegate.h"

@interface PatientSelectedTableViewController ()

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;
@property (nonatomic, weak) IBOutlet UIImageView* patientImageView;

@end

@implementation PatientSelectedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.patientCameSinceLabel.numberOfLines = 0;
    
    if (self.patient.patientPhotoData) {
        self.patientImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.patientImageView.layer.cornerRadius = self.patientImageView.frame.size.height/2;
        self.patientImageView.layer.masksToBounds = YES;
        self.patientImageView.image = [UIImage imageWithData:self.patient.patientPhotoData];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.topItem.title = @"Detalhes";
    [self setupDataFromPatient];
}

#pragma mark - Setup
- (void) setupDataFromPatient{
    self.patientNameLabel.text = self.patient.patientNameString;

    Doctor* doctor = [[Doctor alloc] init];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    doctor = appDelegate.doctor;
    Envio* envio = [[Envio alloc] init];
    
    [envio fetchLastSeen:doctor :self.patient :^void (NSString * lastSeen){
        if (lastSeen != nil) {
            NSString* finalString = [[NSString alloc] initWithFormat:@"Atendido pela última vez em %@", lastSeen];
            self.patientCameSinceLabel.text = finalString;
            self.patientCameSinceLabel.numberOfLines = 0;
            self.patient.patientCameSinceString = finalString;
        }
        else{
            self.patient.patientCameSinceString = @"Nunca antes atendido por você.";
        }
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"clickedInDataSegueId" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"clickedInAppointmentsSegueId" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"clickedInExamsSegueId" sender:self];
            break;
        case 3:
                [self performSegueWithIdentifier:@"clickedInTreatmentsSegueId" sender:self];
            break;
        case 4:
                [self performSegueWithIdentifier:@"clickedInEditSegueId" sender:self];
            break;
        default:
            break;
    }
}

#pragma mark - Storyboard
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"clickedInDataSegueId"]) {
        PatientSelectedDataTableViewController *data = segue.destinationViewController;
        data.patient = self.patient;
    }
    else if ([segue.identifier isEqualToString:@"clickedInAppointmentsSegueId"]){
        PatientSelectedAppointmentsTableViewController *appointments = segue.destinationViewController;
        appointments.patient = self.patient;
    }
    else if ([segue.identifier isEqualToString:@"clickedInExamsSegueId"]){
        PatientSelectedExamsTableViewController* exams = segue.destinationViewController;
        exams.patient = self.patient;
    }
    else if ([segue.identifier isEqualToString:@"clickedInTreatmentsSegueId"]){
        PatientSelectedTreatmentsTableViewController* treatments = segue.destinationViewController;
        treatments.patient = self.patient;
    }
    else if ([segue.identifier isEqualToString:@"clickedInEditSegueId"]){
        PatientSelectedEditTableViewController* edit = segue.destinationViewController;
        edit.patient = self.patient;
    }
}

@end
