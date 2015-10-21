//
//  Envio.m
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "Envio.h"

@implementation Envio

#pragma mark newDoctor

- (void) newDoctor: (Doctor*)doctor;
{
    PFUser *user = [PFUser user];
    user.username = doctor.doctor;
    user.password = doctor.password;
    user.email = doctor.email;
    user[@"CRM"] = doctor.CRM;
    user[@"celular"] = doctor.celular;
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //Show error message somewhere and let the user try again
        if (!error) {
            NSLog(@"Signed UP - OK!");
            //Deal with it on a new method;
        } else {
            NSString *errorString = [error userInfo][@"error"];// Show the errorString somewhere and let the user try again.
            NSLog(@"%@", errorString);
            //Deal with it on a new method;
        }
    }];
    
    
}

#pragma mark newPatient

- (void) newPatient: (NSString*)name
            withCPF: (NSNumber*)CPF
     withIdentidade: (NSNumber*)identity
            withAge: (NSNumber*)age
         withAdress: (NSString*)address
{
    
    PFObject* patient = [PFObject objectWithClassName:@"Patient"];
    patient[@"name"] = name;
    patient[@"CPF"] = CPF;
    patient[@"identity"] = identity;
    patient[@"age"] = age;
    patient[@"address"] = address;
    
    
    [patient saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
        } else {
            // There was a problem, check error.description
        }
    }];
    
    
}

#pragma mark Registers

#pragma mark newDiagnosis
- (void) newDiagnosis: (Diagnosis*)diagnosis
{
    PFObject* newDiagnosis  = [PFObject objectWithClassName:@"Register"];
    newDiagnosis[@"confirmedAt"] = diagnosis.confirmedAt;
    newDiagnosis[@"status"] = diagnosis.status;
    newDiagnosis[@"description"] = diagnosis.description;
    
    
    [newDiagnosis saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
        } else {
            // There was a problem, check error.description
        }
    }];

}

#pragma mark newTreatment
- (void) newTreatment: (Treatment*)treatment
{
    PFObject* newTreatment  = [PFObject objectWithClassName:@"Treatment"];
    newTreatment[@"description"] = treatment.description;
    newTreatment[@"duration"] = treatment.duration;
    newTreatment[@"status"] = treatment.status; //NSNumber numberWithBool: method, with YES or NO
    newTreatment[@"finishedAt"] = treatment.finishedAt;
    
    
    [newTreatment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
        } else {
            // There was a problem, check error.description
        }
    }];

}

#pragma mark newExam
- (void) newExam: (Exam*)exam
{
    PFObject* newExam  = [PFObject objectWithClassName:@"Exam"];
    newExam[@"type"] = exam.tipo;
    newExam[@"description"] = exam.description;
    //Create a PFFile to store a photo
    newExam[@"photo"] = exam.photo;
    
    
    [newExam saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
        } else {
            // There was a problem, check error.description
        }
    }];

}

#pragma mark newCaseHistory
- (void) newCaseHistory: (CaseHistory*)caseHistory
{
    PFObject* newCaseHistory  = [PFObject objectWithClassName:@"Register"];
    newCaseHistory[@"description"] = caseHistory.description;
    //Create PFFile
    newCaseHistory[@"photo"] = caseHistory.photo;
    
    
    
    [newCaseHistory saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
        } else {
            // There was a problem, check error.description
        }
    }];
}

#pragma mark newAppointment

- (void) newAppointment: (Doctor*)doctor;
{
    PFObject* newAppointment = [PFObject objectWithClassName:@"Patient"];
    newAppointment[@"doctor"] = doctor;
    
    [newAppointment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
        } else {
            // There was a problem, check error.description
        }
    }];
    
}

#pragma mark Queries
#pragma mark Sign In
- (void)signIn: (NSString*)username
  withPassword: (NSString*)password
{
    [PFUser logInWithUsernameInBackground:username password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                        } else {
                                            // The login failed. Check error to see why.
                                        }
                                    }];
}

#pragma mark fetchPatient
- (Patient*)fetchPatient: (NSNumber*)CPF
{
    Patient* patient;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
    [query whereKey:@"CPF" equalTo:CPF];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                patient.patientNameString = [object objectForKey:@"name"];
                patient.patientCPFString = [object objectForKey:@"CPF"];
                patient.patientAgeString = [object objectForKey:@"age"];
                patient.patientRGString = [object objectForKey:@"RG"];
                patient.patientGenderString = [object objectForKey:@"gender"];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return patient;
}

- (NSMutableArray*)fetchAllPatients
{
    NSMutableArray* patients = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
                Patient* patient = [[Patient alloc]init];
                patient.patientNameString = [object objectForKey:@"name"];
                patient.patientCPFString = [object objectForKey:@"CPF"];
                patient.patientAgeString = [object objectForKey:@"age"];
                patient.patientRGString = [object objectForKey:@"RG"];
                
                [patients addObject:patient];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return patients;
}


#pragma mark fetchAppointment
- (Appointment*)fetchAppointment: (NSNumber*)doctor
                       createdAt:(NSDate *)createdAt
{
    Appointment* appointment;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Appointment"];
    [query whereKey:@"createdAt" equalTo:createdAt];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                appointment.doctor = [object objectForKey:@"doctor"];
                appointment.createdAt = [object objectForKey:@"createdAt"];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return appointment;
    
}

#pragma mark fetchTreatment
- (Treatment*)fetchTreatment: (NSDate*)createdAt
{
    Treatment* treatment;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Treatment"];
    [query whereKey:@"createdAt" equalTo:createdAt];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                treatment.duration = [object objectForKey:@"duration"];
                treatment.description = [object objectForKey:@"createdAt"];
                treatment.finishedAt = [object objectForKey:@"finishedAt"];
                treatment.status = [object objectForKey:@"status"];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return treatment;
}

#pragma mark fetchDiagnosis
- (Diagnosis*)fetchDiagnosis: (NSDate*)createdAt
{
    Diagnosis* diagnosis;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diagnosis"];
    [query whereKey:@"createdAt" equalTo:createdAt];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                diagnosis.createdAt = [object objectForKey:@"createdAt"];
                diagnosis.confirmedAt = [object objectForKey:@"confirmedAt"];
                diagnosis.status = [object objectForKey:@"status"];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return diagnosis;
}




@end
