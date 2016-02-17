#import "MainViewController.h"
#import "Storyboards.h"

@implementation MainViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    
    self.centerViewController = [[UIStoryboard storyboardWithName:kOutsideStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kOutsideNavID];
    
    self.leftMenuViewController = [[UIStoryboard storyboardWithName:kMainStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kMainMenuID];
    
    self.leftMenuWidth = 250;
}

@end
