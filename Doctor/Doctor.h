#import <Foundation/Foundation.h>

@interface Doctor : NSObject

//Sign Up
@property (strong, nonatomic) NSString* doctorNameString;
@property (strong, nonatomic) NSString* doctorUsernameString;
@property (strong, nonatomic) NSString* doctorPasswordString;
@property (strong, nonatomic) NSString* doctorCRMString;
@property (strong, nonatomic) NSString* doctorEmailString;
@property (strong, nonatomic) NSString* doctorContactString;


@property (strong, nonatomic) NSString* doctorAddressString;
//In test
@property (strong, nonatomic) NSMutableArray* doctorPatientsArray;
@property (strong, nonatomic) NSString* doctorObjectId;
@property (strong,nonatomic) NSData* doctorPhotoData;


@property (nonatomic, strong) NSMutableArray *favTopicsArray;
@property (nonatomic, strong) NSMutableArray *sawTopicsArray;


@property (nonatomic, strong) NSMutableArray* doctorSpecialtiesArray;
@property (nonatomic, strong) NSMutableArray* doctorHealthCareArray;

@property (nonatomic) BOOL isFirstTime;

@end
