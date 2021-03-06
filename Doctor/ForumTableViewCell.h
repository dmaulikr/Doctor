#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ForumTableViewCell : SWTableViewCell

@property (nonatomic, strong) IBOutlet UILabel *topicOwner;
@property (nonatomic, strong) IBOutlet UILabel *topicSubject;
@property (nonatomic, strong) IBOutlet UILabel *topicDate;
@property (nonatomic, strong) IBOutlet UITextView *topicSinopse;
@property (nonatomic, strong) NSString* topicObjectId;

@property (weak, nonatomic) IBOutlet UIImageView* nonReadImageView;
@property (weak, nonatomic) IBOutlet UIImageView* favImageView;

@end
