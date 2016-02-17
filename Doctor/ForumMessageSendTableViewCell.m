#import "ForumMessageSendTableViewCell.h"

@implementation ForumMessageSendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)tappedSendButton:(id)sender{
    if(![self.sendMessageTextField.text isEqualToString:@""]){
        if ([self.delegate respondsToSelector:@selector(didTappedSendButtom:)]) {
            [self.delegate didTappedSendButtom:self.sendMessageTextField.text];
            self.sendMessageTextField.text = @"";
        }
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"O corpo da mensagem está vazio." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
