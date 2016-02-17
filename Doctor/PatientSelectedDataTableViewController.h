#import <UIKit/UIKit.h>
#import "Patient.h"

@protocol PatientSelectedDataTableViewControllerDelegate <NSObject>

- (void) askedForRefresh:(Patient *)patientUpdated;

@end

@interface PatientSelectedDataTableViewController : UITableViewController

@property (strong, nonatomic) Patient* patient;
@property (nonatomic, strong) id <PatientSelectedDataTableViewControllerDelegate> delegate;

@end
