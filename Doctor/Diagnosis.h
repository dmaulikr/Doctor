#import <Foundation/Foundation.h>
#import "Doctor.h"
#import "Patient.h"

@interface Diagnosis : NSObject

@property (strong, nonatomic) NSDate* diagnosisConfirmedAt;
@property (strong, nonatomic) NSNumber* diagnosisStatus;
@property (strong, nonatomic) NSString* diagnosisDescription;
@property (strong, nonatomic) NSDate* diagnosisCreatedAt;
@property (strong, nonatomic) NSString* diagnosisObjectId;
@property (strong, nonatomic) NSMutableArray* diagnosisVersionHistory;
@property (strong, nonatomic) NSDate* diagnosisUpdatedAt;
@property (strong, nonatomic) Doctor* diagnosisAuthor;
@property (strong, nonatomic) Patient* diagnosisPatient;

@end
