//
//  PatientSelectedNewAppointmentTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/26/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedNewAppointmentTableViewController.h"
#import "Envio.h"
#import "Doctor.h"
#import "AppDelegate.h"
#import "ExamChooseInsuranceTableViewController.h"
#import "ExamChooseSpecialtyTableViewController.h"

@interface PatientSelectedNewAppointmentTableViewController () <UIActionSheetDelegate, ExamChooseInsuranceTableViewControllerDelegate, ExamChooseSpecialtyTableViewControllerDelegate> {
    Doctor* doctor;
}

@property (nonatomic, weak) IBOutlet UILabel* appointmentData;
@property (nonatomic, weak) IBOutlet UILabel* appointmentProtocol;
@property (nonatomic, weak) IBOutlet UILabel* appointmentDoctor;
@property (nonatomic, weak) IBOutlet UILabel* appointmentDoctorSpecialty;
@property (nonatomic, weak) IBOutlet UILabel* appointmentHealthCare;
@property (nonatomic, weak) IBOutlet UITextView* appointmentDiagnosis;
@property (nonatomic, weak) IBOutlet UITextView* appointmentMedications;

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;

@end

@implementation PatientSelectedNewAppointmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    doctor = appDelegate.doctor;
    self.patientNameLabel.text = self.patient.patientNameString;
    self.patientCameSinceLabel.text = self.patient.patientCameSinceString;
    [self displayStaticInfo];
}

- (IBAction)didTappedToSaveNewAppointment:(id)sender{
    Envio* envio = [[Envio alloc] init];
    Appointment* newAppointment = [[Appointment alloc] init];
    newAppointment.appointmentDoctor = doctor;
    newAppointment.appointmentPatient = self.patient;
    newAppointment.appointmentProtocol = self.appointmentProtocol.text;
    newAppointment.appointmentDate = [self getCurrentTimeAndDate];
    newAppointment.appointmentDiagnosis = self.appointmentDiagnosis.text;
    newAppointment.appointmentTreatment = self.appointmentMedications.text;
    newAppointment.appointmentArea = self.appointmentDoctorSpecialty.text;
    newAppointment.appointmentInsurance = self.appointmentHealthCare.text;
    [envio newAppointment:newAppointment withCompletion:^void(BOOL* finished){
        if (finished) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void) displayStaticInfo{
    self.appointmentData.text = [self getCurrentTimeAndDate];
    self.appointmentProtocol.text = @"000000000000";
    self.appointmentDoctor.text = doctor.doctorNameString;
}

- (NSString *) getCurrentTimeAndDate{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (popup.tag) {
        case 1:
            if (![[popup buttonTitleAtIndex:buttonIndex] isEqualToString:@"Cancelar"]) {
                self.appointmentDoctorSpecialty.text = [popup buttonTitleAtIndex:buttonIndex];
            }
            break;
        case 2:
            if (![[popup buttonTitleAtIndex:buttonIndex] isEqualToString:@"Cancelar"]) {
                self.appointmentHealthCare.text = [popup buttonTitleAtIndex:buttonIndex];
            }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 4:
            [self performSegueWithIdentifier:@"appointmentSpecialtySegueId" sender:self];
            break;
        case 5:
            [self performSegueWithIdentifier:@"appointmentInsuranceSegueId" sender:self];
            break;
        default:
            break;
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"appointmentSpecialtySegueId"]) {
        ExamChooseSpecialtyTableViewController* specialtyVc = [[ExamChooseSpecialtyTableViewController alloc] init];
        specialtyVc = segue.destinationViewController;
        specialtyVc.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"appointmentInsuranceSegueId"]){
        ExamChooseInsuranceTableViewController* insuranceVc = [[ExamChooseInsuranceTableViewController alloc] init];
        insuranceVc = segue.destinationViewController;
        insuranceVc.delegate = self;
    }
}

-(void) didMakeSelection:(NSString *)insuranceSelected{
    self.appointmentHealthCare.text = insuranceSelected;
}

- (void) didMakeSelectionSpecialty:(NSString *)specialtySelected{
    self.appointmentDoctorSpecialty.text = specialtySelected;
}

@end
