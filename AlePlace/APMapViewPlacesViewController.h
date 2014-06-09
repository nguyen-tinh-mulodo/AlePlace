//
//  APMapViewPlacesViewController.h
//  AlePlace
//
//  Created by VinhPhuc on 6/9/14.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "FMConstants.h"

@interface APMapViewPlacesViewController : UIViewController
{
    GMSMapView *mapView_ ;
    
}
@property(nonatomic,retain) NSMutableArray *mapData;
@end
