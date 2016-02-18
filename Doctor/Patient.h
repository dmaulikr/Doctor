#import <Foundation/Foundation.h>

@interface Patient : NSObject

@property (strong, nonatomic) NSString *patientNameString;
@property (strong, nonatomic) NSDate *patientBirthDate;
@property (strong, nonatomic) NSString *patientRGString;
@property (strong, nonatomic) NSString *patientCPFString;
@property (strong, nonatomic) NSString *patientAgeString;
@property (strong, nonatomic) NSString *patientGenderString;
@property (strong, nonatomic) NSString *patientAdressString;
@property (strong, nonatomic) NSString *patientObjectId;
@property (strong, nonatomic) NSMutableArray *patientDoctors;
@property (strong, nonatomic) NSString *patientCameSinceString;
@property (strong, nonatomic) NSString *patientBloodTypeString;
@property (strong, nonatomic) NSString *patientClinicalConditionsString;
@property (strong, nonatomic) NSString *patientMedicationsString;
@property (strong, nonatomic) NSString *patientAlergiesString;
@property (strong, nonatomic) NSString *patientObservationsString;
@property (strong, nonatomic) NSString *patientWeightString;
@property (strong, nonatomic) NSString *patientHeightString;
@property (strong, nonatomic) NSString *patientEmergencyContactString;
@property (strong, nonatomic) NSDate *patientCreatedAtString;
@property (strong, nonatomic) NSData *patientPhotoData;

@end
