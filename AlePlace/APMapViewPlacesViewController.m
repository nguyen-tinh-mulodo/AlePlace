//
//  APMapViewPlacesViewController.m
//  AlePlace
//
//  Created by VinhPhuc on 6/9/14.
//
//

#import "APMapViewPlacesViewController.h"
#import "APCallAPI.h"
#import "APStadium.h"


@interface APMapViewPlacesViewController (){
    NSMutableArray *listStadiums;
    NSInteger page;
    NSMutableDictionary *dictionary;
}
@end

@implementation APMapViewPlacesViewController
@synthesize mapData;
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
    //[self showMultiAnonation:mapData];
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:51.5
//                                                            longitude:-0.127
//                                                                 zoom:10];
//    mapView_ = [GMSMapView mapWithFrame:self.view.frame camera:camera];
//    mapView_.myLocationEnabled = YES;
//    self.view = mapView_;
//    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(51.5, -0.127);
//    GMSMarker *london = [GMSMarker markerWithPosition:position];
//    london.title = @"London";
//    london.icon = [UIImage imageNamed:@"default_marker"];
//    london.map = mapView_;
    
  

    // Do any additional setup after loading the view from its nib.
}
-(void)callAPIGetStadium{
    dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@"json" forKey:@"format"];
    [dictionary setValue:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [dictionary setValue:@"5d7299e5d3ea2698b9ef43527eae374e1ce439da" forKey:@"esapikey"];
    [APCallAPI getStadiums:^(NSArray *listEvent, NSObject *error) {
        listStadiums = [NSMutableArray arrayWithArray:listEvent];
        [self showMultiAnonation:listStadiums];
    } parameters:dictionary didFail:^(NSObject *error) {
    }];
    
}
-(void) showMultiAnonation:(NSMutableArray*) listData{
    APStadium * stadium;
    for ( int i=0; i<[listData count]; i++)
    {
        stadium =[listData objectAtIndex:i];
      
        CLLocationCoordinate2D coord;
        
        coord.latitude=stadium.latitude;
        coord.longitude=stadium.longitude;
        MKCoordinateRegion region1;
        region1.center=coord;
        region1.span.longitudeDelta=20 ;
        region1.span.latitudeDelta=20;
        [mapView setRegion:region1 animated:YES];
        
        NSString *titleStr =stadium.nameStadium ;
        // NSLog(@"title is:%@",titleStr);
        
        MyAnnotation*  annotObj =[[MyAnnotation alloc]initWithCoordinate:coord title:titleStr];
        [mapView addAnnotation:annotObj];
      

        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
