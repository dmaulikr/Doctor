#import "InboxTableViewController.h"
#import "MFSideMenu.h"

@interface InboxTableViewController ()

@end

@implementation InboxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

@end
