#import "ForumTableViewController.h"
#import "MFSideMenu.h"
#import "ForumTableViewCell.h"
#import "Envio.h"
#import "SWTableViewCell.h"
#import "ForumNewTopicTableViewController.h"
#import "ForumSeeTopicTableViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@interface ForumTableViewController () <UISearchBarDelegate> {
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView *spinner;
    ForumTopic* topicClicked;
}

@property (nonatomic, strong) NSMutableArray* forumTopicsArray;
@property (strong, nonatomic) IBOutlet UISearchBar *forumSearchBar;
@property (strong, nonatomic) NSMutableArray* filteredForumsArray;

@end

@implementation ForumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewDataArray = [[NSMutableArray alloc] init];
    self.tableView.tableFooterView = [UIView new];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.doctor = appDelegate.doctor;
    [self setupSearch];
}

- (void) viewWillAppear:(BOOL)animated{
    [self setupDataSource];
}
- (void) viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

-(IBAction)didTappedCreateTopicBarButton:(UIBarButtonItem *)sender{
    [self performSegueWithIdentifier:@"clickedToCreateTopicSegueId" sender:self];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    topicClicked = [[ForumTopic alloc] init];
    topicClicked = tableViewDataArray[indexPath.row];
    [self performSegueWithIdentifier:@"clickedToSeeTopicSegueId" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"clickedToSeeTopicSegueId"]) {
        ForumSeeTopicTableViewController* seeTopic = segue.destinationViewController;
        [seeTopic setDoctor:self.doctor];
        [seeTopic setForumTopic:topicClicked];
    }
    else if ([segue.identifier isEqualToString:@"clickedToCreateTopicSegueId"]){
        ForumNewTopicTableViewController* newTopic = segue.destinationViewController;
        [newTopic setDoctor:self.doctor];
    }
}

#pragma mark - Setups
- (void) setupDataSource{
    [self setupLoadingAnimation];
    Envio *envio = [[Envio alloc] init];
    self.forumTopicsArray = [[NSMutableArray alloc] init];
    
    [envio fetchAllForumTopics:^void(NSMutableArray* forumTopicsArray){
        if (forumTopicsArray){
            self.forumTopicsArray = forumTopicsArray;
            tableViewDataArray = self.forumTopicsArray;
            
            [SVProgressHUD dismiss];
            [self.tableView reloadData];
        }else{
            NSLog(@"Erro - setupForumTopics block");
        }
    }];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegates
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* ForumCellID = @"ForumTableViewCellID";
    
    ForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ForumCellID];
    if (cell==nil) {
        cell = [[ForumTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ForumCellID];
    }
    
    ForumTopic* forumTopic = [[ForumTopic alloc] init];
    forumTopic = tableViewDataArray[indexPath.row];
    
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    
    cell.topicDate.text = forumTopic.topicForumUpdatedAt;
    cell.topicOwner.text = [NSString stringWithFormat:@"%@ - %@", forumTopic.topicForumOwner, forumTopic.topicForumOwnerCRM];
    cell.topicSubject.text = forumTopic.topicForumSubject;
    cell.topicSinopse.text = forumTopic.topicForumSinopse;
    cell.topicObjectId = forumTopic.topicObjectId;
    
    if ([self.doctor.favTopicsArray containsObject:forumTopic.topicObjectId]) {
        cell.favImageView.image = [UIImage imageNamed:@"estrelinha-topicofavorito"];
        cell.backgroundColor = [UIColor colorWithRed:(77/255.f) green:(77/255.f) blue:(77/255.f) alpha:1];
        cell.topicOwner.textColor = [UIColor whiteColor];
        cell.topicSinopse.textColor = [UIColor whiteColor];
        cell.topicSubject.textColor = [UIColor whiteColor];
        cell.topicDate.textColor = [UIColor whiteColor];
        
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
        cell.topicOwner.textColor = [UIColor blackColor];
        cell.topicSinopse.textColor = [UIColor lightGrayColor];
        cell.topicSubject.textColor = [UIColor blackColor];
        cell.topicDate.textColor = [UIColor blackColor];
        cell.favImageView.image = [UIImage imageNamed:@""];
    }
    
    cell.nonReadImageView.image = [self.doctor.sawTopicsArray containsObject:forumTopic.topicObjectId] ? [UIImage imageNamed:@""] : [UIImage imageNamed:@"bolinha-naolido"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:(247/255.0f) green:(146/255.0f) blue:(30/255.0f) alpha:1.0] icon:[UIImage imageNamed:@"icone-favoritarpaciente"]];
    return rightUtilityButtons;
}

- (void)swipeableTableViewCell:(ForumTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    Envio* envio = [[Envio alloc] init];
    [envio setTopicAsFavourite:cell.topicObjectId :self.doctor withCompletion:^void(BOOL* finished){
        if (finished) {
            [self.tableView reloadData];
        }
    }];
    [cell hideUtilityButtonsAnimated:YES];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat fixedWidth = 200.f;
    UITextView* teste = [[UITextView alloc] init];
    ForumTopic *messageMeasure = [[ForumTopic alloc] init];
    messageMeasure = tableViewDataArray[indexPath.row];
    teste.text = messageMeasure.topicForumSinopse;
    CGSize newSize = [teste sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    newSize.height = newSize.height+80;
    NSLog(@"%f", newSize.height);
    return newSize.height;
}

- (void) setupLoadingAnimation{
//    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    spinner.center = self.view.center;
//    spinner.tag = 12;
//    [self.view addSubview:spinner];
//    [spinner startAnimating];
       [SVProgressHUD show];
}

#pragma mark - UISearchBarDelegate Methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText isEqualToString:@""]) {
        tableViewDataArray = self.forumTopicsArray;
        [searchBar resignFirstResponder];
        [self.tableView reloadData];
    }
    else{
        [self.filteredForumsArray removeAllObjects];
        for (int i = 0; i < self.forumTopicsArray.count; i++) {
            ForumTopic* forumSearching = [[ForumTopic alloc] init];
            forumSearching = self.forumTopicsArray[i];
            NSString* toCheck = [forumSearching.topicForumSubject lowercaseString];
            NSString* toCheck2 = [forumSearching.topicForumSinopse lowercaseString];
            if ([toCheck containsString:[searchText lowercaseString]] || [toCheck2 containsString:[searchText lowercaseString]]) {
                [self.filteredForumsArray addObject:forumSearching];
            }
        }
        tableViewDataArray = self.filteredForumsArray;
        [self.tableView reloadData];
    }
}

- (void) setupSearch{
    self.filteredForumsArray = [NSMutableArray arrayWithCapacity:self.forumTopicsArray.count];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

@end
