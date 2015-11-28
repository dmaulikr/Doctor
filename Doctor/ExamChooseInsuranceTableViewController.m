//
//  ExamChooseInsuranceTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/28/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "ExamChooseInsuranceTableViewController.h"

@interface ExamChooseInsuranceTableViewController (){
    NSMutableArray* insuranceArray;
}

@end

@implementation ExamChooseInsuranceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    insuranceArray = [[NSMutableArray alloc] initWithObjects:
                       @"All Saúde",
                       @"Amil Saúde",
                       @"Assim Saúde",
                       @"Bradesco Saúde",
                       @"Cassi",
                       @"Camed",
                       @"FACHESF",
                       @"Fisco Saúde",
                       @"Geap Saúde",
                       @"Golden Cross",
                       @"Hapvida",
                       @"Intermédica Saúde",
                       @"Itálica Saúde",
                       @"Marítima Saúde",
                       @"Memorial",
                       @"NotreDame",
                       @"Plena Saúde",
                       @"Porto Seguro",
                       @"Real",
                       @"Santa Amália",
                       @"Santa Casa",
                       @"Santa Helena",
                       @"Saúde Medicol",
                       @"Só Saúde",
                       @"Seisa",
                       @"Unimed",
                       @"Universal",
                       @"Viva", nil];
    
    self.tableView.tableFooterView = [UIView new];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return insuranceArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didMakeSelection:)]) {
        [self.delegate didMakeSelection:insuranceArray[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *insuranceCellID = @"insuranceCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:insuranceCellID];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:insuranceCellID];
    }
    cell.textLabel.text = insuranceArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
