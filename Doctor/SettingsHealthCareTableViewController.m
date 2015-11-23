//
//  SettingsHealthCareTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/16/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "SettingsHealthCareTableViewController.h"
#import "SettingsHealthCareTableViewCell.h"

@interface SettingsHealthCareTableViewController (){
    NSMutableArray* healthCareArray;
    NSMutableArray* alreadyHealthCareArray;
}

@end

@implementation SettingsHealthCareTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    healthCareArray = [[NSMutableArray alloc] initWithObjects:
                        @"All Saúde",
                        @"Amil Saúde",
                        @"Assim Saúde",
                        @"Bradesco Saúde",
                        @"Geap Saúde",
                        @"Golden Cross",
                        @"Camed",
                        @"Hapvida",
                        @"Intermédica Saúde",
                        @"Itálica Saúde",
                        @"Marítima Saúde",
                        @"Memorial",
                        @"NotreDame",
                        @"Cassi",
                        @"Plena Saúde",
                        @"Saúde Medicol",
                        @"Só Saúde",
                        @"Unimed",
                        @"Viva",
                        @"FACHESF",
                        @"Fisco Saúde",
                        @"Universal",
                        @"Real",
                        @"Porto Seguro",
                        @"Santa Amália",
                        @"Santa Casa",
                        @"Santa Helena",
                        @"Seisa", nil];
    alreadyHealthCareArray = [[NSMutableArray alloc] init];
    self.tableView.tableFooterView = [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([alreadyHealthCareArray containsObject:healthCareArray[indexPath.row]]) {
        [alreadyHealthCareArray removeObject:healthCareArray[indexPath.row]];
    }
    else{
        [alreadyHealthCareArray addObject:healthCareArray[indexPath.row]];
    }
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return 53; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return healthCareArray.count; }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *healthCareCellID = @"healthCareCellID";
    
    SettingsHealthCareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:healthCareCellID];
    
    if (cell == nil){
        cell = [[SettingsHealthCareTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:healthCareCellID];
    }
    cell.healthCareLabel.text = healthCareArray[indexPath.row];
    
    if ([alreadyHealthCareArray containsObject:cell.healthCareLabel.text]) {
        cell.radioButtonImageView.image = [UIImage imageNamed:@"check-ok"];
    }
    return cell;
}

@end
