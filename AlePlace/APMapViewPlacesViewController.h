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
#import "APCity.h"
#import "MapAnnotation.h"
#import "APMyAnnotation.h"
@interface APMapViewPlacesViewController : UIViewController<CLLocationManagerDelegate,GMSMapViewDelegate>
{
    
     GMSMapView * mapView ;
    UIImage * markerImg;
   // id<GMSMarker> myMarker;

    
}
@property(nonatomic,retain) NSMutableArray *mapData;
@end
