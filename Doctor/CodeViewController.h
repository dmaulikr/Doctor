#import <UIKit/UIKit.h>


@protocol CodeViewControllerDelegate <NSObject>

- (void) didTappedConfirmButton:(NSString *) code;
- (void) didTappedQuitButton;

@end

@interface CodeViewController : UIViewController

@property (nonatomic, strong) id <CodeViewControllerDelegate> delegate;

@end
