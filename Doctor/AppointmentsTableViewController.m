#import "AppointmentsTableViewController.h"
#import "MFSideMenu.h"

@interface AppointmentsTableViewController ()

@end

@implementation AppointmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

@end
