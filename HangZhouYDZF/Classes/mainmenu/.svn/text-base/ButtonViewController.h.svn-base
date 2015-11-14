//
//  ButtonViewController.h
//  Eve
//
//  Created by yushang on 10-11-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAX_BUTTON_COUNT 16
@interface ButtonViewController : UIViewController {
	UILabel* lblTitle;
	UIButton* btn[MAX_BUTTON_COUNT];

	NSInteger page;
	UIViewController* parent;
}

@property (assign) UIViewController* parent;
@property (nonatomic, retain) IBOutlet UILabel *lblTitle;


- (id)initWithPage:(NSInteger)nPage;
-(IBAction)toggleFrom:(id)sender;

@end
