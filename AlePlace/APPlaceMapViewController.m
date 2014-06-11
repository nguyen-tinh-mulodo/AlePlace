//
//  APPlaceMapViewController.m
//  AlePlace
//
//  Created by VinhPhuc on 6/10/14.
//
//

#import "APPlaceMapViewController.h"

#import "APCallAPI.h"
#import "APStadium.h"
#import "FMUtils.h"


@interface APPlaceMapViewController (){
    NSInteger page;
    NSMutableDictionary *dictionary;
    
}
@end

@implementation APPlaceMapViewController
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
    mapData =[[NSMutableArray alloc] init];
    [self callAPIGetStadium];
    
    
    markerImg=[FMUtils imageWithImage:[UIImage imageNamed:@"Eat&-drink"] scaledToSize:CGSizeMake(40, 40)];
    // Do any additional setup after loading the view from its nib.
}
-(void)callAPIGetStadium{
    dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@"json" forKey:@"format"];
    [dictionary setValue:[NSString stringWithFormat:@"%d",5] forKey:@"page"];
    [dictionary setValue:@"5d7299e5d3ea2698b9ef43527eae374e1ce439da" forKey:@"esapikey"];
    [APCallAPI getStadiums:^(NSArray *listEvent, NSObject *error) {
        mapData = [NSMutableArray arrayWithArray:listEvent];
        [self showMultiAnonation:mapData];
        
    } parameters:dictionary didFail:^(NSObject *error) {
    }];
    
}
-(void) showMultiAnonation:(NSMutableArray*) listData{
    APStadium * stadium=[[APStadium alloc] init];
    stadium =[listData objectAtIndex:2];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:0
                                                            longitude:0
                                                                 zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.delegate = self;
    
    mapView.myLocationEnabled = YES;
    
    mapView.settings.compassButton = YES;
    mapView.settings.myLocationButton = YES;
    self.view=mapView;
    
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    
    for ( int i=0; i<[listData count]; i++)
    {
        stadium =[listData objectAtIndex:i];
        
        
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(stadium.latitude,stadium.longitude);
        CLLocationDegrees degrees = 0;
        GMSMarker *gmarker = [GMSMarker markerWithPosition:position];
        gmarker.appearAnimation=kGMSMarkerAnimationPop;
        gmarker.groundAnchor = CGPointMake(0.5, 0.5);
        gmarker.title=stadium.nameStadium;
        gmarker.snippet = stadium.city;
        bounds = [bounds includingCoordinate:gmarker.position];
        gmarker.icon=markerImg;
        gmarker.rotation = degrees;
        gmarker.map = mapView;
        
        
    }
    [mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(buttonClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    
    [self.view addSubview:button];
    
}
-(void)mapView:(GMSMapView *)mapView
didTapInfoWindowOfMarker:(GMSMarker*)marker
{
    NSLog(@"MARKER..... %@",marker);
    
    
}

- (BOOL) mapView:	(GMSMapView *) 	mapView didTapMarker:(GMSMarker *) 	marker
{
    NSLog(@"MARKER..... %@",marker);
    return TRUE;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
