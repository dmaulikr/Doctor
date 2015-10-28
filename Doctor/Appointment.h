//
//  Appointment.h
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Doctor.h"
#import "Patient.h"
#import "Diagnosis.h"
#import "Treatment.h"

@interface Appointment : NSObject

@property (weak,nonatomic) Doctor* doctor;
@property (weak, nonatomic) Patient* patient;
@property (weak, nonatomic) Diagnosis* diagnosis;
@property (weak, nonatomic) Treatment* treatment;

@property (weak,nonatomic) NSDate* createdAt;
@property (strong, nonatomic) NSMutableArray* versionHistory;

@end
