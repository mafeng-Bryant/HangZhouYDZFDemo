//
//  UIChargeDetailController.h
//  EPad
//
//  Created by chen on 11-6-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIChargeDetailController : UIViewController<UIWebViewDelegate> {

//	WebServiceHelper* webService;
	IBOutlet UIWebView *webView;
	
	NSMutableData *webData;
	NSMutableString *currentData;

}
@property(nonatomic,retain) UIWebView *webView;
//@property(nonatomic, retain) WebServiceHelper *webService;
-(void)loadHtmlFile:(NSString*)htmlName;
@end
