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


@interface Envio : NSObject


#pragma mark new entries
- (void) newDoctor: (NSString*)username
         withEmail: (NSString*)email
      withPassword: (NSString*)password
           withCRM: (NSInteger*)CRM
       withCelular: (NSInteger*)celular;

- (void) newPatient: (NSString*)name
            withCPF: (NSInteger)CPF
     withIdentidade: (NSInteger)identity
            withAge: (NSInteger)age
          withAdress: (NSString*)adress;

- (void) newRegister: (NSString*)tipo;

- (void) newAppointment: (NSInteger)CRM;

- (void) newDiagnosis: (BOOL)status
      withDescription: (NSString*)description;

- (void) newTreatment: (NSString*)description
          withStatus: (BOOL)status
        withDuration: (NSInteger)duration
withConfirmationDate: (NSDate*)efectivedConfirmationDate;

- (void) newExam: (NSString*)tipo
withDescription: (NSString*)description
      withPhoto: (PFFile*)photo;

- (void) newCaseHistory: (NSString*)description
              withPhoto: (PFFile*)photo;

#pragma mark queries
- (void)signIn: (NSString*)username
  withPassword: (NSString*)password;

- (Patient*)fetchPatient: (NSInteger)CPF;





@end
