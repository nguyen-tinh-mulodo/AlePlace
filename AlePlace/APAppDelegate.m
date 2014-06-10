//
//  APAppDelegate.m
//  AlePlace
//
//  Created by Apple on 6/5/14.
//
//

#import "APAppDelegate.h"
#import "FMConstants.h"

@implementation APAppDelegate
@synthesize launchImageViewController,homeViewController,navigation;
+ (APAppDelegate *)appDelegate
{
    return (APAppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [GMSServices provideAPIKey:@"AIzaSyDDqATktPa4VeAlq1UABvNmXjLduxYyf5Y"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.launchImageViewController = [[APLaunchImageViewController alloc] initWithNibName:@"APLaunchImageViewController" bundle:nil];
    [self.window setRootViewController:self.launchImageViewController];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(setRootViewController)
                                   userInfo:nil
                                    repeats:NO];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)setRootViewController{
    self.homeViewController = [[APHomeViewController alloc] initWithNibName:@"APHomeViewController" bundle:nil];
    self.navigation = [[UINavigationController alloc] initWithRootViewController:self.homeViewController];
    self.navigation.delegate = self;
    [self.window setRootViewController:self.navigation];
    [self setupNavigation];
}
- (void)setupNavigation {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        self.navigation.navigationBar.barTintColor = UIColorFromRGB(kMetroColorGreen);
        self.navigation.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
        self.navigation.navigationBar.translucent = NO;
        
    }else{
        self.navigation.navigationBar.tintColor = UIColorFromRGB(kMetroColorGreen);
    }
}
#pragma mark - Navigation Bar delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UINavigationItem *navigationItem = navigationController.navigationBar.topItem;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        navigationController.navigationBar.barTintColor = UIColorFromRGB(kMetroColorGreenSea);
    }else{
        navigationController.navigationController.navigationBar.tintColor = UIColorFromRGB(kMetroColorGreen);
    }
    
     if ([viewController isKindOfClass:[APHomeViewController class]]) {
    
     UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Title.png"]];
          [imageview setContentMode:UIViewContentModeScaleAspectFit];
         imageview.frame = CGRectMake(0, 0, 200, 44);
     UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
         [imageview addSubview:label];
        label.text = @"ALEPLACE";
   
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Regular" size:17];
    //label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    navigationItem.titleView = imageview;
     }else{
         
         NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"testView" owner:self options:nil];
         
         UIView *view = [[UIView alloc] init]; // or if it exists, MCQView *view = [[MCQView alloc] init];
         
         view = (UIView *)[nib objectAtIndex:0]; // or if it exists, (MCQView *)[nib objectAtIndex:0];
         
          navigationItem.titleView = view;
         /*UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-20, 0,self.window.frame.size.width,45)];
         
         
         UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Title.png"]];
         [imageview setContentMode:UIViewContentModeScaleAspectFit];
         UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 200, 40)];
         [imageview addSubview:label];
         label.text = @"SPORT EVENT";
         
         label.backgroundColor = [UIColor clearColor];
         label.font = [UIFont fontWithName:@"Roboto-Regular" size:17];
         //label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
         label.textAlignment = NSTextAlignmentCenter;
         label.textColor = [UIColor whiteColor];
         
         
         UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 45)];
          [back.imageView setContentMode:UIViewContentModeScaleAspectFit];
          imageview.frame = CGRectMake(CGRectGetMaxX(back.frame), 6,view.frame.size.width-144, 34);
         UIButton *more = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame),0, 60, 45)];
          [more.imageView setContentMode:UIViewContentModeScaleAspectFit];
         [more setImage:[UIImage imageNamed:@"More.png"] forState:UIControlStateNormal];
         [back setImage:[UIImage imageNamed:@"Back-button-.png"] forState:UIControlStateNormal];
         [view addSubview:back];
         [view addSubview:imageview];
         [view addSubview:more];*/
     }
}
-(void)setTitleLabel{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    label.text = @"SPORT";
    
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Regular" size:17];
    //label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigation.navigationItem.titleView = label;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
