    //
//  ImgDetailController.m
//  GMEPS_HZ
//
//  Created by chen on 11-9-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImgDetailController.h"
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation ImgDetailController
@synthesize imgURL,webView;
@synthesize wrybh,HUD;
@synthesize webservice,currentString,bItem,nParserStatus;

-(void)loadfile{
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imgURL]];
    webView.delegate = self;
    [webView loadRequest:urlRequest];
    [urlRequest release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
        if (HUD) {
            [HUD release];
        }
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        // Regisete for HUD callbacks so we can remove it from the window at the right time
        HUD.delegate = nil;
        HUD.labelText = @"正在下载附件，请稍候...";
        [HUD show:YES];
        [NSThread detachNewThreadSelector:@selector(loadfile) toTarget:self withObject:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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


- (void)dealloc {
    [HUD release];
	[imgURL release];
	[webView release];
    [wrybh release];

    [webservice release];
    [currentString release];

    [super dealloc];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [HUD hide:YES];
    [HUD removeFromSuperview];
    [HUD release];
    HUD = nil;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"错误"
                          message:@"文件不存在。"
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil];
    [alert show];
    [alert release];

    
    [HUD hide:YES];
    [HUD removeFromSuperview];
    [HUD release];
    HUD = nil;
}


@end
