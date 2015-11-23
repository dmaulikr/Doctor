//
//  SettingsSpecialtiesTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/16/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "SettingsSpecialtiesTableViewController.h"
#import "SettingsSpecialtiesTableViewCell.h"

@interface SettingsSpecialtiesTableViewController (){
    NSMutableArray* specialtiesArray;
    NSMutableArray* alreadySpecialtiesArray;
}

@end

@implementation SettingsSpecialtiesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    specialtiesArray = [[NSMutableArray alloc] initWithObjects:
                        @"Acupuntura",
                        @"Alergologia",
                        @"Angiologia",
                        @"Cardiologia",
                        @"Cirurgia",
                        @"Dermatologia",
                        @"Oncologia",
                        @"Endocrinologia",
                        @"Fisiatria",
                        @"Fonoaudiologia",
                        @"Geriatria",
                        @"Ginecologia",
                        @"Hematologia",
                        @"Mastologia",
                        @"Neurologia",
                        @"Odontologia",
                        @"Psicologia",
                        @"Psiquiatria",
                        @"Pneumologia",
                        @"Radiologia",
                        @"Oftalmologia",
                        @"Urologia", nil];
    
    alreadySpecialtiesArray = [[NSMutableArray alloc] initWithObjects:@"Acupuntura", nil];
    self.tableView.tableFooterView = [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([alreadySpecialtiesArray containsObject:specialtiesArray[indexPath.row]]) {
        [alreadySpecialtiesArray removeObject:specialtiesArray[indexPath.row]];
    }
    else{
        [alreadySpecialtiesArray addObject:specialtiesArray[indexPath.row]];
    }
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return 53; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return specialtiesArray.count; }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SpecialtiesCellID = @"specialtiesCellID";
    
    SettingsSpecialtiesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SpecialtiesCellID];
    
    if (cell == nil){
        cell = [[SettingsSpecialtiesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SpecialtiesCellID];
    }
    cell.specialityLabel.text = specialtiesArray[indexPath.row];

    if ([alreadySpecialtiesArray containsObject:cell.specialityLabel.text]) {
        cell.radioButtonImageView.image = [UIImage imageNamed:@"check-ok"];
    }

    return cell;
}

@end
