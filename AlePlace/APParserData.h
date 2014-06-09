//
//  APParserData.h
//  AlePlace
//
//  Created by Apple on 6/5/14.
//
//

#import <Foundation/Foundation.h>

@interface APParserData : NSObject
+ (NSArray *)parseJSONtoArrayOfProduct:(id)responseObject;
+ (NSArray *)parseJSONtoArrayOfEventDetail:(id)responseObject;
+ (NSArray *)parseJSONtoArrayOfStadiums:(id)responseObject;
@end
