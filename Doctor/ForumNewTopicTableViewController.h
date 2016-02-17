#import <UIKit/UIKit.h>
#import "Doctor.h"

@interface ForumNewTopicTableViewController : UITableViewController

@property (nonatomic, strong) Doctor* doctor;
@property (nonatomic, strong) IBOutlet UILabel* ownerLabel;
@property (nonatomic, strong) IBOutlet UITextView* subjectTextView;
@property (nonatomic, strong) IBOutlet UITextView* contentTextView;

@property (nonatomic, strong) IBOutlet UIImageView* ownerImageView;
@property (nonatomic, strong) IBOutlet UIImageView* subjectImageView;
@property (nonatomic, strong) IBOutlet UIImageView* contentImageView;

@property (nonatomic, strong) IBOutlet UILabel* letterCounter;
@property (nonatomic, strong) IBOutlet UILabel* letterContextCounter;

@end
