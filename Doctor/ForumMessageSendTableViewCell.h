#import <UIKit/UIKit.h>
@protocol ForumMessageSendTableViewCellDelegate <NSObject>

- (void) didTappedSendButtom:(NSString *)text;

@end

@interface ForumMessageSendTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UITextField* sendMessageTextField;
@property (nonatomic, strong) id <ForumMessageSendTableViewCellDelegate> delegate;

@end
