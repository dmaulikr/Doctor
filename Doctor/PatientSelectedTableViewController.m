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
@property (weak, nonatomic) IBOutlet UILabel* patientCameSinceLabel;
@property (weak, nonatomic) IBOutlet UILabel* patientInitialsLabel;
@property (weak, nonatomic) IBOutlet UIView* patientGrayNameInitialsView;

@end

@implementation PatientSelectedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.navigationController.navigationBar.topItem.title = @"";
    [self setupDataFromPatient];
    
    self.patientGrayNameInitialsView.layer.cornerRadius = self.patientGrayNameInitialsView.frame.size.height/2;
    self.patientGrayNameInitialsView.layer.masksToBounds = YES;
    self.patientGrayNameInitialsView.layer.borderWidth = 0;
    
}

#pragma mark - Setup
- (void) setupDataFromPatient{
    self.patientSelectedNameLabel.text = self.patient.patientNameString;
    self.patientInitialsLabel.text = [self.patient.patientNameString substringToIndex:1];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 1:
            [self performSegueWithIdentifier:@"clickedInDataSegueId" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"clickedInAppointmentsSegueId" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"clickedInExamsSegueId" sender:self];
            break;
        case 4:
                [self performSegueWithIdentifier:@"clickedInTreatmentsSegueId" sender:self];
            break;
        case 5:
                [self performSegueWithIdentifier:@"clickedInEditSegueId" sender:self];
            break;
        default:
            break;
    }

}

#pragma mark - Storyboard
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"clickedInDataSegueId"]) {
        
    }
    else if ([segue.identifier isEqualToString:@"clickedInAppointmentsSegueId"]){
        
    }
    else if ([segue.identifier isEqualToString:@"clickedInExamsSegueId"]){
        
    }
    else if ([segue.identifier isEqualToString:@"clickedInTreatmentsSegueId"]){
        
    }
    else if ([segue.identifier isEqualToString:@"clickedInEditSegueId"]){
        
    }
}

@end
