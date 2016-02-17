#import <Foundation/Foundation.h>
#import "Doctor.h"
#import "Patient.h"
#import "Diagnosis.h"
#import "Treatment.h"

@interface Appointment : NSObject

@property (strong, nonatomic) Doctor* appointmentDoctor;
@property (strong, nonatomic) Patient* appointmentPatient;
@property (strong, nonatomic) NSMutableArray* appointmentExams;
@property (strong, nonatomic) NSDate* appointmentCreatedAt;
@property (strong, nonatomic) NSMutableArray* appointmentVersionHistory;
@property (strong, nonatomic) NSString* appointmentObjectId;
@property (strong, nonatomic) NSDate* appointmentUpdatedAt;
@property (strong, nonatomic) NSString* appointmentProtocol;
@property (strong, nonatomic) NSString* appointmentDate;
@property (strong, nonatomic) NSString* appointmentDiagnosis;
@property (strong, nonatomic) NSString* appointmentTreatment;
@property (strong, nonatomic) NSString* appointmentArea;
@property (strong, nonatomic) NSString* appointmentDoctorEnvolvedCRM;
@property (strong, nonatomic) NSString* appointmentDoctorEnvolvedName;
@property (strong, nonatomic) NSString* appointmentInsurance;

@end
