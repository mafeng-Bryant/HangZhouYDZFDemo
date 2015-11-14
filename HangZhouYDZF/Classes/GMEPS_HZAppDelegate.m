//
//  GMEPS_HZAppDelegate.m
//  GMEPS_HZ
//
//  Created by chen on 11-9-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GMEPS_HZAppDelegate.h"
#import "DataBaseInstaller.h"
#import "sys/utsname.h"
GMEPS_HZAppDelegate *g_appDelegate = nil;
sqlite3 *data_db = nil;

NSArray *tableColumn;


@implementation GMEPS_HZAppDelegate

@synthesize window, navigationController;
@synthesize ServerIP,yyydIP;
@synthesize isSave;
#pragma mark -
#pragma mark Application lifecycle



- (BOOL) initializeDb {
	[DataBaseInstaller Install];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dataDbPath = [documentsDirectory stringByAppendingPathComponent:@"wrydata.db"];

	if (sqlite3_open([dataDbPath UTF8String], &data_db)!=SQLITE_OK) { 
		//NSLog(@"open datadb sqlite db error."); 
	}	
	return YES;
	
}




#define KServerIP @"ip_preference"
#define KyyydIP   @"ip_yyyd"
// 获取默认设置
- (void)setupByPreferences {
	NSString *testValue1 = [[NSUserDefaults standardUserDefaults] stringForKey:KServerIP];
    NSString *testValue2 = [[NSUserDefaults standardUserDefaults] stringForKey:KyyydIP];
	if (testValue1 == nil || testValue2 == nil)
	{
		// no default values have been set, create them here based on what's in our Settings bundle info
		//
		NSString *pathStr = [[NSBundle mainBundle] bundlePath];
		NSString *settingsBundlePath = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
		NSString *finalPath = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
        
		NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfFile:finalPath];
		NSArray *prefSpecifierArray = [settingsDict objectForKey:@"PreferenceSpecifiers"];
        
		NSString *serveripDefault = nil;
        NSString *yyydipDefault = nil;
		
		NSDictionary *prefItem;
		for (prefItem in prefSpecifierArray)
		{
			NSString *keyValueStr = [prefItem objectForKey:@"Key"];
			id defaultValue = [prefItem objectForKey:@"DefaultValue"];
			
			if ([keyValueStr isEqualToString:KServerIP])
			{
				serveripDefault = defaultValue;
			}else if ([keyValueStr isEqualToString:KyyydIP])
			{
				yyydipDefault = defaultValue;
			}
            
		}
        
		// since no default values have been set (i.e. no preferences file created), create it here
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                     serveripDefault, KServerIP,yyydipDefault, KyyydIP,
                                     nil];
        
		[[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	// we're ready to go, so lastly set the key preference values
	self.ServerIP = [[NSUserDefaults standardUserDefaults] stringForKey:KServerIP];
    self.yyydIP = [[NSUserDefaults standardUserDefaults] stringForKey:KyyydIP];
    
    

    #if TARGET_IPHONE_SIMULATOR
        self.udid = @"powerdatamobileios";
    #else
        UIDevice *device =  [UIDevice currentDevice];
        self.udid = [device uniqueIdentifier];
    #endif
    self.udid = @"powerdatamobileios";
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	

	if (! [self initializeDb]) {
		// TODO: alert the user!
		//NSLog (@"couldn't init db");
		return NO;
	}
	    
	tableColumn = [[NSArray alloc]initWithObjects:@"ITEMCODE",
				   @"ESTATECODE",@"CASCODE",@"CNAME",
				   @"ENAME",@"ITEMALIAS",@"KINDCODE",
				   @"MOLECULE",@"MOLECULEW",@"FUSIBILITY",
				   @"DENSITY",@"CRITICALITY",@"BOIL",
				   @"FLASHP",@"ASPECT",@"STEAM",
				   @"DISSOLVE",@"STABILITY",@"OPERATION",
				   @"PRIORITY",@"RATING",@"SPELLCODE",
				   @"FONTCODE",nil];
	
	
    //[window addSubview:navigationController.view];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    
    [self setupByPreferences];
	g_appDelegate =self;
    
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [mapManager start:@"C42968B2FB398D5C63706C36E6467DB772214220" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    isSave = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newlog" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"siteinfor" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tellview" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"opinion" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"caiyang" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scoreview" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"uisendduban" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dudelview" object:nil];
 
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    isSave = NO;

}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    time(&timeEnterBackground);
}

-(void)gotoLogInUI{
	
    [navigationController.view removeFromSuperview];
    [navigationController popToRootViewControllerAnimated:NO];
    [window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
	
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
    
    time_t now;
    time(&now);
    NSLog(@"%ld",now - timeEnterBackground);
    if ((now - timeEnterBackground) >  60*60){//超过60分钟就重新登录
        [self gotoLogInUI];
        
         NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
         [self performSelectorOnMainThread:@selector(gotoLogInUI) withObject:nil waitUntilDone:NO];
         [pool release];
    }

    
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [navigationController release];
    [window release];
    [super dealloc];
}


@end

