#import <UIKit/UIKit.h>

@interface ForumMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *messageOwner;
@property (nonatomic, strong) IBOutlet UILabel *messageDate;
@property (nonatomic, strong) IBOutlet UITextView *messageContent;

@end
