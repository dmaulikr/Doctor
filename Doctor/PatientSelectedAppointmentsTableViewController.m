//
//  PatientSelectedAppointmentsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedAppointmentsTableViewController.h"
#import "Envio.h"
#import "Patient.h"

@interface PatientSelectedAppointmentsTableViewController (){
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView* spinner;
}

@end

@implementation PatientSelectedAppointmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLoadingAnimation];
    [self setupAppointmentsDataSource];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"appointmentSelectedSegueId" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* AppointmentCellID = @"AppointmentsTableViewCellID";
    NSString* AppointmentAreaCellID = @"AppointmentsAreaTableViewCellID";
    NSString* HeaderCellID = @"headerCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AppointmentCellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AppointmentCellID];
    }
    cell.textLabel.text = @"teste";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Setups
- (void) setupAppointmentsDataSource {
    tableViewDataArray = [[NSMutableArray alloc] init];
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchAppointmentPassingPatient:self.patient withCompletion: ^void (NSMutableArray* appointmentArray){
        if (appointmentArray){
            tableViewDataArray = appointmentArray;
            [self.tableView reloadData];
            [spinner stopAnimating];
        }else{
            NSLog(@"Erro - setupAppointmentsDataSource block");
        }
    }];
}

- (void) setupLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

@end
