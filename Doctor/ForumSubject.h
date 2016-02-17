#import <Foundation/Foundation.h>
#import "ForumHeader.h"

@interface ForumSubject : NSObject

@property (strong, nonatomic) NSString* forumSubjectObjectId;
@property (strong, nonatomic) NSString* forumSubjectTitle;
@property (strong, nonatomic) NSDate* forumSubjectCreatedAt;
@property (strong, nonatomic) NSDate* forumSubjectUpdatedAt;

@end
