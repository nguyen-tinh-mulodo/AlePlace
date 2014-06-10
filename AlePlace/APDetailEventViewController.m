//
//  APDetailEventViewController.m
//  AlePlace
//
//  Created by Apple on 6/6/14.
//
//

#import "APDetailEventViewController.h"
#import "APCallAPI.h"
#import "APEvent.h"
#import "UIImageView+AFNetworking.h"
#import "FMUtils.h"
#import "APAleViewController.h"
#import "APTakecareViewController.h"
#import "APPlaceViewController.h"
#import "APAppDelegate.h"
#import "FMConstants.h"
#import "APStadiumViewController.h"
@interface UIView (ARES)

- (void)roundCornerShadowAndBorder;

@end

@implementation UIView (ARES)

- (void)roundCornerShadowAndBorder {
    
    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:NO];
    
    [self.layer setShadowColor:[UIColor darkTextColor].CGColor];
    [self.layer setShadowOpacity:0.6];
    [self.layer setShadowOffset:CGSizeMake(1,1)];
    [self.layer setShadowRadius:0.9];
    [self.layer setShadowPath:[[UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:self.layer.cornerRadius] CGPath]];
    
    [self.layer setShouldRasterize:YES];
    [self.layer setRasterizationScale:[UIScreen mainScreen].scale];
}

@end
@interface APDetailEventViewController ()
{
    NSMutableArray *listEvents;
    NSString *flagClass;
}
@property (nonatomic,strong)APAleViewController *aleViewController;
@property (nonatomic,strong)APTakecareViewController *takecareViewController;
@property (nonatomic,strong)APPlaceViewController *placeViewController;
@end

@implementation APDetailEventViewController
@synthesize idEvent,scrollDetailEvent,startdate,enddate,description,webView,imageDetailEvent,album1,album2,album3,titleDescription,tabBarAle,tabBarItemAle,tabBarItemPlace,tabBarItemHome,tabBarItemTace,aleViewController,takecareViewController,placeViewController,btItemAle,btItemHome,btItemPlace,btItemTake;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    tabBarAle.hidden = YES;
    CGRect rect = [[UIScreen mainScreen] bounds];
     [self.scrollDetailEvent setContentSize:CGSizeMake(self.view.frame.size.width, rect.size.height)];
    [scrollDetailEvent setScrollEnabled:YES];
    [scrollDetailEvent setBackgroundColor:[UIColor clearColor]];
    NSLog(@"%f",self.scrollDetailEvent.contentSize.height);
    scrollDetailEvent.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self callAPIGetDetailEvent];
    self.navigationItem.leftBarButtonItem = [FMUtils backArrowButtonWithTarget:self action:@selector(popViewControllerAnimated)];
    // self.navigationItem.rightBarButtonItem = [FMUtils moreArrowButtonWithTarget:self action:@selector(showMoreView)];
    // Do any additional setup after loading the view from its nib.
    tabBarAle.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        [tabBarAle setBarTintColor:
         UIColorFromRGB(kMetroColorGreen)];
    }else{
        [tabBarAle setTintColor:
         UIColorFromRGB(kMetroColorGreen)];
        
    }
    [tabBarAle setSelectedItem:[tabBarAle.items objectAtIndex:3]];
    
    
    // 1000--> select
    [tabBarItemHome setTag:1000];
    [btItemHome setTag:1000];
    
    [btItemHome setSelected:YES];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setFlagView:) name:kAleViewController object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(popViewControllerAnimated) name:ktest object:nil];
    
}
- (void)setFlagView:(NSNotification *)notification {
    
   flagClass = [notification.userInfo objectForKey:@"nameView"];
}

