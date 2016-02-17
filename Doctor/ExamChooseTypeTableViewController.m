#import "ExamChooseTypeTableViewController.h"

@interface ExamChooseTypeTableViewController (){
    NSMutableArray* typeArray;
}

@end

@implementation ExamChooseTypeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    typeArray = [[NSMutableArray alloc] initWithObjects:
                      @"Hemograma",
                      @"Urocultura",
                      @"Colesterol",
                      @"Glicemia",
                      @"Ecocardiograma",
                      @"Eletroencefalograma",
                      @"Triglicérides",
                      @"Radiografia",
                      @"Ureia/Creatinina",
                      @"Ultrassom",
                      @"Eletrocardiograma",
                      @"Colposcopia",
                      @"Endoscopia",
                      @"Coagulograma",
                      @"Antibiograma",
                      @"Espermograma",
                      @"Neurofeedback",
                      @"Mielograma",
                      @"Magnetoencefalografia",
                      @"Laringoscopia",
                      @"Tonometria",
                      @"Nasofibroscopia", nil];
    
    self.tableView.tableFooterView = [UIView new];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return typeArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didMakeSelectionExamType:)]) {
        [self.delegate didMakeSelectionExamType:typeArray[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *typeCellID = @"typeCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:typeCellID];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:typeCellID];
    }
    cell.textLabel.text = typeArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end