#import "FeedTableViewController.h"
#import "MFSideMenu.h"
#import "AFDropdownNotification.h"

@interface FeedTableViewController ()<AFDropdownNotificationDelegate> {
    AFDropdownNotification* notification;
    BOOL openedNotification;
}

@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNotification];
    self.menuContainerViewController.panMode = YES;
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

#pragma mark - Private Methods
-(void) setupNotification{
    notification = [[AFDropdownNotification alloc] init];
    notification.notificationDelegate = self;
    notification.titleText = @"Olá, ";
    notification.subtitleText = @"Seu tópico sobre cardiologia foi atualizado, quer dar uma olhada?";
    [notification presentInView:self.view withGravityAnimation:NO];
    openedNotification = true;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (openedNotification) {
            [notification dismissWithGravityAnimation:NO];
            openedNotification = false;
        }
    });
}

-(void)dropdownNotificationBottomButtonTapped{
    self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"ForumNavigationControllerID"];
    openedNotification = false;
    [notification dismissWithGravityAnimation:NO];
    
}
@end
