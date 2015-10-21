//
//  ForumTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/20/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "ForumTableViewController.h"
#import "MFSideMenu.h"

@interface ForumTableViewController ()

@end

@implementation ForumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

-(IBAction)didTappedCreateTopicBarButton:(UIBarButtonItem *)sender{
    [self performSegueWithIdentifier:@"clickedToCreateTopicSegueId" sender:self];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"clickedToSeeTopicSegueId" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"clickedToSeeTopicSegueId"]) {
    }
    else if ([segue.identifier isEqualToString:@"clickedToCreateTopicSegueId"]){
    }
}


@end
