//
//  TutorialViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/15/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "TutorialViewController.h"


NSString *const kFirstTextViewText = @"Aqui você tem acesso aos prontuários de seus pacientes. \n\nAcesse histórico de condições clínicas, tratamentos, consultas e exames de maneira prática e rápida.";

NSString *const kSecondTextViewText = @"Tenha acesso a uma ampla biblioteca de medicamentos e princípios ativos na palma da sua mão.";

NSString *const kThirdTextViewText = @"Precisa de ajuda em algum caso? \n\nPoste sua dúvida e obtenha feedback de colegas das mais diversas áreas de sáude.";

NSString *const kFourthTextViewText = @"Complete seu perfil e seja encontrado por pacientes cadastrados no aplicativo.";

NSString *const kFifthTextViewText = @"Para encerrar sua seção é só clicar aqui.";

@interface TutorialViewController (){
    int i;
}

@property (nonatomic, weak) IBOutlet UILabel* patientsLabel;
@property (nonatomic, weak) IBOutlet UILabel* medicationsLabel;
@property (nonatomic, weak) IBOutlet UILabel* forumLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsLabel;
@property (nonatomic, weak) IBOutlet UILabel* leaveLabel;
@property (nonatomic, weak) IBOutlet UITextView* instructionsTextView;
@property (nonatomic, weak) IBOutlet UIImageView* sectionImageView;

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    i = 0;
    [self setupScheme];
    [self setupGestureRecognizer];
}

- (void) setupScheme{
    self.patientsLabel.alpha = 1.0;
    self.medicationsLabel.alpha = 1.0;
    self.forumLabel.alpha = 1.0;
    self.settingsLabel.alpha = 1.0;
    self.leaveLabel.alpha = 1.0;
    self.instructionsTextView.alpha = 0.0;
    self.sectionImageView.alpha = 0.0;
    
    self.instructionsTextView.textColor = [UIColor whiteColor];
    self.instructionsTextView.font = [UIFont fontWithName:@"Helvetica" size:17];
}

- (void) setupGestureRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedScreen)];
    [self.view addGestureRecognizer:tap];
}

- (void) didTappedScreen{
    i++;
    switch (i) {
        case 1:
            [self performFirstAnimation];
            break;
        case 2:
            [self performSecondAnimation];
            break;
        case 3:
            [self performThirdAnimation];
            break;
        case 4:
            [self performFourthAnimation];
            break;
        case 5:
            [self performFifthAnimation];
            break;
            case 6:
            [self performSegueWithIdentifier:@"finishedTutorialSegue" sender:self];
        default:
            break;
    }
}

- (void) performFirstAnimation{
    [UIView animateWithDuration:0.7f animations:^{
        self.medicationsLabel.alpha = 0.1;
        self.forumLabel.alpha = 0.1;
        self.settingsLabel.alpha = 0.1;
        self.leaveLabel.alpha = 0.1;
        
        self.instructionsTextView.alpha = 1.0;
        self.sectionImageView.alpha = 1.0;
        
        self.instructionsTextView.text = kFirstTextViewText;
        
    } completion:^(BOOL finished) {}];
}

- (void) performSecondAnimation{
    [UIView animateWithDuration:0.7f animations:^{
        self.patientsLabel.alpha = 0.1;
        self.medicationsLabel.alpha = 1.0;
        self.forumLabel.alpha = 0.1;
        self.settingsLabel.alpha = 0.1;
        self.leaveLabel.alpha = 0.1;
        
        self.instructionsTextView.alpha = 1.0;
        self.sectionImageView.alpha = 1.0;
        
        self.instructionsTextView.text = kSecondTextViewText;
        
        self.sectionImageView.image = [UIImage imageNamed:@"icone-tutorial-medicamentos"];
        
    } completion:^(BOOL finished) {}];
}

- (void) performThirdAnimation{
    [UIView animateWithDuration:0.7f animations:^{
        self.patientsLabel.alpha = 0.1;
        self.medicationsLabel.alpha = 0.1;
        self.forumLabel.alpha = 1.0;
        self.settingsLabel.alpha = 0.1;
        self.leaveLabel.alpha = 0.1;
        
        self.instructionsTextView.alpha = 1.0;
        self.sectionImageView.alpha = 1.0;
        
        self.instructionsTextView.text = kThirdTextViewText;
        
        self.sectionImageView.image = [UIImage imageNamed:@"icone-tutorial-forum"];
        
    } completion:^(BOOL finished) {}];
}

- (void) performFourthAnimation{
    [UIView animateWithDuration:0.7f animations:^{
        self.patientsLabel.alpha = 0.1;
        self.medicationsLabel.alpha = 0.1;
        self.forumLabel.alpha = 0.1;
        self.settingsLabel.alpha = 1.0;
        self.leaveLabel.alpha = 0.1;
        
        self.instructionsTextView.alpha = 1.0;
        self.sectionImageView.alpha = 1.0;
        
        self.instructionsTextView.text = kFourthTextViewText;
        
        self.sectionImageView.image = [UIImage imageNamed:@"icone-tutorial-configuracoes"];
        
    } completion:^(BOOL finished) {}];
}

- (void) performFifthAnimation{
    [UIView animateWithDuration:0.7f animations:^{
        self.patientsLabel.alpha = 0.1;
        self.medicationsLabel.alpha = 0.1;
        self.forumLabel.alpha = 0.1;
        self.settingsLabel.alpha = 0.1;
        self.leaveLabel.alpha = 1.0;
        
        self.instructionsTextView.alpha = 1.0;
        self.sectionImageView.alpha = 1.0;
        
        self.instructionsTextView.text = kFifthTextViewText;
        
        self.sectionImageView.image = [UIImage imageNamed:@"icone-tutorial-sair"];
        
    } completion:^(BOOL finished) {}];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    segue.destinationViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

@end
