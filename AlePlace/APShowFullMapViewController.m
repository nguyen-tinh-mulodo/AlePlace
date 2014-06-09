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
@interface APShowFullMapViewController ()
{
    GMSMapView *mapView_ ;
}
@end

@implementation APShowFullMapViewController
@synthesize stadium;
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
    [[NSNotificationCenter defaultCenter]postNotificationName:kAleViewController object:self userInfo:@{kNameView:@"APShowFullMapViewController"}];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeView) name:kRemoveAPShowFullMapViewController object:nil];
    [self loadData];
   
}
-(void)loadData{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:stadium.latitude
                                                            longitude:stadium.longitude
                                                                 zoom:10];
    mapView_ = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(stadium.latitude, stadium.longitude);
    marker.title = stadium.nameStadium;
    marker.snippet = stadium.country;
    marker.map = mapView_;
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
