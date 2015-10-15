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


@implementation MenuTableViewController

typedef NS_ENUM(NSUInteger, MenuItem) {
    MenuItemFeed=0,
    MenuItemMyPatients,
    MenuItemAddPatients,
    MenuItemSearchMedications,
    MenuItemForum,
    MenuItemConfigurations=5 ,
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
        case MenuItemFeed:
            sbName = kFeedStoryboard;
            sbiewControllerID = kFeedNavID;
            break;
        case MenuItemMyPatients:
            sbName = kFeedStoryboard;
            sbiewControllerID = kFeedNavID;
            break;
        case MenuItemAddPatients:
            sbName = kFeedStoryboard;
            sbiewControllerID = kFeedNavID;
            break;
        case MenuItemSearchMedications:
            sbName = kFeedStoryboard;
            sbiewControllerID = kFeedNavID;
            break;
        case MenuItemForum:
            sbName = kFeedStoryboard;
            sbiewControllerID = kFeedNavID;
            break;
        case MenuItemConfigurations:
            sbName = kFeedStoryboard;
            sbiewControllerID = kFeedNavID;
            break;
        default:
            sbName = kFeedStoryboard;
            sbiewControllerID = kFeedNavID;
            break;
    }

    self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:sbiewControllerID];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
}

@end
