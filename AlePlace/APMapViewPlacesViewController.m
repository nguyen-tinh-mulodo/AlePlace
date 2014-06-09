//
//  APMapViewPlacesViewController.m
//  AlePlace
//
//  Created by VinhPhuc on 6/9/14.
//
//

#import "APMapViewPlacesViewController.h"

@interface APMapViewPlacesViewController ()
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
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:51.5
                                                            longitude:-0.127
                                                                 zoom:10];
    mapView_ = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(51.5, -0.127);
    GMSMarker *london = [GMSMarker markerWithPosition:position];
    london.title = @"London";
    london.icon = [UIImage imageNamed:@"default_marker"];
    london.map = mapView_;
    
  

    // Do any additional setup after loading the view from its nib.
}

-(void) showMultiAnonation:(NSMutableArray*) yourLongitudeArray latitudeArr:(NSMutableArray*)yourLatitudeArray
{
    for ( int i=0; i<[yourLongitudeArray count]; i++)
    {
        CLLocationCoordinate2D coord;
        
        coord.latitude=[[NSString stringWithFormat:@"%@",[yourLatitudeArray objectAtIndex:i]] floatValue];
        coord.longitude=[[NSString stringWithFormat:@"%@",
                          [yourLongitudeArray objectAtIndex:i]] floatValue];
//        MKCoordinateRegion region1;
//        region1.center=coord;
//        region1.span.longitudeDelta=20 ;
//        region1.span.latitudeDelta=20;
//        [mapView_ setRegion:region1 animated:YES];
//        
//        NSString *titleStr =[namesArr objectAtIndex:i] ;
//        // NSLog(@"title is:%@",titleStr);
//        
//        MyAnnotation*  annotObj =[[MyAnnotation alloc]initWithCoordinate:coord title:titleStr];
//        [mapview addAnnotation:annotObj];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
