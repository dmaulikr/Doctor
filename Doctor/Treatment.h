//
//  Treatment.h
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Doctor.h"
#import "Patient.h"

@interface Treatment : NSObject


@property (strong, nonatomic) NSString* treatmentDescription;
@property (strong, nonatomic) NSNumber* treatmentDuration;
@property (strong, nonatomic) NSNumber* treatmentStatus;
@property (strong, nonatomic) NSDate* treatementFinishedAt;
@property (strong, nonatomic) NSDate* treatmentCreatedAt;

//Still in test, don't move it
@property (strong, nonatomic) NSString* treatmentObjectId;
@property (strong, nonatomic) NSMutableArray* treatmentVersionHistory;
@property (strong, nonatomic) NSDate* treatmentUpdatedAt;

@property (strong, nonatomic) Doctor* treatmentDoctor;
//@property (strong, nonatomic) Patient* treatmentPatient;


@end
