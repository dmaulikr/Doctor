#import "SettingsSAAPTableViewController.h"
#import "AppDelegate.h"

@interface SettingsSAAPTableViewController ()

@property (nonatomic, weak) IBOutlet UILabel* settingsNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsSurnameLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsCRMLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsContactLabel;

@end

@implementation SettingsSAAPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDoctorData];
    self.tableView.tableFooterView = [UIView new];
}

- (void) setupDoctorData{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.settingsNameLabel.text = appDelegate.doctor.doctorNameString;
    self.settingsSurnameLabel.text = appDelegate.doctor.doctorNameString;
    self.settingsCRMLabel.text = appDelegate.doctor.doctorCRMString;
    self.settingsContactLabel.text = appDelegate.doctor.doctorContactString;
}

@end
