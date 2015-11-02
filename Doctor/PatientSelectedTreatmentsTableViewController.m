//
//  PatientSelectedTreatmentsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedTreatmentsTableViewController.h"
#import "Envio.h"

@interface PatientSelectedTreatmentsTableViewController (){
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView* spinner;
}

@end

@implementation PatientSelectedTreatmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLoadingAnimation];
    [self setupTreatmentsDataSource];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"treatmentSelectedSegueId" sender:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* TreatmentCellID = @"TreatmentsCellID";
    NSString* HeaderCellID = @"headerCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TreatmentCellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TreatmentCellID];
    }
    cell.textLabel.text = @"teste";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Setups
- (void) setupTreatmentsDataSource {
    tableViewDataArray = [[NSMutableArray alloc] init];
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchTreatmentPassingPatient:self.patient withCompletion: ^void (NSMutableArray* treatmentArray){
        if (treatmentArray){
            tableViewDataArray = treatmentArray;
            [self.tableView reloadData];
            [spinner stopAnimating];
        }else{
            NSLog(@"Erro - setupTreatmentsDataSource block");
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