#import "HomeViewController.h"
#import "MFSideMenu.h"
#import "Storyboards.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel* separator1Label;
@property (weak, nonatomic) IBOutlet UILabel* separator2Label;
@property (weak, nonatomic) IBOutlet UILabel* separator3Label;
@property (weak, nonatomic) IBOutlet UILabel* separator4Label;
@property (weak, nonatomic) IBOutlet UIButton* patientsButton;
@property (weak, nonatomic) IBOutlet UIButton* forumButton;
@property (weak, nonatomic) IBOutlet UIButton* settingsButton;
@property (weak, nonatomic) IBOutlet UIButton* medicationsButton;
@property (weak, nonatomic) IBOutlet UIButton* logOutButton;

@end

@implementation HomeViewController

- (void) viewWillAppear:(BOOL)animated{
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.separator1Label.alpha = 0;
    self.separator2Label.alpha = 0;
    self.separator3Label.alpha = 0;
    self.separator4Label.alpha = 0;
    self.patientsButton.alpha = 0;
    self.medicationsButton.alpha = 0;
    self.forumButton.alpha = 0;
    self.settingsButton.alpha = 0;
    self.logOutButton.alpha = 0;

    [self fadeInGUI];
}

- (IBAction)didTappedPatientButton:(UIButton *)sender{
    [self fadeOutGUIPassingButtonChoosed:sender];
}

- (IBAction)didTappedForumButton:(UIButton *)sender{
    [self fadeOutGUIPassingButtonChoosed:sender];
}

- (IBAction)didTappedMedicationsButton:(UIButton *)sender{
    [self fadeOutGUIPassingButtonChoosed:sender];
}

- (IBAction)didTappedSettingsButton:(UIButton *)sender{
    [self fadeOutGUIPassingButtonChoosed:sender];
}

- (IBAction)didTappedLogoutButton:(UIButton *)sender{
    [self fadeOutGUIPassingButtonChoosed:sender];
}

- (void) fadeInGUI{
    [UIView animateWithDuration:.3f animations:^{
        self.separator1Label.alpha = 1;
        self.separator2Label.alpha = 1;
        self.separator3Label.alpha = 1;
        self.separator4Label.alpha = 1;
        self.patientsButton.alpha = 1;
        self.medicationsButton.alpha = 1;
        self.settingsButton.alpha = 1;
        self.logOutButton.alpha = 1;
        self.forumButton.alpha = 1;
    }];
}

- (void) fadeOutGUIPassingButtonChoosed:(UIButton *)button{
    if ([button isEqual:self.patientsButton]) {
        
        [UIView animateWithDuration:.3f animations:^{
            self.separator1Label.alpha = 0;
            self.separator2Label.alpha = 0;
            self.separator3Label.alpha = 0;
            self.separator4Label.alpha = 0;
          //  self.patientsButton.alpha = 0;
            self.medicationsButton.alpha = 0;
            self.settingsButton.alpha = 0;
            self.logOutButton.alpha = 0;
            self.forumButton.alpha = 0;
        } completion:^(BOOL finished){
            self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kPatientsStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kPatientsNavID];
        }];
    }
    else if ([button isEqual:self.medicationsButton]){
        
        [UIView animateWithDuration:.3f animations:^{
            self.separator1Label.alpha = 0;
            self.separator2Label.alpha = 0;
            self.separator3Label.alpha = 0;
            self.separator4Label.alpha = 0;
            self.patientsButton.alpha = 0;
         //   self.medicationsButton.alpha = 0;
            self.settingsButton.alpha = 0;
            self.logOutButton.alpha = 0;
            self.forumButton.alpha = 0;
        } completion:^(BOOL finished){
            self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kMedicationsStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kMedicationsNavID];
        }];
    }
    else if ([button isEqual:self.forumButton]){
        
        [UIView animateWithDuration:.3f animations:^{
            self.separator1Label.alpha = 0;
            self.separator2Label.alpha = 0;
            self.separator3Label.alpha = 0;
            self.separator4Label.alpha = 0;
            self.patientsButton.alpha = 0;
            self.medicationsButton.alpha = 0;
            self.settingsButton.alpha = 0;
            self.logOutButton.alpha = 0;
       //     self.forumButton.alpha = 0;
        } completion:^(BOOL finished){
            self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kForumStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kForumNavID];
        }];
    }
    else if ([button isEqual:self.settingsButton]){
        
        [UIView animateWithDuration:.3f animations:^{
            self.separator1Label.alpha = 0;
            self.separator2Label.alpha = 0;
            self.separator3Label.alpha = 0;
            self.separator4Label.alpha = 0;
            self.patientsButton.alpha = 0;
            self.medicationsButton.alpha = 0;
       //     self.settingsButton.alpha = 0;
            self.logOutButton.alpha = 0;
            self.forumButton.alpha = 0;
        } completion:^(BOOL finished){
            self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kSettingsStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kSettingsNavID];
        }];
    }
    else{
        [UIView animateWithDuration:.3f animations:^{
            self.separator1Label.alpha = 0;
            self.separator2Label.alpha = 0;
            self.separator3Label.alpha = 0;
            self.separator4Label.alpha = 0;
            self.patientsButton.alpha = 0;
            self.medicationsButton.alpha = 0;
            self.settingsButton.alpha = 0;
      //      self.logOutButton.alpha = 0;
            self.forumButton.alpha = 0;
        } completion:^(BOOL finished){
                self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:kOutsideStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kOutsideNavID];
        }];
    }
}


@end
