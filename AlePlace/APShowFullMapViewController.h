//
//  APShowFullMapViewController.h
//  AlePlace
//
//  Created by Apple on 6/8/14.
//
//

#import <UIKit/UIKit.h>
#import "APStadium.h"
#import "APPlace.h"
#import <CoreLocation/CoreLocation.h>

@interface APShowFullMapViewController : UIViewController

@property(nonatomic,retain) APStadium *stadium;
@property(nonatomic,retain) APPlace *place;
@property(nonatomic,retain) CLLocationManager *locationManager;


@end
