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
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"
#import "APMyAnnotation.h"
@interface APMapViewPlacesViewController : UIViewController
{
     MKMapView * mapView ;
   // @property (nonatomic, retain) MKMapView *map;

    
}
@property(nonatomic,retain) NSMutableArray *mapData;
@end
