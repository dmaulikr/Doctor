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
#import "ForumTopic.h"
#import "Message.h"
#import "Log.h"
//#import "LogActivity.h"
#import "ForumHeader.h"
//#import "LogActivity.h"



@interface Envio : NSObject

#pragma mark - Creational Queries
- (void) newDoctor: (Doctor*)doctor;
- (void) newPatient: (Patient*)patient;
- (void) newAppointment: (Appointment*)appointment;
- (void) newDiagnosis: (Diagnosis*)diagnosis;
- (void) newTreatment: (Treatment*)treatment;
- (void) newExam: (Exam*)tipo;
- (void) newCaseHistory: (CaseHistory*)caseHistory;
- (void) newForumTopic:(ForumTopic *)forumTopic withCompletion:(void (^)(BOOL finished))completion;
- (void) newMessage:(ForumTopicMessage *)message whenComplete:(void (^)(BOOL finished))completion;

#pragma mark - Retrieving Queries
- (void)fetchRootTreatment:(Treatment*) rootTreatment withCompletion:(void (^)(Treatment* treatment))completion;
- (void)signIn: (NSString*)username withPassword: (NSString*)password :(void (^)(BOOL finished))completion;
- (void)logIn: (NSString*)username withPassword: (NSString*)password :(void (^)(BOOL finished))completion;

- (void)fetchPatientPassingCPF: (NSString*)CPF withCompletion:(void (^)(Patient* patient))completion;
- (void)fetchAllPatients: (void (^)(NSMutableArray* patientArray))completion;

- (void)fetchAllMedications: (void (^)(NSMutableArray* medicationArray))completion;

- (void)fetchAppointmentPassingDoctor:(Doctor *)doctor withCompletion:(void (^)(NSMutableArray* appointmentArray))completion;
- (void)fetchAppointmentPassingPatient:(Patient *)patient withCompletion:(void (^)(NSMutableArray* appointmentArray))completion;
- (void)fetchAllAppointments: (void (^)(NSMutableArray* appointmentArray))completion;

- (void)fetchTreatmentPassingPatient:(Patient*)patient withCompletion:(void (^)(NSMutableArray* treatmentArray))completion;
- (void)fetchTreatmentPassingDoctor:(Doctor*)doctor withCompletion:(void (^)(NSMutableArray* treatmentArray))completion;
- (void)fetchAllTreatments:(void (^)(NSMutableArray* treatmentArray))completion;

- (void)fetchDiagnosisPassingDate: (NSDate*)createdAt withCompletion:(void (^)(Diagnosis* diagnosis))completion;
- (void)fetchAllDiagnosis:(void (^)(NSMutableArray* diagnosis))completion;

- (void)fetchDoctorPassingCRM: (NSString*)CRM withCompletion:(void (^)(Doctor* doctor))completion;

- (void)fetchExamsPassingPatient: (Patient*)patient withCompletion:(void (^)(NSMutableArray* examsArray))completion;

- (void)fetchAllForumTopics :(void (^)(NSMutableArray* forumTopicsArray))completion;

- (void)fetchMessagesFromTopic: (NSString *)relatedIdForum withCompletion:(void (^)(NSMutableArray* messageArray))completion;

#pragma mark - Deleting Queries
- (void) deleteTreatment: (Treatment*)treatment withCompletion: (void (^)(BOOL succeded))completion;
- (void) deletePatient: (Patient*)patient fromDoctor: (Doctor*)doctor; //only drops the patient from the doctor's patientArray, not from our platform
- (void) deleteDiagnosis: (Diagnosis*)diagnosis withCompletion: (void (^)(BOOL succeded))completion;
- (void) deleteCaseHistory: (CaseHistory*)caseHistory withCompletion: (void (^)(BOOL succeded))completion;
- (void) deleteExam: (Exam*)exam withCompletion: (void (^)(BOOL succeded))completion;
- (void) deleteDoctor: (Doctor*)doctor withCompletion: (void (^)(BOOL succeded))completion;

#pragma mark - User interface error
- (void) showAlertViewError: (NSError*)error;
- (void) showAlertViewConfirmation;

#pragma mark - Log Queries (Doctor)
- (void) generateDoctorCreationLog;
- (void) generateDoctorUpdateInfoLog;
- (void) generateDoctorInteractionLog;
- (void) generateDoctorDeleteLog;

#pragma mark - Log Queries (Patient)
- (void) generatePatientCreationLog;
- (void) generatePatientUpdateInfoLog;
- (void) generatePatientDeleteLog;

#pragma mark - Log Queries (Diagnosis)
- (void) generateDiagnosisCreationLog;
- (void) generateDiagnosisUpdateLog;
- (void) generateDiagnosisDeleteLog;

#pragma mark - Log Queries (Exam)
- (void) generateExamCreationLog;
- (void) generateExamUpdateLog;
- (void) generateExamDeleteLog;

#pragma mark - Log Queries (Appointment)
- (void) generateAppointmentCreationLog;
- (void) generateAppointmentUpdateLog;
- (void) generateAppointmentDeleteLog;

#pragma mark - Log Queries (Forum)
- (void) generateForumCreationLog;
- (void) generateForumUpdateLog;
- (void) generateForumDeleteLog;
- (void) generateForumInteractionLog;

#pragma mark - Log Queries (Treatment)
- (void) generateTreatmentCreationLog;
- (void) generateTreatmentUpdateLog;
- (void) generateTreatmentDeleteLog;

#pragma mark - Log Queries (Message - Cryptography ASAP)
- (void) generateMessageCreationLog;
- (void) generateMessageDeleteLog;

#pragma mark - Other log queries
- (void) generateLogInLog;


- (void)fetchLastSeen:(Doctor *)doctor :(Patient *) patient :(void (^)(NSString * lastSeen))completion;


#pragma mark forum

- (void) newTopic: (ForumTopic*) topic;
- (void) newTopicMessage: (ForumTopicMessage*) message;
- (void) fetchAllTopicsAboutSubject: (ForumSubject*)subject
                     withCompletion:(void (^)(ForumTopic* topic))completion;
- (void) fetchTopicsThatIncludes: (NSString*) search
                  withCompletion: (void (^)(ForumTopic* topic))completion;
- (void) fetchAllTopicMessagesFromTopic: (ForumTopic*)topic
                         withCompletion: (void (^)(ForumTopicMessage* message))completion;

- (void) setTopicAsFavourite:(NSString *)topicId :(Doctor *)doctor withCompletion: (void (^)(BOOL* finished))completion;

@end

