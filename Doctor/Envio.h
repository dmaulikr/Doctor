#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Patient.h"
#import "Appointment.h"
#import "Treatment.h"
#import "Diagnosis.h"
#import "Doctor.h"
#import "Exam.h"
#import "Medication.h"
#import "ForumTopic.h"
#import "ForumHeader.h"

@interface Envio : NSObject

@property (nonatomic) BOOL granted;

#pragma mark - Creational Queries
- (void) newDoctor: (Doctor*)doctor withCompletion:(void (^)(BOOL *))completion;
- (void) newPatient: (Patient*)patient;
- (void) newAppointment: (Appointment*)appointment withCompletion:(void (^)(BOOL *))completion;
- (void) newDiagnosis: (Diagnosis*)diagnosis;
- (void) newTreatment: (Treatment*)treatment;
- (void) newExam: (Exam*)tipo withCompletion:(void (^)(BOOL *))completion;
- (void) newForumTopic:(ForumTopic *)forumTopic withCompletion:(void (^)(BOOL finished))completion;
- (void) newMessage:(ForumTopicMessage *)message whenComplete:(void (^)(BOOL finished))completion;

#pragma mark - Retrieving Queries
- (void)fetchRootTreatment:(Treatment*) rootTreatment withCompletion:(void (^)(Treatment* treatment))completion;
- (void)signIn: (NSString*)username withPassword: (NSString*)password :(void (^)(BOOL finished))completion;
- (void)logIn: (NSString*)username withPassword: (NSString*)password :(void (^)(BOOL finished))completion;
- (void)fetchPatientPassingCPF: (NSString*)CPF withCompletion:(void (^)(Patient* patient))completion;
- (void)fetchAllPatients: (void (^)(NSMutableArray* patientArray))completion;
- (void)fetchAllMedications:(void (^)(NSMutableArray* medicationArray))completion;
- (void)fetchAllLabs:(void (^)(NSMutableArray* labsArray))completion;
- (void)fetchAllPas:(void (^)(NSMutableArray *))completion;
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
- (void) deletePatient: (Patient*)patient fromDoctor: (Doctor*)doctor;
- (void) deleteDiagnosis: (Diagnosis*)diagnosis withCompletion: (void (^)(BOOL succeded))completion;
- (void) deleteExam: (Exam*)exam withCompletion: (void (^)(BOOL succeded))completion;
- (void) deleteDoctor: (Doctor*)doctor withCompletion: (void (^)(BOOL succeded))completion;

- (void)fetchLastSeen:(Doctor *)doctor :(Patient *) patient :(void (^)(NSString * lastSeen))completion;

#pragma mark - Forum
- (void) newTopic: (ForumTopic*) topic;
- (void) newTopicMessage: (ForumTopicMessage*) message;
- (void) fetchAllTopicsAboutSubject: (ForumSubject*)subject withCompletion:(void (^)(ForumTopic* topic))completion;
- (void) fetchTopicsThatIncludes: (NSString*) search withCompletion: (void (^)(ForumTopic* topic))completion;
- (void) fetchAllTopicMessagesFromTopic: (ForumTopic*)topic withCompletion: (void (^)(ForumTopicMessage* message))completion;
- (void) setTopicAsFavourite:(NSString *)topicId :(Doctor *)doctor withCompletion: (void (^)(BOOL* finished))completion;
- (void) setTopicAsSaw:(NSString *)topicId :(Doctor *)doctor withCompletion: (void (^)(BOOL* finished))completion;
- (void) updatePatient:(NSString *)patientId withPatient:(Patient *)patient withCompletion: (void (^)(BOOL finished))completion;
- (void) updateFirstTime:(NSString *)doctorObjectId;

#pragma mark - Recover Password
- (void) askedForRecoveringPassword:(NSString *)username withCompletion:(void (^)(Doctor* doctor)) completion;
- (void) askedForChangingPassword:(Doctor *)doctor :(NSString *)newPassword withCompletion:(void (^)(BOOL finished)) completion;

#pragma mark - Settings
- (void) updateDoctor:(NSString *)objectIdFromDoctor withDoctor:(Doctor *)doctor withCompletion: (void (^)(BOOL finished))completion;
- (void)fetchAllComercialNames:(void (^)(NSMutableArray *))completion;

- (void) verifyAuthenticity:(NSString *) user :(NSString *) password :(void (^)(BOOL finished))completion;

@end

