//
//  UIYYYDViewController.h
//  EPad
//
//  Created by chen on 11-9-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableController.h"
#import "UISearchSitesController.h"
#import "RecentLawEnforcementViewController.h"



@interface UIYYYDViewController : UIViewController<SelectSitesDelegate> {
		
	UIPopoverController *popController;
	MenuTableController *menuController;
	NSString *WRYBH;
}

@property(nonatomic,retain)  UIPopoverController *popController;
@property(nonatomic,retain)  MenuTableController *menuController;
@property(nonatomic,copy)   NSString *WRYBH;
@property(nonatomic,copy) NSString *WRYMC;


-(void)switchViewToFront:(int)tag title:(NSString*)values;
@end
