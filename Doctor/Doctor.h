#import <Foundation/Foundation.h>

@interface Doctor : NSObject

@property (strong, nonatomic) NSString *doctorNameString;
@property (strong, nonatomic) NSString *doctorUsernameString;
@property (strong, nonatomic) NSString *doctorPasswordString;
@property (strong, nonatomic) NSString *doctorCRMString;
@property (strong, nonatomic) NSString *doctorEmailString;
@property (strong, nonatomic) NSString *doctorContactString;
@property (strong, nonatomic) NSString *doctorAddressString;
@property (strong, nonatomic) NSMutableArray *doctorPatientsArray;
@property (strong, nonatomic) NSString *doctorObjectId;
@property (strong, nonatomic) NSData *doctorPhotoData;
@property (strong, nonatomic) NSMutableArray *favTopicsArray;
@property (strong, nonatomic) NSMutableArray *sawTopicsArray;
@property (strong, nonatomic) NSMutableArray *doctorSpecialtiesArray;
@property (strong, nonatomic) NSMutableArray *doctorHealthCareArray;
@property (assign, nonatomic) BOOL isFirstTime;

@end
