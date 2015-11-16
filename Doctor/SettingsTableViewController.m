//
//  SettingsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "MFSideMenu.h"
#import "AppDelegate.h"

@interface SettingsTableViewController ()

@property (nonatomic, strong) Doctor* doctor;
@property (nonatomic, weak) IBOutlet UILabel* settingsNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsSurnameLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsCellphoneLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsCRMLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsEmailLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsUserLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsPasswordLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsSpecialtiesLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsHealthCareLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsAddressLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsContactLabel;

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDoctor];
    self.tableView.tableFooterView = [UIView new];
}

-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void) setupDoctor{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.doctor = appDelegate.doctor;
    self.settingsAddressLabel.text = self.doctor.doctorAddressString;
    self.settingsContactLabel.text = @"Contato";
    self.settingsCRMLabel.text = self.doctor.doctorCRMString;
    self.settingsEmailLabel.text = self.doctor.doctorEmailString;
    self.settingsHealthCareLabel.text = @"Plano de saúde";
    self.settingsPasswordLabel.text = @"*********";
    self.settingsSpecialtiesLabel.text = @"Especialidades";
    self.settingsUserLabel.text = self.doctor.doctorUsernameString;
    self.settingsNameLabel.text = self.doctor.doctorNameString;
    self.settingsSurnameLabel.text = self.doctor.doctorNameString;
    self.settingsCellphoneLabel.text = self.doctor.doctorContactString;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 4:
            [self performSegueWithIdentifier:@"settingsChangePasswordSegue" sender:self];
            break;
        case 5:
            [self performSegueWithIdentifier:@"settingsSpecialtiesSegue" sender:self];
            break;
        case 6:
            [self performSegueWithIdentifier:@"settingsHealthCareSegue" sender:self];
            break;
        default:
            break;
    }
}


@end
