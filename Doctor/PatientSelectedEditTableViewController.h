#import <UIKit/UIKit.h>
#import "Patient.h"

@protocol PatientSelectedEditTableViewControllerDelegate <NSObject>

- (void) askedForRefresh:(Patient *)patientUpdated;

@end
@interface PatientSelectedEditTableViewController : UITableViewController

@property (strong, nonatomic) Patient* patient;
@property (strong, nonatomic) id <PatientSelectedEditTableViewControllerDelegate> delegate;

@end
