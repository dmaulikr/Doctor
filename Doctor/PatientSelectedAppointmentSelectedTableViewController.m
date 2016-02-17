#import "PatientSelectedAppointmentSelectedTableViewController.h"

@interface PatientSelectedAppointmentSelectedTableViewController ()

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;
@property (nonatomic, weak) IBOutlet UIImageView* patientImageView;

@property (nonatomic, weak) IBOutlet UILabel* appointmentSpecialtyLabel;
@property (nonatomic, weak) IBOutlet UILabel* appointmentInsuranceLabel;
@property (nonatomic, weak) IBOutlet UITextView* appointmentDiagnosisTextView;
@property (nonatomic, weak) IBOutlet UITextView* appointmentTreatmentTextView;

@end

@implementation PatientSelectedAppointmentSelectedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.tableView.tableFooterView = [UIView new];
}

- (void) loadData{
    self.patientNameLabel.text = self.patient.patientNameString;
    self.patientCameSinceLabel.text = self.patient.patientCameSinceString;
    self.appointmentSpecialtyLabel.text = self.appointment.appointmentArea;
    self.appointmentInsuranceLabel.text = self.appointment.appointmentInsurance;
    self.appointmentDiagnosisTextView.text = self.appointment.appointmentDiagnosis;
    self.appointmentTreatmentTextView.text = self.appointment.appointmentTreatment;
}

@end