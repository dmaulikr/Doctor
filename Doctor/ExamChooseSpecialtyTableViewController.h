#import <UIKit/UIKit.h>

@protocol ExamChooseSpecialtyTableViewControllerDelegate <NSObject>
- (void)didMakeSelectionSpecialty:(NSString *)specialtySelected;
@end

@interface ExamChooseSpecialtyTableViewController : UITableViewController
@property (nonatomic, weak) id<ExamChooseSpecialtyTableViewControllerDelegate> delegate;

@end
