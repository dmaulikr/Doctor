#import "MedicationsTableViewController.h"
#import "MFSideMenu.h"

@interface MedicationsTableViewController ()

@end

@implementation MedicationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
}

-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"medicationsClasses" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"medicationsLabs" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"medicationsPrinciples" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"medicationsComercials" sender:self];
            break;
        default:
            break;
    }
}


@end
