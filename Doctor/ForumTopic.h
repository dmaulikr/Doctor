//
//  ForumTopic.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/1/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForumHeader.h"
#import "ForumSubject.h"
#import "Doctor.h"

@interface ForumTopic : NSObject

@property (strong, nonatomic) NSString* topicForumObjectId;
@property (strong, nonatomic) Doctor* topicForumCreatedBy;
@property (strong, nonatomic) NSDate* topicForumCreatedAt;
@property (strong, nonatomic) NSDate* topicForumUpdatedAt;
@property (strong, nonatomic) NSString* topicForumTitle;
@property (strong, nonatomic) ForumSubject* topicSubject;

@end
