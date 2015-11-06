//
//  Diagnosis.h
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Doctor.h"
#import "Patient.h"

@interface Diagnosis : NSObject

@property (weak,nonatomic) NSDate* diagnosisConfirmedAt;
@property (weak,nonatomic) NSNumber* diagnosisStatus;
@property (weak,nonatomic) NSString* diagnosisDescription;
@property (weak,nonatomic) NSDate* diagnosisCreatedAt;
@property (strong, nonatomic) NSString* diagnosisObjectId;
@property (strong, nonatomic) NSMutableArray* diagnosisVersionHistory;
@property (strong, nonatomic) NSDate* diagnosisUpdatedAt;

@property (strong, nonatomic) Doctor* diagnosisAuthor;
@property (strong, nonatomic) Patient* diagnosisPatient;

@end
