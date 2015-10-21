//
//  MedicationsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "MedicationsTableViewController.h"
#import "MFSideMenu.h"
#import "Medication.h"

@interface MedicationsTableViewController () <UISearchBarDelegate> {
    NSMutableArray* tableViewDataArray;
    BOOL isSearching;
}

@property (strong, nonatomic) IBOutlet UISearchBar *patientSearchBar;
@property (strong, nonatomic) NSMutableArray* medicationsArray;
@property (strong, nonatomic) NSMutableArray* filteredMedicationsArray;

@end

@implementation MedicationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDataSource];
}

-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* MedicationsTableViewCellID = @"MedicationsCategoryTableViewCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MedicationsTableViewCellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MedicationsTableViewCellID];
    }
    NSLog(tableViewDataArray[indexPath.row]);
    cell.textLabel.text = tableViewDataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"clickedAtMedicationCategorySegueID" sender:self];
}

#pragma mark - Setups
- (void)setupDataSource{
        tableViewDataArray = [[NSMutableArray alloc] initWithObjects:
                              @"Antiinflamatório",
                              @"Antiviral",
                              @"Anticoagulante",
                              @"Analgésico",
                              @"Antimicrobiano",
                              @"Antirarrítmico",
                              @"Antidepressivo",
                              @"Anti-hipertensivo",
                              @"Antibacteriano",
                              @"Antimicótico",
                              @"Diurético",
                              @"Antiestrogênico",
                              @"Corticóide",
                              @"Antifúngico",
                              @"Antianginoso",
                              @"Neurotrófico",
                              @"Cicatrizante",
                              @"Andiabético ",
                              @"Antipirético",
                              @"Antiacneico",
                              @"Anti-helmíntico",
                              @"Antiemético",
                              @"Antitrombótico",
                              @"Anti-hipoxêmico",
                              @"Antigotoso",
                              @"Antiosteoporótico",
                              @"Antineoplásico",
                              @"Ansiolítico",
                              @"Progestagênio",
                              @"Cicatrizante",
                              @"Neurotônico ",
                              @"Antileucêmico",
                              @"Anti-histamínico",
                              @"Hipocolesterolêmico",
                              @"Antirretroviral",
                              @"Imunossupressor",
                              @"Antirreumático",
                              @"Anti-hipotensor",
                              @"Antiparkinsoniano",
                              @"Hipouricemiante",
                              @"Antipsicótico",
                              @"Antiprotozoário",
                              @"Anorexígeno",
                              @"Oligonutriente",
                              @"Anticonvulsivante",
                              @"Mucolítico",
                              @"Vasodilatador",
                              @"Antiácido",
                              @"Antiepilético",
                              @"Antiasmático",
                              @"Hipolipemiante",
                              @"Antisséptico ",
                              @"Uricosúrico",
                              @"Antichagásico",
                              @"Antitussígeno",
                              @"Antifotossensibilizante",
                              @"Antiglaucomatoso",
                              @"Antineoplásico",
                              @"Nootrópico",
                              @"Antidiscinésico",
                              @"Laxante",
                              @"Estimulante",
                              @"Opiáceo",
                              @"Anticoncepcional",
                              @"Antiagregante",
                              @"Inibidor",
                              @"Antiparasitário",
                              @"Miorrelaxante",
                              @"Midríatico",
                              @"Antidiarreico",
                              @"Glicocorticoide",
                              @"Broncodilatador",
                              @"Gastrocinético ",
                              @"Despigmentador",
                              @"Antimalárico",
                              @"Corticosteroide",
                              @"Hipnótico",
    nil];
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    if ([searchText isEqualToString:@""]) {
        tableViewDataArray = self.medicationsArray;
    }
    else{
        isSearching = true;
//        [self.filteredMedicationsArray removeAllObjects];
//        for (int i = 0; i < self.medicationsArray.count; i++) {
//            Medication* medicationSearching = [[Medication alloc] init];
//            medicationSearching = self.medicationsArray[i];
//            NSString* toCheck = [patientSearching.patientNameString lowercaseString];
//            if ([toCheck containsString:[searchText lowercaseString]]) {
//                [self.filteredMedicationsArray addObject:medicationSearching];
//            }
//        }
        tableViewDataArray = self.filteredMedicationsArray;
    }
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    return YES;
}


@end
