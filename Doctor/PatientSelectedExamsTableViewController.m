//
//  PatientSelectedExamsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedExamsTableViewController.h"
#import "Envio.h"
#import "PatientSelectedHeaderTableViewCell.h"

@interface PatientSelectedExamsTableViewController (){
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView* spinner;
}

@end

@implementation PatientSelectedExamsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLoadingAnimation];
    [self setupExamsDataSource];
    self.tableView.tableFooterView = [UIView new];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"examSelectedSegueId" sender:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        NSString* cellIdentifier = @"headerCellID";
        
        PatientSelectedHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell = [[PatientSelectedHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        Exam* exam = [[Exam alloc] init];
        exam = tableViewDataArray[indexPath.row];
        //cell.textLabel.text = exam.examDescription;
        cell.patientNameLabel.text = @"testeaaaa";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        NSString* cellIdentifier = @"ExamsCellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        Exam* exam = [[Exam alloc] init];
        exam = tableViewDataArray[indexPath.row];
        cell.textLabel.text = exam.examDescription;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 140;
    }
    else{
        return 30;
    }
}

#pragma mark - Setups
- (void) setupExamsDataSource {
    tableViewDataArray = [[NSMutableArray alloc] init];
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchExamsPassingPatient:self.patient withCompletion: ^void (NSMutableArray* examsArray){
        if (examsArray){
            tableViewDataArray = examsArray;
            [self.tableView reloadData];
            [spinner stopAnimating];
        }else{
            NSLog(@"Erro - setupExamsDataSource block");
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