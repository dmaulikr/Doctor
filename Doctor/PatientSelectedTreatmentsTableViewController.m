//
//  PatientSelectedTreatmentsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedTreatmentsTableViewController.h"

@interface PatientSelectedTreatmentsTableViewController ()

@end

@implementation PatientSelectedTreatmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"treatmentSelectedSegueId" sender:self];
}
@end
