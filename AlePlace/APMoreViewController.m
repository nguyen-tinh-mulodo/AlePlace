//
//  APMoreViewController.m
//  AlePlace
//
//  Created by Apple on 6/9/14.
//
//

#import "APMoreViewController.h"
#import "FMConstants.h"
#import "FMUtils.h"
@interface APMoreViewController ()
@end

@implementation APMoreViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(popView) name:kRevovemore object:nil];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [FMUtils backArrowButtonWithTarget:self action:@selector(popViewControllerAnimated)];
}
-(void)popViewControllerAnimated{
    
}
-(void)popView{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
