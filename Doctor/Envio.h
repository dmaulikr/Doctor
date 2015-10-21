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
- (void) newDoctor: (NSString*)username
         withEmail: (NSString*)email
      withPassword: (NSString*)password
           withCRM: (NSNumber*)CRM
       withCelular: (NSNumber*)celular;

- (void) newPatient: (NSString*)name
            withCPF: (NSNumber*)CPF
     withIdentidade: (NSNumber*)identity
            withAge: (NSNumber*)age
         withAdress: (NSString*)address;

- (void) newRegister: (NSString*)tipo;

- (void) newAppointment: (NSNumber*)CRM;

- (void) newDiagnosis: (BOOL)status
      withDescription: (NSString*)description;

- (void) newTreatment: (NSString*)description
           withStatus: (BOOL)status
         withDuration: (NSNumber*)duration
 withConfirmationDate: (NSDate*)efectivedConfirmationDate;

- (void) newExam: (NSString*)tipo
 withDescription: (NSString*)description
       withPhoto: (PFFile*)photo;

- (void) newCaseHistory: (NSString*)description
              withPhoto: (PFFile*)photo;

#pragma mark queries
- (void)signIn: (NSString*)username
  withPassword: (NSString*)password;

- (Patient*)fetchPatient: (NSNumber*)CPF;

- (Register*)fetchRegister: (NSString*)type
                 createdAt: (NSDate*) creationDate;

- (Appointment*)fetchAppointment: (NSNumber*)doctor
                       createdAt: (NSDate*)createdAt;

- (Treatment*)fetchTreatment:(NSDate*)createdAt;

- (Diagnosis*)fetchDiagnosis: (NSDate*)createdAt;




@end
