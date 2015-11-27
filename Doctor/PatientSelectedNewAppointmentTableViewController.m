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

@interface PatientSelectedNewAppointmentTableViewController () <UIActionSheetDelegate> {
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
    [self createTapRecognizers];
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

- (void) createTapRecognizers{
    UITapGestureRecognizer* tapSpecialty = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedSpecialtiesLabel)];
    self.appointmentDoctorSpecialty.userInteractionEnabled = YES;
    [self.appointmentDoctorSpecialty addGestureRecognizer:tapSpecialty];
    
    UITapGestureRecognizer* tapHealthCare = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedHealthCareLabel)];
    self.appointmentHealthCare.userInteractionEnabled = YES;
    [self.appointmentHealthCare addGestureRecognizer:tapHealthCare];
}

- (void) didTappedSpecialtiesLabel{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    for (NSInteger i = doctor.doctorSpecialtiesArray.count; i > 0; i--) {
        [actionSheet addButtonWithTitle:doctor.doctorSpecialtiesArray[i-1]];
    }
    actionSheet.tag = 1;
    [self.view endEditing:YES];
    [actionSheet showInView:self.view];
}

- (void) didTappedHealthCareLabel{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:nil,  nil];
    for (NSInteger i = doctor.doctorHealthCareArray.count; i > 0; i--) {
        [actionSheet addButtonWithTitle:doctor.doctorHealthCareArray[i-1]];
    }
    actionSheet.tag = 2;
    [self.view endEditing:YES];
    [actionSheet showInView:self.view];
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

@end
