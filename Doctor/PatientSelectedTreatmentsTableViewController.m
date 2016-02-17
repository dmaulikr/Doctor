#import "PatientSelectedTreatmentsTableViewController.h"
#import "PatientSelectedTreatmentSelectedTableViewController.h"
#import "Envio.h"
#import "PatientSelectedTreatmentTableViewCell.h"
#import "SVProgressHUD.h"

@interface PatientSelectedTreatmentsTableViewController (){
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView* spinner;
}

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;
@property (nonatomic, weak) IBOutlet UIImageView* patientImageView;

@end

@implementation PatientSelectedTreatmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLoadingAnimation];
    self.patientCameSinceLabel.numberOfLines = 0;
    [self setupTreatmentsDataSource];
    self.tableView.tableFooterView = [UIView new];
    
    if (self.patient.patientPhotoData) {
        self.patientImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.patientImageView.layer.cornerRadius = self.patientImageView.frame.size.height/2;
        self.patientImageView.layer.masksToBounds = YES;
        self.patientImageView.image = [UIImage imageWithData:self.patient.patientPhotoData];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"treatmentSelectedSegueId" sender:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* TreatmentAreaCellID = @"TreatmentsAreaCellID";
    NSString* TreatmentCellID = @"TreatmentsCellID";
    
    NSString* cellIdentifier = indexPath.row %2 == 0 ? TreatmentAreaCellID : TreatmentCellID;
    
    PatientSelectedTreatmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[PatientSelectedTreatmentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Setups
- (void) setupTreatmentsDataSource {
    self.patientNameLabel.text = self.patient.patientNameString;
    self.patientCameSinceLabel.text = self.patient.patientCameSinceString;
    //self.patientImageView.image = self.patient.patientImage;
    
    tableViewDataArray = [[NSMutableArray alloc] init];
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchTreatmentPassingPatient:self.patient withCompletion: ^void (NSMutableArray* treatmentArray){
        if (treatmentArray){
            tableViewDataArray = treatmentArray;
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            NSLog(@"Erro - setupTreatmentsDataSource block");
        }
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row %2 == 0 ? 50 : 64;
}

- (void) setupLoadingAnimation{
//    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    spinner.center = self.view.center;
//    spinner.tag = 12;
//    [self.view addSubview:spinner];
//    [spinner startAnimating];
   [SVProgressHUD show];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"treatmentSelectedSegueId"]) {
        PatientSelectedTreatmentSelectedTableViewController* vc = segue.destinationViewController;
        [vc setPatient:self.patient];
    }
}


@end