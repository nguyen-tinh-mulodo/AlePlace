//
//  APPlaceDataListTableViewController.h
//  AlePlace
//
//  Created by VinhPhuc on 6/10/14.
//
//

#import <UIKit/UIKit.h>
#import "APStadiumTableViewCell.h"
@interface APPlaceDataListTableViewController : UITableViewController<APStadiumTableViewCellDelegate>
@property(nonatomic,weak)IBOutlet UITableView *tableStadium;
@end
