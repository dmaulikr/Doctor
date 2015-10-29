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
#import "Medication.h"



@interface Envio : NSObject


#pragma mark new entries
#pragma mark brand new
- (void) newDoctor: (Doctor*)doctor;

- (void) newPatient: (Patient*)patient;

- (void) newAppointment: (Appointment*)appointment;

- (void) newDiagnosis: (Diagnosis*)diagnosis;

- (void) newTreatment: (Treatment*)treatment;

- (void) newExam: (Exam*)tipo;

- (void) newCaseHistory: (CaseHistory*)caseHistory;

#pragma mark version History

- (void)fetchRootTreatment:(Treatment*) rootTreatment
            withCompletion:(void (^)(Treatment* treatment))completion;




#pragma mark queries
- (void)signIn: (Doctor*)doctor;

- (void)fetchPatient: (NSString*)CPF
      withCompletion:(void (^)(Patient* patient))completion;

- (void)fetchAllPatients: (void (^)(Patient* patient))completion;

- (void)fetchAllMedications: (void (^)(Medication* medication))completion;

- (void)fetchAppointment: (NSNumber*)doctor
               createdAt: (NSDate*)createdAt
          withCompletion:(void (^)(Appointment* appointment))completion;

- (void)fetchAllAppointments: (void (^)(Appointment* appointment))completion;

- (void)fetchTreatment:(NSDate*)createdAt
        withCompletion:(void (^)(Treatment* treatment))completion;

- (void)fetchAllTreatments:(void (^)(Treatment* treatment))completion;

- (void)fetchDiagnosis: (NSDate*)createdAt
        withCompletion:(void (^)(Diagnosis* diagnosis))completion;

- (void)fetchAllDiagnosis:(void (^)(Diagnosis* diagnosis))completion;

- (void)fetchDoctor: (NSString*)CRM
     withCompletion:(void (^)(Doctor* doctor))completion;


#pragma mark delete methods

- (void) deleteTreatment: (Treatment*)treatment
          withCompletion: (void (^)(BOOL succeded))completion;

- (void) deletePatient: (Patient*)patient
            fromDoctor: (Doctor*)doctor; //only drops the patient from the doctor's patientArray, not from our platform

- (void) deleteDiagnosis: (Diagnosis*)diagnosis
          withCompletion: (void (^)(BOOL succeded))completion;

- (void) deleteCaseHistory: (CaseHistory*)caseHistory
            withCompletion: (void (^)(BOOL succeded))completion;

- (void) deleteExam: (Exam*)exam
     withCompletion: (void (^)(BOOL succeded))completion;

- (void) deleteDoctor: (Doctor*)doctor
       withCompletion: (void (^)(BOOL succeded))completion;



@end
