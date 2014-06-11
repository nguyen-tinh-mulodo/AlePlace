//
//  APShowFullMapViewController.m
//  AlePlace
//
//  Created by Apple on 6/8/14.
//
//

#import "APShowFullMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "FMConstants.h"
#import "FMUtils.h"

@interface APShowFullMapViewController ()
{
    GMSMapView *mapView_ ;
}
@end

@implementation APShowFullMapViewController
@synthesize stadium,place,locationManager;
UIImage *markerImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    place =[[APPlace alloc] init];
    stadium=[[APStadium alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kAleViewController object:self userInfo:@{kNameView:@"APShowFullMapViewController"}];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeView) name:kRemoveAPShowFullMapViewController object:nil];
    [self loadData];
   
}
// get current location

- (NSString *)deviceLocation {
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    return theLocation;

}


-(void)loadData{
    float lat,longt;
    NSString * _titlestr;
    NSString *_snip;
  if(place.latitude)
       {
        lat=place.latitude;
        longt=place.longitude;
        _titlestr = place.nameplace;
          _snip = place.city;
       }
    else
    {
        lat=stadium.latitude;
        longt=stadium.longitude;
        _titlestr = stadium.nameStadium;
        _snip = stadium.city;
    }

    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat
                                                            longitude:longt
                                                                 zoom:10];
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
        markerImg=[FMUtils imageWithImage:[UIImage imageNamed:@"stadium_map"] scaledToSize:CGSizeMake(50, 50)];
    mapView_ = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView_.myLocationEnabled = YES;
    [self.locationManager startUpdatingLocation];

    self.view = mapView_;
    // Creates a marker in the center of the map.

    GMSMarker *myMarker = [[GMSMarker alloc] init];
    myMarker.position = CLLocationCoordinate2DMake(mapView_.myLocation.coordinate.latitude, mapView_.myLocation.coordinate.longitude);
    myMarker.title = @"You are here";
    myMarker.icon=markerImg;
    bounds = [bounds includingCoordinate:myMarker.position];

    GMSMarker *marker = [[GMSMarker alloc] init];

    
    
        marker.position = CLLocationCoordinate2DMake(lat, longt);
        marker.title = _titlestr;
        marker.snippet = _snip;
        marker.icon=markerImg;

 
    bounds = [bounds includingCoordinate:marker.position];

    marker.map = mapView_;
    [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];
    
    
    GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:CLLocationCoordinate2DMake(mapView_.myLocation.coordinate.latitude, mapView_.myLocation.coordinate.longitude)];
    [path addCoordinate:CLLocationCoordinate2DMake(lat, longt)];
    
    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
    rectangle.strokeWidth = 2.f;
    rectangle.map = mapView_;

}
-(void)removeView{
    [self.view removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
