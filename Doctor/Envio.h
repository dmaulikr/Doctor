//
//  Envio.h
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Patient.h"
#import "Register.h"
#import "Appointment.h"
#import "Treatment.h"
#import "Diagnosis.h"
#import "Doctor.h"
#import "Exam.h"
#import "CaseHistory.h"



@interface Envio : NSObject


#pragma mark new entries
- (void) newDoctor: (Doctor*)doctor;

- (void) newPatient: (Patient*)patient;

- (void) newAppointment: (Appointment*)appointment;

- (void) newDiagnosis: (Diagnosis*)diagnosis;

- (void) newTreatment: (Treatment*)treatment;

- (void) newExam: (Exam*)tipo;

- (void) newCaseHistory: (CaseHistory*)caseHistory;

#pragma mark queries
- (void)signIn: (Doctor*)doctor;

- (Patient*)fetchPatient: (NSNumber*)CPF;

- (NSMutableArray*)fetchAllPatients;

- (Register*)fetchRegister: (NSString*)type
                 createdAt: (NSDate*) creationDate;

- (Appointment*)fetchAppointment: (NSNumber*)doctor
                       createdAt: (NSDate*)createdAt;

- (Treatment*)fetchTreatment:(NSDate*)createdAt;

- (Diagnosis*)fetchDiagnosis: (NSDate*)createdAt;




@end
