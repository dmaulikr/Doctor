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
    user.username = doctor.doctorUsernameString;
    user.password = doctor.doctorPasswordString;
    user.email = doctor.doctorEmailString;
    user[@"CRM"] = doctor.doctorCRMString;
    user[@"celular"] = doctor.doctorCelularString;
    user[@"patients"] = doctor.patientsArray;
    
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

- (void) newPatient:(Patient*)patient {
    
    PFObject* newPatient = [PFObject objectWithClassName:@"Patient"];
    newPatient[@"name"] = patient.patientNameString;
    newPatient[@"CPF"] = patient.patientCPFString;
    newPatient[@"RG"] = patient.patientRGString;
    newPatient[@"age"] = patient.patientAgeString;
    newPatient[@"address"] = patient.patientAdressString;
    newPatient[@"gender"] = patient.patientGenderString;
    
    
    
    [newPatient saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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
- (void)fetchPatient: (NSString*)CPF
      withCompletion:(void (^)(Patient* patient))completion;{
    
        PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
        [query whereKey:@"CPF" equalTo:CPF];
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
                
                //[patients addObject:patient];
                
                if (patient) {
                    completion(patient);
                }else{
                    completion(nil);
                    NSLog(@"404 - Envio.m - fetchPatient");
                }
            }
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)fetchAllPatients: (void (^)(Patient* patient))completion
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
                patient.patientGenderString = [object objectForKey:@"gender"];
                
                [patients addObject:patient];
                
                if (patient) {
                    completion(patient);
                }else{
                    completion(nil);
                    NSLog(@"404 - Envio.m - fetchAllPatients");
                }
            }
            

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)fetchAllMedications:(void (^)(Medication *))completion{
    NSMutableArray* medications = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Medication"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d medications.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object[@"category"]);
                
                Medication* medication = [[Medication alloc]init];
                medication.medicationCategoryString = [object objectForKey:@"category"];
                
                [medications addObject:medication];
                
                if (medication) {
                    completion(medication);
                }else{
                    completion(nil);
                    NSLog(@"404 - Envio.m - fetchAllMedications");
                }
            }
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}




#pragma mark fetchDoctor

- (void)fetchDoctor: (NSString*)CRM
      withCompletion:(void (^)(Doctor* doctor))completion{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Doctor"];
    [query whereKey:@"CRM" equalTo:CRM];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
                Doctor* doctor = [[Doctor alloc]init];
                doctor.doctorCelularString = [object objectForKey:@"celular"];
                doctor.doctorCRMString = [object objectForKey:@"CRM"];
                doctor.doctorEmailString = [object objectForKey:@"email"];
                doctor.doctorNameString = [object objectForKey:@"name"];
                doctor.doctorPasswordString = [object objectForKey:@"password"];
                doctor.doctorUsernameString = [object objectForKey:@"username"];

                if (doctor) {
                    completion(doctor);
                }else{
                    completion(nil);
                    NSLog(@"404 - Envio.m - fetchDoctor");
                }
            }
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}



#pragma mark fetchAppointment
- (void)fetchAppointment: (Doctor*)doctor
               createdAt: (NSDate*)createdAt
          withCompletion:(void (^)(Appointment* appointment))completion;{
    
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
            if (appointment) {
                completion(appointment);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchAppointment");
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)fetchAllAppointments: (void (^)(Appointment* appointment))completion
{
    Appointment* appointment;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Appointment"];
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
            if (appointment) {
                completion(appointment);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchAllAppointments");
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

#pragma mark fetchTreatment
- (void)fetchTreatment:(NSDate*)createdAt
        withCompletion:(void (^)(Treatment* treatment))completion{
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
            
            if (treatment) {
                completion(treatment);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchTreatment");
            }

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)fetchAllTreatments:(void (^)(Treatment* treatment))completion{
    Treatment* treatment;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Treatment"];
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
            
            if (treatment) {
                completion(treatment);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchAllTreatments");
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)fetchRootTreatment:(Treatment*) rootTreatment
            withCompletion:(void (^)(Treatment* treatment))completion
{
    PFQuery *query = [PFQuery queryWithClassName:@"Treatment"];
    [query whereKey:@"objectId" equalTo:rootTreatment.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                rootTreatment.duration = [object objectForKey:@"duration"];
                rootTreatment.description = [object objectForKey:@"createdAt"];
                rootTreatment.finishedAt = [object objectForKey:@"finishedAt"];
                rootTreatment.status = [object objectForKey:@"status"];
            }
            
            if (rootTreatment) {
                completion(rootTreatment);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchTreatment");
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}



#pragma mark fetchDiagnosis
- (void)fetchDiagnosis: (NSDate*)createdAt
        withCompletion:(void (^)(Diagnosis* diagnosis))completion{
    
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
            if (diagnosis) {
                completion(diagnosis);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchDiagnosis");
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
        }
    }];
}

- (void)fetchAllDiagnosis:(void (^)(Diagnosis* diagnosis))completion{
    Diagnosis* diagnosis;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diagnosis"];
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
            if (diagnosis) {
                completion(diagnosis);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchAllDiagnosis");
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
        }
    }];
}

#pragma mark version History entries

- (void) newVersionTreatment:(Treatment *)treatment
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

#pragma mark delete method

- (void) deleteTreatment: (Treatment*)treatment
          withCompletion: (void (^)(BOOL succeded))completion{
    PFObject* object = [PFObject objectWithoutDataWithClassName:@"Treatment" objectId:treatment.objectId];
    
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError* error){
        if (succeeded) {
            NSLog(@"Treatment succesfully deleted");
            completion(succeeded);
        }
        else
        {
            NSLog(@"Error: %@", error.description);
            completion(succeeded);
        }
    }];
}

- (void) deletePatient: (Patient*)patient
            fromDoctor: (Doctor*)doctor{

    
    //Fetch doctor
    Envio* envio = [[Envio alloc]init];
    NSMutableArray* fetchedPatientsArray = [[NSMutableArray alloc]init];
    
    [envio fetchDoctor:doctor.doctorCRMString withCompletion:^(Doctor* doctor){
        if (doctor) {
            
            [fetchedPatientsArray arrayByAddingObjectsFromArray:doctor.patientsArray];
            
        }else{
            
            NSLog(@"deletePatient:fromDoctor: failed retrieving the doctor - Envio.m");
            
        }
    }];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Doctor"];
    [query whereKey:@"CRM" equalTo:doctor.doctorCRMString];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * doctor, NSError *error) {
        if (!error) {
            // Found doctor
            [doctor setObject:fetchedPatientsArray forKey:@"patientsArray"];
            
            // Save
            [doctor saveInBackground];
        } else {
            // Did not find any doctors
            NSLog(@"Error: %@", error);
        }
    }];
    
}



@end
