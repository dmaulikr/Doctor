//
//  MedicationsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "MedicationsTableViewController.h"
#import "MFSideMenu.h"

@interface MedicationsTableViewController (){
    NSMutableArray* tableViewDataArray;
}

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
    nil];
}


@end