-(void)callAPIGetDetailEvent{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@"json" forKey:@"format"];
    [dictionary setValue:[NSString stringWithFormat:@"%d",idEvent] forKey:@"id"];
    [dictionary setValue:@"5d7299e5d3ea2698b9ef43527eae374e1ce439da" forKey:@"esapikey"];
    [APCallAPI getDetailEvent:^(NSArray *listEvent, NSObject *error) {
        listEvents = [NSMutableArray arrayWithArray:listEvent];
        [self loadData:[listEvents objectAtIndex:0]];
    } parameters:dictionary didFail:^(NSObject *error) {
    }];
    
}
-(void)showMoreView{
    
}
-(void)popViewControllerAnimated{
    if ([flagClass isEqualToString:@"APAleViewController"]) {
        flagClass = @"";
        [aleViewController.view removeFromSuperview];
        return;
    }
    if ([flagClass isEqualToString:@"APStadiumViewController"]) {
        flagClass = @"APAleViewController";
        [[NSNotificationCenter defaultCenter]postNotificationName:kRemoveStadiumViewController object:self];
        return;
    }
    if ([flagClass isEqualToString:@"APDetailStadiumViewController"]) {
        flagClass = @"APStadiumViewController";
        [[NSNotificationCenter defaultCenter]postNotificationName:kRemoveStadiumDetailViewController object:self];
        return;
    }
    if ([flagClass isEqualToString:@"APShowFullMapViewController"]) {
        flagClass = @"APDetailStadiumViewController";
        [[NSNotificationCenter defaultCenter]postNotificationName:kRemoveAPShowFullMapViewController object:self];
        return;
    }
    if ([flagClass isEqualToString:@"APEcheduleViewController"]) {
        flagClass = @"APDetailStadiumViewController";
        [[NSNotificationCenter defaultCenter]postNotificationName:kRemoveAPEcheduleViewController object:self];
        return;
    }
    if ([flagClass isEqualToString:@"APEcheduleViewController"]) {
        flagClass = @"APDetailStadiumViewController";
        [[NSNotificationCenter defaultCenter]postNotificationName:kRemoveAPShowFullMapViewController object:self];
        return;
    }


    if ([flagClass isEqualToString:@"APTeamViewController"]) {
        flagClass = @"APAleViewController";
        [[NSNotificationCenter defaultCenter]postNotificationName:kRemoveAPTeamViewController object:self];
        return;
    }
    if ([flagClass isEqualToString:@"APResultViewController"]) {
        flagClass = @"APAleViewController";
        [[NSNotificationCenter defaultCenter]postNotificationName:kRemoveAPResultViewController object:self];
        return;
    }
    
    
    for (UIView *view in [self.view subviews]) {
        if (view == aleViewController.view) {
             NSLog(@"%@",self.view.subviews);
        }
        
    }
    if ([self.aleViewController.view.subviews containsObject:[APAleViewController class]]) {
        NSLog(@"%@",self.view.subviews);
    } else {
        //[[self popoverView] removeFromSuperview];
        
    }
    for(UIView *aView in self.aleViewController.view.subviews){
        if([aView isKindOfClass:[APStadiumViewController class]]){
            //YourClass found!!
             NSLog(@"%@",self.view.subviews);
        }
    }
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)loadData:(APEvent *)event{
    [self.imageDetailEvent setImageWithURL:[NSURL URLWithString:event.thumb_photoEvent] placeholderImage:nil];
    self.startdate.text = event.start_dateEvent;
    self.enddate.text = event.end_dateEvent;
    self.description.text = event.descriptionEvent;
    self.description.frame = CGRectMake(self.description.frame.origin.x,CGRectGetMaxY(self.titleDescription.frame), self.description.frame.size.width, [FMUtils heightForCell:event.descriptionEvent size:17 font:@"Helvetica" width:self.description.frame.size.width]);
    self.album1.frame = CGRectMake(self.album1.frame.origin.x,CGRectGetMaxY(self.description.frame) + 10, self.album1.frame.size.width, self.album1.frame.size.height);
    self.album2.frame = CGRectMake(self.album2.frame.origin.x,CGRectGetMaxY(self.description.frame) + 10, self.album2.frame.size.width, self.album2.frame.size.height);
    self.album3.frame = CGRectMake(self.album3.frame.origin.x,CGRectGetMaxY(self.description.frame) + 10, self.album3.frame.size.width, self.album3.frame.size.height);
    
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImageView *imageView1 = [[UIImageView alloc] init];
    UIImageView *imageView2 = [[UIImageView alloc] init];
    
    for (int i = 0; i < [event.album count]; i++) {
        if (i == 0) {
           NSLog(@"%@",[event.album objectAtIndex:0]);
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[event.album objectAtIndex:0]]];
            [imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [album1 setImage:image forState:UIControlStateNormal];
            }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                NSLog(@"Image error");
            }];
            
        }
        if (i == 1) {
            NSLog(@"%@",[event.album objectAtIndex:1]);
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[event.album objectAtIndex:1]]];
            [imageView1 setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [album2 setImage:image forState:UIControlStateNormal];
            }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                NSLog(@"Image error");
            }];
            
        }
        if (i == 2) {
            NSLog(@"%@",[event.album objectAtIndex:2]);
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[event.album objectAtIndex:2]]];
            [imageView2 setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [album3 setImage:image forState:UIControlStateNormal];
            }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                NSLog(@"Image error");
            }];
        }
        
   }
    self.webView.frame = CGRectMake(self.webView.frame.origin.x, CGRectGetMaxY(self.album1.frame)+10, self.webView.frame.size.width, self.webView.frame.size.height);
    if (event.media.count > 0) {
        NSURL *urlforWebView=[NSURL URLWithString:[event.media objectAtIndex:0]];
        NSURLRequest *urlRequest=[NSURLRequest requestWithURL:urlforWebView];
        self.webView.frame = CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y, self.webView.frame.size.width, self.webView.frame.size.height+ 50);
        [self.webView loadRequest:urlRequest];
    }
    self.scrollDetailEvent.contentSize = CGSizeMake(self.scrollDetailEvent.frame.size.width,CGRectGetMaxY(self.webView.frame)+100);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
