#import "SettingsHealthCareTableViewController.h"
#import "SettingsHealthCareTableViewCell.h"

@interface SettingsHealthCareTableViewController (){
    NSMutableArray* healthCareArray;
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
                        @"Sulamerica",
                        @"Unimed",
                        @"Universal",
                        @"Viva", nil];
    
    self.tableView.tableFooterView = [UIView new];
    if(!self.healthCareArray){
        self.healthCareArray = [[NSMutableArray alloc] init];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.healthCareArray containsObject:healthCareArray[indexPath.row]]) {
        [self.healthCareArray removeObject:healthCareArray[indexPath.row]];
    }
    else{
        [self.healthCareArray addObject:healthCareArray[indexPath.row]];
    }
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
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
    
    if ([self.healthCareArray containsObject:healthCareArray[indexPath.row]]) {
        cell.radioButtonImageView.image = [UIImage imageNamed:@"check-ok"];
    }
    else{
        cell.radioButtonImageView.image = [UIImage imageNamed:@"check-naook"];
    }
    return cell;
}

-(IBAction)didTappedToSaveHealthCares:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
