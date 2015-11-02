//
//  ForumTopicMessage.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/1/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForumTopic.h"

@interface ForumTopicMessage : NSObject

@property (strong, nonatomic) NSString* messageForumCreatedBy;
@property (strong, nonatomic) NSString* messageForumContent;
@property (strong, nonatomic) ForumTopic* forumTopic;
@property (strong, nonatomic) NSString* messageForumCreatedAt;

@end
