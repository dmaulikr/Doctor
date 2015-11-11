//
//  MenuTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/15/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "MenuTableViewController.h"

#import <MFSideMenu/MFSideMenu.h>
#import "MenuTableViewController.h"
#import "Storyboards.h"
#import "AppDelegate.h"
#import "Parse.h"


@implementation MenuTableViewController

typedef NS_ENUM(NSUInteger, MenuItem) {
    MenuItemNull=0,
    MenuItemFeed,
    MenuItemAppointments,
    MenuItemInbox,
    MenuItemPatients,
    MenuItemMedications,
    MenuItemForum,
    MenuItemConfigurations,
    MenuItemLogOut=8 ,
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
        case MenuItemFeed:
            sbName = kFeedStoryboard;
            sbiewControllerID = kFeedNavID;
            break;
        case MenuItemAppointments:
            sbName = kAppointmentsStoryboard;
            sbiewControllerID = kAppointmentsNavID;
            break;
        case MenuItemInbox:
            sbName = kInboxStoryboard;
            sbiewControllerID = kInboxNavID;
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
