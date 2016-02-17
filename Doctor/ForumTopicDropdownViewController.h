#import <UIKit/UIKit.h>

@protocol ForumTopicDropdownViewControllerDelegate <NSObject>
- (void) didTappedDropdownCloseButton;
@end

@interface ForumTopicDropdownViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton* dismissDropdownButton;
@property (nonatomic, weak) IBOutlet UITextView* topicTextView;
@property (nonatomic, weak) IBOutlet UILabel* topicHourLabel;
@property (nonatomic, weak) IBOutlet UILabel* topicSubjectLabel;
@property (nonatomic, weak) IBOutlet UILabel *topicOwnerLabel;

@property (nonatomic, strong) id <ForumTopicDropdownViewControllerDelegate> delegate;

@end


