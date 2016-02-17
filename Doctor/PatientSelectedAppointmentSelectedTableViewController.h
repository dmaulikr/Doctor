#import <UIKit/UIKit.h>
#import "Patient.h"
#import "Appointment.h"

@interface PatientSelectedAppointmentSelectedTableViewController : UITableViewController

@property (strong, nonatomic) Patient* patient;
@property (strong, nonatomic) Appointment* appointment;

@end
