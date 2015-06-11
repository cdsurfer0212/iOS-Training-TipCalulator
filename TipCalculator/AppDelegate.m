//
//  AppDelegate.m
//  TipCalculator
//
//  Created by Sean Zeng on 6/6/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

//@property (nonatomic) float billAmount;
@property (nonatomic) NSUserDefaults *userDefaults;

@end

@implementation AppDelegate

@synthesize billAmount;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"application");

    /*
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nvc;
    
    //self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    */
    
    [self useLastValues];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
     NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSLog(@"applicationDidEnterBackground");
    
    [self setLastValues];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    NSLog(@"applicationDidBecomeActive");
    
    [self useLastValues];

    ViewController *viewController = [[((UINavigationController*) self.window.rootViewController) viewControllers] objectAtIndex:0];

    if (self.billAmount > 0) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        viewController.billTextField.text  = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.billAmount]];
    }
    else {
        viewController.billTextField.text = @"";
    }
    [viewController updateValues];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"applicationWillTerminate");
}

- (void)setLastValues
{
    [self.userDefaults setFloat:self.billAmount forKey:@"lastBillAmount"];
    [self.userDefaults setObject:[NSDate date] forKey:@"lastAccessedDate"];
    [self.userDefaults synchronize];
}

- (void)useLastValues
{
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDate *lastAccessedDate = [self.userDefaults objectForKey:@"lastAccessedDate"];
    if (!lastAccessedDate) {
        return;
    }
    
    NSLog(@"Seconds between now and last accessed date: %f", -[lastAccessedDate timeIntervalSinceNow]);
    
    int secondsToHoldValues = 60;
    if (-[lastAccessedDate timeIntervalSinceNow] <= secondsToHoldValues) {
        self.billAmount = [self.userDefaults floatForKey:@"lastBillAmount"];
    }
    else {
        self.billAmount = 0;
    }
}

@end
