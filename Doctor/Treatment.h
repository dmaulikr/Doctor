//
//  Treatment.h
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Treatment : NSObject


@property (weak,nonatomic) NSString* treatmentDescription;
@property (weak,nonatomic) NSNumber* treatmentDuration;
@property (weak,nonatomic) NSNumber* treatmentStatus;
@property (weak,nonatomic) NSDate* treatementFinishedAt;
@property (strong, nonatomic) NSDate* treatmentCreatedAt;

//Still in test, don't move it
@property (strong, nonatomic) NSString* treatmentObjectId;
@property (strong, nonatomic) NSMutableArray* treatmentVersionHistory;
@property (strong, nonatomic) NSDate* treatmentUpdatedAt;


@end
