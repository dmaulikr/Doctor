#import "ExamChooseSpecialtyTableViewController.h"

@interface ExamChooseSpecialtyTableViewController (){
    NSMutableArray* specialtyArray;
}

@end

@implementation ExamChooseSpecialtyTableViewController

- (void)viewDidLoad {
        [super viewDidLoad];
        specialtyArray = [[NSMutableArray alloc] initWithObjects:
                          @"Acupuntura",
                          @"Alergologia",
                          @"Angiologia",
                          @"Cardiologia",
                          @"Cirurgia",
                          @"Dermatologia",
                          @"Endocrinologia",
                          @"Fisiatria",
                          @"Fonoaudiologia",
                          @"Geriatria",
                          @"Ginecologia",
                          @"Hematologia",
                          @"Mastologia",
                          @"Neurologia",
                          @"Odontologia",
                          @"Oftalmologia",
                          @"Oncologia",
                          @"Pneumologia",
                          @"Psicologia",
                          @"Psiquiatria",
                          @"Radiologia",
                          @"Urologia", nil];
        
        self.tableView.tableFooterView = [UIView new];
    }
    
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return specialtyArray.count;
    }
    
    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        if ([self.delegate respondsToSelector:@selector(didMakeSelectionSpecialty:)]) {
            [self.delegate didMakeSelectionSpecialty:specialtyArray[indexPath.row]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *specialtyCellID = @"specialtyCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:specialtyCellID];
        
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:specialtyCellID];
        }
        cell.textLabel.text = specialtyArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    
@end
