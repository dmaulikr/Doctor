#import "MenuTableViewController.h"
#import <MFSideMenu/MFSideMenu.h>
#import "Storyboards.h"

@implementation MenuTableViewController

typedef NS_ENUM(NSUInteger, MenuItem) {
    MenuItemNull=0,
    MenuItemPatients,
    MenuItemMedications,
    MenuItemForum,
    MenuItemConfigurations,
    MenuItemLogOut=5 ,
};

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView	= [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *sbName;
    NSString *sbiewControllerID;
    
    switch (indexPath.row) {
        case MenuItemNull:
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
            return;
            break;
        case MenuItemPatients:
            sbName = kPatientsStoryboard;
            sbiewControllerID = kPatientsNavID;
            break;
        case MenuItemMedications:
            sbName = kMedicationsStoryboard;
            sbiewControllerID = kMedicationsNavID;
            break;
        case MenuItemForum:
            sbName = kForumStoryboard;
            sbiewControllerID = kForumNavID;
            break;
        case MenuItemConfigurations:
            sbName = kSettingsStoryboard;
            sbiewControllerID = kSettingsNavID;
            break;
        case MenuItemLogOut:
            sbName = kOutsideStoryboard;
            sbiewControllerID = kOutsideNavID;
            break;
        default:
            sbName = kOutsideStoryboard;
            sbiewControllerID = kOutsideNavID;
            break;
    }
    self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:sbiewControllerID];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
}

@end
