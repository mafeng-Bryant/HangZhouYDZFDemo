    //
//  UIChargeDetailController.m
//  EPad
//
//  Created by chen on 11-6-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIChargeDetailController.h"


@implementation UIChargeDetailController
@synthesize webView;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)loadHtmlFile:(NSString*)htmlName{
    NSString *detailHtmlPath = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html" inDirectory:@"环保标准"];
    
	if([[htmlName pathExtension] isEqualToString:@"pdf"])
        detailHtmlPath = [[NSBundle mainBundle] pathForResource:[htmlName substringToIndex:htmlName.length - 4] ofType:@"pdf" inDirectory:@"环保标准"];
    if(detailHtmlPath){
        NSURL *url = [NSURL fileURLWithPath:detailHtmlPath isDirectory:NO];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    
	
    
	
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [webView setDelegate:self];
    webView.scalesPageToFit = YES;
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark -
#pragma mark  webview delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;  
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'"];  
    
}


- (void)dealloc {
//	[webService release];
	[webView release];
    [super dealloc];
}


@end
