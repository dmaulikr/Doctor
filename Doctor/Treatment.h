//
//  Treatment.h
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Treatment : NSObject


@property (weak,nonatomic) NSString* description;
@property (weak,nonatomic) NSNumber* duration;
@property (weak,nonatomic) NSNumber* status;
@property (weak,nonatomic) NSDate* finishedAt;
@property (strong, nonatomic) NSDate* createdAt;

//Still in test, don't move it
@property (strong, nonatomic) NSString* objectId;
@property (strong, nonatomic) NSMutableArray* versionHistory;
@property (strong, nonatomic) NSDate* lastModifiedAt;


@end
