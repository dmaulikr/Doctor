#import <UIKit/UIKit.h>
#import "Patient.h"
#import "Exam.h"

@protocol PatientNewExamTableViewControllerDelegate <NSObject>
- (void) newExamWasCreated;
@end

@interface PatientNewExamTableViewController : UITableViewController

@property (strong, nonatomic) Patient* patient;
@property (nonatomic, strong) id <PatientNewExamTableViewControllerDelegate> delegate;

@end
