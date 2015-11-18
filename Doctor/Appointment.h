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
#import "CaseHistory.h"

@interface Appointment : NSObject

@property (weak,nonatomic) Doctor* appointmentDoctor;
@property (weak, nonatomic) Patient* appointmentPatient;
@property (weak, nonatomic) Diagnosis* appointmentDiagnosis;
@property (weak, nonatomic) Treatment* appointmentTreatment;
@property (weak, nonatomic) CaseHistory* appointmentCaseHistory;
@property (strong, nonatomic) NSMutableArray* appointmentExams;
@property (weak,nonatomic) NSDate* appointmentCreatedAt;
@property (strong, nonatomic) NSMutableArray* appointmentVersionHistory;
@property (weak,nonatomic) NSString* appointmentObjectId;
@property (weak,nonatomic) NSDate* appointmentUpdatedAt;

@end
