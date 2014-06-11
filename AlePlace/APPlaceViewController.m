//
//  APPlaceViewController.m
//  AlePlace
//
//  Created by Apple on 6/7/14.
//
//

#import "APPlaceViewController.h"
#import "APPlaceTableViewCell.h"
#import "APPlaceMapViewController.h"
#import "APPlaceDataListTableViewController.h"
@interface APPlaceViewController ()
{
    APPlaceDataListTableViewController *dataView;
}
@end

@implementation APPlaceViewController
@synthesize tableViewPlace;
APPlaceMapViewController *mapView;
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
    [self.tableViewPlace setEditing:NO];
    [self.tableViewPlace setAllowsSelection:NO];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
        static NSString *CellIdentifier = @"APAleViewCellBt";
        APPlaceTableViewCell *cell = nil;
        cell = (APPlaceTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            // cell = [[APEventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"APPlaceTableViewCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects objectAtIndex:0];
            cell.delegate = self;
        }
        cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        if (indexPath.row == 0) {
            cell.bt1.tag = 100;
            cell.bt2.tag = 200;
            [cell.bt1 setImage:[UIImage imageNamed:@"eat.png"] forState:UIControlStateNormal];
            [cell.bt2 setImage:[UIImage imageNamed:@"do.png"] forState:UIControlStateNormal];
        }
        if (indexPath.row == 1) {
            cell.bt1.tag = 300;
            cell.bt2.tag = 400;
            [cell.bt1 setImage:[UIImage imageNamed:@"see.png"] forState:UIControlStateNormal];
            [cell.bt2 setImage:[UIImage imageNamed:@"restaurant.jpg"] forState:UIControlStateNormal];
        }
        if (indexPath.row == 2) {
            cell.bt1.tag = 500;
            cell.bt2.tag = 600;
            [cell.bt1 setImage:[UIImage imageNamed:@"tour.png"] forState:UIControlStateNormal];
            [cell.bt2 setImage:[UIImage imageNamed:@"shopping.jpg"] forState:UIControlStateNormal];
        }
        return cell;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(void)callAPIGet{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@"json" forKey:@"format"];
    [dictionary setValue:@"33" forKey:@"countryId"];
    [dictionary setValue:@"5d7299e5d3ea2698b9ef43527eae374e1ce439da" forKey:@"esapikey"];
    [APCallAPI getCities:^(NSArray *listPlaces, NSObject *error) {
        mapDataList = [NSMutableArray arrayWithArray:listPlaces];
       // [self.tableStadium reloadData];
    } parameters:dictionary didFail:^(NSObject *error) {
    }];
    
}


- (void)eat{
    [self showMap];
    
    
}
- (void)do_do{
    
}
-(void)see{
    
}
-(void)restaurant{
    
}
-(void)tour{
    
}
-(void)shopping{
    
}

-(void)showMap{
    /*
    APPlaceMapViewController *mapView = [[APPlaceMapViewController alloc] init];
    mapView.view.frame = self.view.frame;
    [self.view addSubview:mapView.view];
     */
    dataView = [[APPlaceDataListTableViewController alloc] initWithNibName:@"APPlaceDataListTableViewController" bundle:nil];
        [self.view addSubview:dataView.view];
    
}
@end
