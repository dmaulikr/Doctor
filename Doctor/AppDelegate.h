#import <UIKit/UIKit.h>
#import "Doctor.h"
#import "ForumTopic.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Doctor* doctor;
@property (strong, nonatomic) ForumTopic* forumTopic;

@end

