#import "CodeViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface CodeViewController ()

@property (nonatomic, weak) IBOutlet UITextView *firstTextField;
@property (nonatomic, weak) IBOutlet UITextView *secondTextField;
@property (nonatomic, weak) IBOutlet UITextView *thirdTextField;
@property (nonatomic, weak) IBOutlet UITextView *fourthTextField;

@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTappedConfirmButton:(id)sender{
    [SVProgressHUD show];
    if ([_delegate respondsToSelector:@selector(didTappedConfirmButton:)]) {
        [_delegate didTappedConfirmButton:[NSString stringWithFormat:@"%@%@%@%@", self.firstTextField.text, self.secondTextField.text, self.thirdTextField.text, self.fourthTextField.text]];
    }
}
- (IBAction)didTappedQuitButton:(id)sender{
    if ([_delegate respondsToSelector:@selector(didTappedQuitButton)]) {
        [_delegate didTappedQuitButton];
    }
}

@end
