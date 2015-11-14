//
//  UIGraphicToolsController.m
//  GMEPS_HZ
//
//  Created by 张 仁松 on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIGraphicToolsController.h"
#import "PencilTool.h"
#import "LineTool.h"
#import "RectangleTool.h"
#import "EllipseTool.h"
#import "EraserTool.h"
#import "DashLineTool.h"
#import "DashEllipseTool.h"
#import "ArrowLine.h"
#import "ArrowDashLine.h"
@implementation UIGraphicToolsController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



-(IBAction)btnPressed:(id)sender{
    UIButton *btn = (UIButton*)sender;
    id<Tool> selTool = nil;
    switch (btn.tag) {
        case 0:
            selTool = [LineTool sharedLineTool];
            break;
        case 1:
            selTool = [RectangleTool sharedRectangleTool];
            break;
        case 2:
            selTool = [PencilTool sharedPencilTool];
            break;
        case 3:
            selTool = [DashEllipseTool sharedDashEllipseTool];
            break;
        case 4:
            selTool = [DashLineTool sharedDashLineTool];
            break;
        case 5:
            selTool = [EllipseTool sharedEllipseTool];
            break;
        case 6:
            selTool = [ArrowLine sharedArrowLine];
            break;
        case 7:
            selTool = [ArrowDashLine sharedArrowDashLine];
            break;
        default:
            break;
    }
    if (selTool) {
        [delegate returnSelectedTool:selTool];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentSizeForViewInPopover = CGSizeMake(320, 480);
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
