//
//  ForumTopic.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/1/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForumTopic : NSObject

@property (strong, nonatomic) NSString* topicForumTheme;
@property (strong, nonatomic) NSString* topicForumDescription;
@property (strong, nonatomic) NSString* topicForumCreatedBy;
@property (strong, nonatomic) NSString* topicForumUpdatedAt;
@property (strong, nonatomic) NSString* topicForumContentPreview;

@end
