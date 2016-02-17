#import "FeedTableViewController.h"
#import "MFSideMenu.h"

@interface FeedTableViewController ()

@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuContainerViewController.panMode = YES;
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

@end
