//
//  APHeader.m
//  AlePlace
//
//  Created by Apple on 6/10/14.
//
//

#import "APHeader.h"

@implementation APHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"testView" owner:self options:nil];
       // self =  [nib objectAtIndex:0]; // or if it exists, (MCQView *)[nib objectAtIndex:0];
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)backBtnClick:(id)sender {
    
}
@end