#pragma mark - Rotate View Support
- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
   
}
- (NSUInteger)supportedInterfaceOrientations
{
    //return orientations you want to support
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortraitUpsideDown);
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
 
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait: {
            NSLog(@"Portrait");
            self.description.frame = CGRectMake(self.description.frame.origin.x,CGRectGetMaxY(self.titleDescription.frame), self.description.frame.size.width, [FMUtils heightForCell:description.text size:17 font:@"Helvetica" width:[FMUtils getMainView].frame.size.width -10]);
            self.description.backgroundColor = [UIColor clearColor];

            self.album1.frame = CGRectMake(self.album1.frame.origin.x,CGRectGetMaxY(self.description.frame) + 10, self.album1.frame.size.width, self.album1.frame.size.height);
            self.album2.frame = CGRectMake(self.album2.frame.origin.x,CGRectGetMaxY(self.description.frame) + 10, self.album2.frame.size.width, self.album2.frame.size.height);
            self.album3.frame = CGRectMake(self.album3.frame.origin.x,CGRectGetMaxY(self.description.frame) + 10, self.album3.frame.size.width, self.album3.frame.size.height);
            self.webView.frame = CGRectMake(self.webView.frame.origin.x, CGRectGetMaxY(self.album1.frame)+ 10, self.webView.frame.size.width, self.view.frame.size.height);
            self.scrollDetailEvent.contentSize = CGSizeMake([FMUtils getMainView].frame.size.width,CGRectGetMaxY(self.webView.frame)+100);
        break;
        }
            
        case UIInterfaceOrientationLandscapeLeft: {
            NSLog(@"Landscape Left");
             self.description.frame = CGRectMake(self.description.frame.origin.x,CGRectGetMaxY(self.titleDescription.frame), self.description.frame.size.width, [FMUtils heightForCell:description.text size:17 font:@"Helvetica" width:[FMUtils getMainView].frame.size.height-10]);
            self.description.backgroundColor = [UIColor clearColor];
            self.album1.frame = CGRectMake(self.album1.frame.origin.x,CGRectGetMaxY(self.description.frame) + 10, self.album1.frame.size.width, self.album1.frame.size.height);
            self.album2.frame = CGRectMake(self.album2.frame.origin.x,CGRectGetMaxY(self.description.frame) + 10, self.album2.frame.size.width, self.album2.frame.size.height);
            self.album3.frame = CGRectMake(self.album3.frame.origin.x,CGRectGetMaxY(self.description.frame) + 10, self.album3.frame.size.width, self.album3.frame.size.height);
            
            
            
            self.webView.frame = CGRectMake(self.webView.frame.origin.x, CGRectGetMaxY(self.album1.frame) + 10, self.webView.frame.size.width, self.view.frame.size.height);
            self.scrollDetailEvent.contentSize = CGSizeMake([FMUtils getMainView].frame.size.height,CGRectGetMaxY(self.webView.frame)+100);
           
            
            break;
        }
            
        case UIInterfaceOrientationLandscapeRight: {
            NSLog(@"Landscape Right");
            self.description.frame = CGRectMake(self.description.frame.origin.x,CGRectGetMaxY(self.titleDescription.frame), self.description.frame.size.width, [FMUtils heightForCell:description.text size:17 font:@"Helvetica" width:[FMUtils getMainView].frame.size.height-10]);
            self.description.backgroundColor = [UIColor clearColor];

            self.album1.frame = CGRectMake(self.album1.frame.origin.x,CGRectGetMaxY(self.description.frame) + 10, self.album1.frame.size.width, self.album1.frame.size.height);
            self.album2.frame = CGRectMake(self.album2.frame.origin.x,CGRectGetMaxY(self.description.frame) + 10, self.album2.frame.size.width, self.album2.frame.size.height);
            self.album3.frame = CGRectMake(self.album3.frame.origin.x,CGRectGetMaxY(self.description.frame) + 10, self.album3.frame.size.width, self.album3.frame.size.height);
            
            self.webView.frame = CGRectMake(self.webView.frame.origin.x, CGRectGetMaxY(self.album1.frame) + 10, self.webView.frame.size.width, self.view.frame.size.height);
            self.scrollDetailEvent.contentSize = CGSizeMake([FMUtils getMainView].frame.size.height,CGRectGetMaxY(self.webView.frame)+50);
            
            break;
        }
            
        default:
            break;
    }
}
-(UIView *)createLableTitle:(NSString *)title{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    label.text = title;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Regular" size:17];
    //label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    return label;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    // Do Stuff!
    
    self.navigationItem.titleView = [self createLableTitle:@"ALEPLACE"];

    if (item.tag == 1000) {
        
    }else{
        if([item.title isEqualToString:@"Ale"]) {
            NSLog(@"Ale");
            item.tag = 1000;
            tabBarItemPlace.tag = tabBarItemHome.tag = tabBarItemTace.tag = 100;
            if (!aleViewController) {
                aleViewController = [[APAleViewController alloc] initWithNibName:@"APAleViewController" bundle:nil];
            }
            aleViewController.event = [[APEvent alloc] init];
            aleViewController.event = [listEvents objectAtIndex:0];
            aleViewController.view.frame = CGRectMake(0, aleViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - tabBarAle.frame.size.height);
            //[aleViewController layout];
            //aleViewController.aleScroll.frame = CGRectMake(0, aleViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 50);
            [self.view addSubview:aleViewController.view];
            
            //[self.navigationController pushViewController:aleViewController animated:NO];
        }
        if([item.title isEqualToString:@"Take care"]) {
            NSLog(@"TaKe");
            item.tag = 1000;
            tabBarItemPlace.tag = tabBarItemHome.tag = tabBarItemAle.tag = 100;
            if (!takecareViewController) {
                takecareViewController = [[APTakecareViewController alloc] initWithNibName:@"APTakecareViewController" bundle:nil];
            }
            takecareViewController.view.frame = CGRectMake(0, takecareViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - tabBarAle.frame.size.height);
            //aleViewController.aleScroll.frame = CGRectMake(0, aleViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 50);
            [self.view addSubview:takecareViewController.view];
        }
        if([item.title isEqualToString:@"Places"]) {
            NSLog(@"Places");
            item.tag = 1000;
            tabBarItemAle.tag = tabBarItemHome.tag = tabBarItemTace.tag = 100;
            if (!placeViewController) {
                placeViewController = [[APPlaceViewController alloc] initWithNibName:@"APPlaceViewController" bundle:nil];
            }
            placeViewController.view.frame = CGRectMake(0, placeViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - tabBarAle.frame.size.height);
            //aleViewController.aleScroll.frame = CGRectMake(0, aleViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 50);
            [self.view addSubview:placeViewController.view];
        }
        if([item.title isEqualToString:@"Home"]) {
            [self.navigationController popViewControllerAnimated:NO];
            NSLog(@"Home");
        }
    }

}
-(IBAction)showAle:(id)sender{
    UIButton *bt = sender;
    if (bt.tag != 1000) {
        btItemAle.selected = YES;
        btItemHome.selected = NO;
        btItemPlace.selected = NO;
        btItemTake.selected =NO;
        btItemAle.tag = 1000;
        btItemHome.tag = btItemPlace.tag = btItemTake.tag = 100;
        //if (!aleViewController) {
            aleViewController = [[APAleViewController alloc] initWithNibName:@"APAleViewController" bundle:nil];
        //}
        aleViewController.event = [[APEvent alloc] init];
        aleViewController.event = [listEvents objectAtIndex:0];
        aleViewController.view.frame = CGRectMake(0, aleViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - tabBarAle.frame.size.height);
        [aleViewController layout];
        //aleViewController.aleScroll.frame = CGRectMake(0, aleViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 50);
        [self.view addSubview:aleViewController.view];
        [placeViewController.view removeFromSuperview];
        [takecareViewController.view removeFromSuperview];
         flagClass = @"";
    }
    
}
-(IBAction)showTake:(id)sender{
    UIButton *bt = sender;
    if (bt.tag != 1000) {
        btItemAle.selected = NO;
        btItemHome.selected = NO;
        btItemPlace.selected = NO;
        btItemTake.selected =YES;
        btItemTake.tag = 1000;
        btItemAle.selected = NO;
        btItemHome.tag = btItemPlace.tag = btItemAle.tag = 100;
        //if (!takecareViewController) {
            takecareViewController = [[APTakecareViewController alloc] initWithNibName:@"APTakecareViewController" bundle:nil];
        //}
        takecareViewController.view.frame = CGRectMake(0, takecareViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - tabBarAle.frame.size.height);
        //aleViewController.aleScroll.frame = CGRectMake(0, aleViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 50);
        [self.view addSubview:takecareViewController.view];
        [aleViewController.view removeFromSuperview];
        [placeViewController.view removeFromSuperview];
         flagClass = @"";
        
    }
}
-(IBAction)showPlace:(id)sender{
    UIButton *bt = sender;
    if (bt.tag != 1000) {
        btItemPlace.tag = 1000;
        btItemAle.selected = NO;
        btItemHome.selected = NO;
        btItemPlace.selected = YES;
        btItemTake.selected =NO;
        btItemHome.tag = btItemAle.tag = btItemTake.tag = 100;
        //if (!placeViewController) {
            placeViewController = [[APPlaceViewController alloc] initWithNibName:@"APPlaceViewController" bundle:nil];
        //}
        placeViewController.view.frame = CGRectMake(0, placeViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - tabBarAle.frame.size.height);
        //aleViewController.aleScroll.frame = CGRectMake(0, aleViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 50);
        [self.view addSubview:placeViewController.view];
        [aleViewController.view removeFromSuperview];
        [takecareViewController.view removeFromSuperview];
        flagClass = @"";
    }
}
-(IBAction)showHome:(id)sender{
    UIButton *bt = sender;
    if (bt.tag != 1000) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}
@end
