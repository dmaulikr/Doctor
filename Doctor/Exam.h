#import <Foundation/Foundation.h>
#import "Doctor.h"
#import "Patient.h"

@interface Exam : NSObject

@property (strong, nonatomic) NSData* examPhoto;
@property (strong, nonatomic) NSMutableArray* examVersionHistory;
@property (strong, nonatomic) NSDate* examUpdatedAt;
@property (strong, nonatomic) NSDate* examCreatedAt;
@property (strong, nonatomic) NSString* examObjectId;
@property (strong, nonatomic) Doctor* examApplicant;
@property (strong, nonatomic) Patient* examPatient;

@property (strong, nonatomic) NSString* examTypeString;
@property (strong, nonatomic) NSString* examDescriptionString;
@property (strong, nonatomic) NSData* photoOneData;
@property (strong, nonatomic) NSData* photoTwoData;
@property (strong, nonatomic) NSData* photoThirdData;
@property (strong, nonatomic) NSString* patientEnvoledString;
@property (strong, nonatomic) NSString* doctorEnvolvedString;
@property (strong, nonatomic) NSString* doctorEnvolvedNameString;
@property (strong, nonatomic) NSString* examProtocolString;
@property (strong, nonatomic) NSString* examInsuranceString;
@property (strong, nonatomic) NSString* examDateString;

@end
