//
//  APDetailPlaceViewController.h
//  AlePlace
//
//  Created by VinhPhuc on 6/11/14.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "APPlace.h"
@interface APDetailPlaceViewController : UIViewController
@property(nonatomic,strong) APPlace *place;
@property(nonatomic,weak) IBOutlet UIView *map;
@property(nonatomic,weak) IBOutlet UIView *viewContaintImaves;
@property(nonatomic,weak) IBOutlet UIImageView *imageDetail;
@property(nonatomic,weak) IBOutlet UILabel *titleDetail;
@property(nonatomic,weak) IBOutlet UILabel *description;
@property(nonatomic,weak) IBOutlet UILabel *address;
@property(nonatomic,weak) IBOutlet UILabel *hours;
@property(nonatomic,weak) IBOutlet UILabel *price;
@property(nonatomic,weak) IBOutlet UILabel *phone;

@property(nonatomic,weak) IBOutlet UIWebView *webView;
@property(nonatomic,weak) IBOutlet UIButton *showFull;
@property(nonatomic,weak) IBOutlet UIButton *zoomMax;
@property(nonatomic,weak) IBOutlet UIButton *zoomMin;
@property(nonatomic,weak) IBOutlet UIScrollView *scrollStadium;
-(IBAction)showFullMap:(id)sender;
@end