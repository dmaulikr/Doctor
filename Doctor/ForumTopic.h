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

@property (strong, nonatomic) NSString* topicForumSubject;
@property (strong, nonatomic) NSString* topicForumSinopse;
@property (strong, nonatomic) NSString* topicForumOwner;
@property (strong, nonatomic) NSString* topicForumUpdatedAt;
@property (strong, nonatomic) NSString* topicObjectId;

@end