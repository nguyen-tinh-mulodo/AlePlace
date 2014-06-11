//
//  APPlaceDataListViewController.h
//  AlePlace
//
//  Created by Apple on 6/11/14.
//
//

#import <UIKit/UIKit.h>
#import "APStadiumTableViewCell.h"
@interface APPlaceDataListViewController : UIViewController<APStadiumTableViewCellDelegate>
@property(nonatomic,weak)IBOutlet UITableView *tableStadium;
@property(nonatomic,retain)IBOutlet NSString *city_id;
@property(nonatomic,retain)IBOutlet NSString *catagoryId;
@end
