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
@interface APShowFullMapViewController : UIViewController

@property(nonatomic,strong) APStadium *stadium;
@property(nonatomic,strong) APPlace *place;

@end
