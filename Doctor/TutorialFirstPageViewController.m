#import "TutorialFirstPageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TutorialViewController.h"
#import "AppDelegate.h"
#import "Envio.h"

@interface TutorialFirstPageViewController ()

@property (nonatomic, weak) IBOutlet UILabel* nonThanksLabel;
@property (nonatomic, weak) IBOutlet UIButton* goToTutoButton;

@end

@implementation TutorialFirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden =  YES;
    
    self.nonThanksLabel.backgroundColor = [UIColor clearColor];
    self.nonThanksLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.nonThanksLabel.layer.borderWidth = 3.0;
    
    [self.goToTutoButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
}

- (IBAction)clickedNonTapped:(id)sender{
    [self performSegueWithIdentifier:@"goToAppSegue" sender:self];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    Envio *envio = [[Envio alloc] init];
    [envio updateFirstTime:appDelegate.doctor.doctorObjectId];
}
- (IBAction)clickedIntoTutorial:(id)sender{
    [self performSegueWithIdentifier:@"goToTutorialSegue" sender:self];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    Envio *envio = [[Envio alloc] init];
    [envio updateFirstTime:appDelegate.doctor.doctorObjectId];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    segue.destinationViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

@end
