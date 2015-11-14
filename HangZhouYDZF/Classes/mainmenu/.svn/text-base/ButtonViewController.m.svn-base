//
//  ButtonViewController.m
//  Eve
//
//  Created by yushang on 10-11-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ButtonViewController.h"
#import "MainMenuViewController.h"

@implementation ButtonViewController
@synthesize parent, lblTitle;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(IBAction)toggleFrom:(id)sender {
	//UIButton* btn = (UIButton*) sender;
    
	[(MainMenuViewController*)parent toggleFromByPage:page ByIndex: [sender tag]];
}

- (id)initWithPage:(NSInteger)nPage {
	page = nPage;
	self =[self initWithNibName:@"ButtonViewController" bundle:nil];
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor clearColor];

	int w = 80, h =80;
	int n = 4;
	int span = (768 - n * w) / (n + 1);
	int count = 0;
	NSArray *ary = nil;
	switch (page) {
		case 0:

			ary = [(MainMenuViewController*)parent titlePage1]; 
			lblTitle.text = @"现场执法";
			break;
		case 1:

			ary = [(MainMenuViewController*)parent titlePage2]; 
			lblTitle.text = @"企业信息查询";
			break;
		case 2:

			ary = [(MainMenuViewController*)parent titlePage3];
			lblTitle.text = @"统计分析";
			break;
		case 3:

			ary = [(MainMenuViewController*)parent titlePage4];
			lblTitle.text = @"环保手册";
			break;
		default:
			break;
	}
    if(ary == nil) return;
	count = [ary count];
	for (int i = 0; i < count; i++) {

		btn[i]=[[UIButton alloc] initWithFrame:
		CGRectMake(span + (span + w) * (i % n), 
				   span + (span + h) * (i / n) + 28,
				   w, h)];
		btn[i].tag = i ;

		btn[i].backgroundColor = [UIColor clearColor];
		NSString *s = [NSString stringWithFormat:@"mc_%d_%d.png", page + 1, i + 1];
		[btn[i] setBackgroundImage:[UIImage imageNamed:s] forState:UIControlStateNormal];
	
		
		[btn[i] addTarget:self action:@selector(toggleFrom:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:btn[i]];
		[btn[i] release];
		
		UILabel *btnLabel = [[UILabel alloc] initWithFrame:
					CGRectMake(span + (span + w) * (i % n), 
								span + (span + h) * (i / n) + 28 +w +5,
								w, 50)];
		btnLabel.lineBreakMode = UILineBreakModeCharacterWrap;
		btnLabel.numberOfLines = 2;
		btnLabel.text = [ary objectAtIndex:i];
		btnLabel.textAlignment = UITextAlignmentCenter;
		btnLabel.backgroundColor = [UIColor clearColor];
        btnLabel.contentMode =  UIViewContentModeTop;
		[self.view addSubview:btnLabel];
		[btnLabel release];
	}
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	for (int i = 0; i < MAX_BUTTON_COUNT; i++) {
		[btn[i] release];
	}
}


- (void)dealloc {
    [super dealloc];
}


@end
