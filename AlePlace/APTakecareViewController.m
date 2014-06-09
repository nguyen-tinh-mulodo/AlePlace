//
//  APTakecareViewController.m
//  AlePlace
//
//  Created by Apple on 6/7/14.
//
//

#import "APTakecareViewController.h"
#import "APAleViewCellBt.h"
#import "APAleViewCell.h"
@interface APTakecareViewController ()

@end

@implementation APTakecareViewController
@synthesize taceCareTable;
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
    [self.taceCareTable setAllowsSelection:NO];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Rotate View Support
- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
}
- (NSUInteger)supportedInterfaceOrientations
{
    //return orientations you want to support
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortraitUpsideDown);
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    /* switch (toInterfaceOrientation) {
     case UIInterfaceOrientationPortrait: {
     NSLog(@"Portrait");
     [self layout:[FMUtils getMainView].frame.size.width h:[FMUtils getMainView].frame.size.height];
     self.aleScroll.contentSize = CGSizeMake([FMUtils getMainView].frame.size.width,[FMUtils getMainView].frame.size.height+20);
     break;
     }
     
     case UIInterfaceOrientationLandscapeLeft: {
     NSLog(@"Landscape Left");
     [self layout:[FMUtils getMainView].frame.size.height h:[FMUtils getMainView].frame.size.width];
     self.aleScroll.contentSize = CGSizeMake([FMUtils getMainView].frame.size.height,[FMUtils getMainView].frame.size.width+50);
     
     
     break;
     }
     
     case UIInterfaceOrientationLandscapeRight: {
     NSLog(@"Landscape Right");
     [self layout:[FMUtils getMainView].frame.size.width h:[FMUtils getMainView].frame.size.width];
     self.aleScroll.contentSize = CGSizeMake([FMUtils getMainView].frame.size.height,[FMUtils getMainView].frame.size.width+50);
     
     break;
     }
     
     default:
     break;
     }
     */
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"APEventTableViewCell";
        APAleViewCell *cell = nil;
        cell = (APAleViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            // cell = [[APEventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"APAleViewCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects objectAtIndex:0];
        }
        cell.banner.image = [UIImage imageNamed:@"bannerTake.png"];
        cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        return cell;
    }else{
        static NSString *CellIdentifier = @"APAleViewCellBt";
        APAleViewCellBt *cell = nil;
        cell = (APAleViewCellBt*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            // cell = [[APEventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"APAleViewCellBt" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects objectAtIndex:0];
            cell.delegate = self;
        }
        cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        if (indexPath.row == 1) {
            cell.stadiumBt.tag = 100;
            cell.teamBt.tag = 200;
            [cell.stadiumBt setImage:[UIImage imageNamed:@"Police.png"] forState:UIControlStateNormal];
            [cell.teamBt setImage:[UIImage imageNamed:@"hospital.png"] forState:UIControlStateNormal];
        }
        if (indexPath.row == 2) {
            cell.stadiumBt.tag = 300;
            cell.teamBt.tag = 400;
            [cell.stadiumBt setImage:[UIImage imageNamed:@"transport.png"] forState:UIControlStateNormal];
            [cell.teamBt setImage:[UIImage imageNamed:@"maps.png"] forState:UIControlStateNormal];
        }
        return cell;
    }
    
    
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
#pragma APAleViewCellBtDelegate
- (void)showStadium{
    
}
- (void)showTerm{
    
}
-(void)showSchedule{
    
}
-(void)showResult{
    
}
@end
