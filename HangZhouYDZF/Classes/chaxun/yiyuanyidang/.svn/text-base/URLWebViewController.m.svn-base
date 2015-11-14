    //
//  URLWebViewController.m
//  GMEPS_HZ
//
//  Created by chen on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "URLWebViewController.h"


@implementation URLWebViewController
@synthesize urlStr,webView,actor;
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.actor = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
    actor.hidesWhenStopped = YES;
	
	
	NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:
								[NSURL URLWithString:urlStr]];
	webView.delegate = self;
	[webView loadRequest:urlRequest];
	[urlRequest release];	

	actor.center = self.view.center;
	[self.view addSubview:actor];
	[actor startAnimating];
	
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	[actor stopAnimating];
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


- (void)dealloc {
    [actor release];
    [super dealloc];
}


@end
