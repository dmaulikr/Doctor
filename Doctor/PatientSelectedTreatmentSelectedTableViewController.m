#import "PatientSelectedTreatmentSelectedTableViewController.h"

@interface PatientSelectedTreatmentSelectedTableViewController ()

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;
@property (nonatomic, weak) IBOutlet UIImageView* patientImageView;

@end

@implementation PatientSelectedTreatmentSelectedTableViewController

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