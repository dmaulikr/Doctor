#import <UIKit/UIKit.h>
#import "ForumTopic.h"
#import "Doctor.h"

@interface ForumSeeTopicTableViewController : UITableViewController

@property (nonatomic, strong) ForumTopic* forumTopic;
@property (nonatomic, strong) Doctor* doctor;
@property (nonatomic, strong) IBOutlet UIView* dropdowButtonView;

@end
