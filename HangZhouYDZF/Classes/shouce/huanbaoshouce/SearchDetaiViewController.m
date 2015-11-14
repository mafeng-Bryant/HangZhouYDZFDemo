    //
//  SearchDetaiViewController.m
//  handbook
//
//  Created by chen on 11-4-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchDetaiViewController.h"
//#import "SearchViewController.h"
extern NSArray *tableColumn;
@implementation SearchDetaiViewController
@synthesize webView,titleDic;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    webView.delegate = self;
	NSString *headHtmlPath = [[NSBundle mainBundle] pathForResource:@"table" ofType:@"htm"];
	NSMutableString *html = [NSMutableString stringWithContentsOfFile:headHtmlPath encoding:NSUTF8StringEncoding error:nil];
	
	[html replaceOccurrencesOfString:@"gbbhID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:1]] 
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	[html replaceOccurrencesOfString:@"casID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:2]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	 
	[html replaceOccurrencesOfString:@"zwmcID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:3]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	[html replaceOccurrencesOfString:@"ywmcID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:4]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	[html replaceOccurrencesOfString:@"bmID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:5]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	[html replaceOccurrencesOfString:@"fzsID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:7]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	[html replaceOccurrencesOfString:@"fzlID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:8]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	[html replaceOccurrencesOfString:@"rdID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:9]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	[html replaceOccurrencesOfString:@"mdID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:10]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	[html replaceOccurrencesOfString:@"wgyqwID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:14]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	[html replaceOccurrencesOfString:@"zqyID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:15]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	[html replaceOccurrencesOfString:@"rjxID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:16]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	
	[html replaceOccurrencesOfString:@"wdxywxxID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:17]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	[html replaceOccurrencesOfString:@"zyytID" withString:[titleDic objectForKey:[tableColumn objectAtIndex:18]]
							 options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *htmlName = [NSString stringWithFormat:@"%@_%@",
						  [titleDic objectForKey:[tableColumn objectAtIndex:1]],
						  [titleDic objectForKey:[tableColumn objectAtIndex:2]]];
	NSString *detailHtmlPath = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"htm" inDirectory:@"CrisesInfo"];
	
	NSMutableString *detailhtml = [NSMutableString stringWithContentsOfFile:detailHtmlPath encoding:enc error:nil];
	if (detailhtml != nil) {
		[html appendString:detailhtml];
	}
	
	[webView loadHTMLString:html baseURL:nil];
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
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '150%'"];  
    
}


- (void)dealloc {
    [super dealloc];
}


@end
