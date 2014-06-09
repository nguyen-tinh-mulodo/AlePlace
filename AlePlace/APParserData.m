//
//  APParserData.m
//  AlePlace
//
//  Created by Apple on 6/5/14.
//
//

#import "APParserData.h"
#import "APEvent.h"
#import "APStadium.h"
@implementation APParserData
+ (NSArray *)parseJSONtoArrayOfProduct:(id)responseObject {
    //NSArray *postsFromResponse =[[responseObject objectForKey:@"xml"] objectForKey:@"item"];
    NSMutableArray *mutableProducts = [NSMutableArray arrayWithCapacity:[responseObject count]];
    for (NSDictionary *attributes in responseObject) {
        APEvent *event = [[APEvent alloc] initWithAttributes:attributes];
        [mutableProducts addObject:event];
    }
    return mutableProducts;
}
+ (NSArray *)parseJSONtoArrayOfStadiums:(id)responseObject {
    //NSArray *postsFromResponse =[[responseObject objectForKey:@"xml"] objectForKey:@"item"];
    NSMutableArray *mutableProducts = [NSMutableArray arrayWithCapacity:[responseObject count]];
    for (NSDictionary *attributes in responseObject) {
        APStadium *stadium = [[APStadium alloc] initWithAttributes:attributes];
        [mutableProducts addObject:stadium];
    }
    return mutableProducts;
}
+ (NSArray *)parseJSONtoArrayOfEventDetail:(id)responseObject {
    //NSArray *postsFromResponse =[[responseObject objectForKey:@"xml"] objectForKey:@"item"];
    NSMutableArray *mutableProducts = [[NSMutableArray alloc] init];
        APEvent *event = [[APEvent alloc] initWithAttributes:responseObject];
        [mutableProducts addObject:event];
    return mutableProducts;
}
@end
