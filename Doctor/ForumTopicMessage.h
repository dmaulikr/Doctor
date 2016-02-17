#import <Foundation/Foundation.h>
#import "ForumHeader.h"
#import "ForumTopic.h"

@interface ForumTopicMessage : NSObject

@property (strong, nonatomic) NSString* messageForumRelatedId;
@property (strong, nonatomic) NSString* messageForumOwner;
@property (strong, nonatomic) NSString* messageForumCreatedAt;
@property (strong, nonatomic) NSString* messageForumContent;

@end
