//
//  MedicationsLabsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/11/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "MedicationsLabsTableViewController.h"
#import "MedicationsLabsTableViewCell.h"
#import "MedicationSelectedViewController.h"
#import "Lab.h"
#import "Envio.h"
#import "SVProgressHUD.h"

@interface MedicationsLabsTableViewController () <UISearchBarDelegate> {
NSMutableArray* tableViewDataArray;
UIActivityIndicatorView* spinner;
BOOL isSearching;
}

@property (strong, nonatomic) IBOutlet UISearchBar *medicationsSearchBar;
@property (strong, nonatomic) NSMutableArray* labsArray;
@property (strong, nonatomic) NSMutableArray* filteredLabsArray;

@end

@implementation MedicationsLabsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewDataArray = [[NSMutableArray alloc] init];
    self.filteredLabsArray = [[NSMutableArray alloc] init];
    self.labsArray = [[NSMutableArray alloc] init];
    [self setupLoadingAnimation];
    [self setupDataSource];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* MedicationsTableViewCellID = @"MedicationsLabsTableViewCellID";
    
    MedicationsLabsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MedicationsTableViewCellID];
    if (cell==nil) {
        cell = [[MedicationsLabsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MedicationsTableViewCellID];
    }
    
    Lab* lab = [[Lab alloc] init];
    lab = tableViewDataArray[indexPath.row];
    cell.labSiglaLabel.text = lab.labSigla;
    cell.labExtensoLabel.text = lab.labExtenso;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"medChoosedSegueId" sender:self];
}

#pragma mark - Setups
- (void)setupDataSource{
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchAllLabs: ^void (NSMutableArray* labsArray){
        if (labsArray){
            self.labsArray = labsArray;
            tableViewDataArray = self.labsArray;
            [self.tableView reloadData];
            
            [SVProgressHUD dismiss];
        }else{
            NSLog(@"Erro - setupMedicationsDatasource block");
        }
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"medChoosedSegueId"]) {
        MedicationSelectedViewController * medicationSelected = segue.destinationViewController;
        [medicationSelected setWordToSearchString:@""];
    }

}

- (void) setupLoadingAnimation{
//    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    spinner.center = self.view.center;
//    spinner.tag = 12;
//    [self.view addSubview:spinner];
//    [spinner startAnimating];
       [SVProgressHUD show];
}

#pragma mark - UISearchBarDelegate Methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText isEqualToString:@""]) {
        tableViewDataArray = self.labsArray;
        [self.tableView reloadData];
    }
    else{
        isSearching = true;
        [self.filteredLabsArray removeAllObjects];
        for (int i = 0; i < self.labsArray.count; i++) {
            Lab* labSearching  = [[Lab alloc] init];
            labSearching = self.labsArray[i];
            NSString* toCheck = [labSearching.labSigla lowercaseString];
            if ([toCheck containsString:[searchText lowercaseString]]) {
                [self.filteredLabsArray addObject:labSearching];
            }
        }
        tableViewDataArray = self.filteredLabsArray;
        [self.tableView reloadData];
    }
}

#pragma mark - UITouchDelegate Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    if ([_medicationsSearchBar isFirstResponder] && [touch view] != _medicationsSearchBar) [_medicationsSearchBar resignFirstResponder];
}

@end
