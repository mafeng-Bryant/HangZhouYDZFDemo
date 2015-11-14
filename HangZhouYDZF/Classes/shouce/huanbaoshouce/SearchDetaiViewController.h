//
//  SearchDetaiViewController.h
//  handbook
//
//  Created by chen on 11-4-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchViewController;

@interface SearchDetaiViewController : UIViewController <UIWebViewDelegate>{

	IBOutlet UIWebView *webView;
	NSDictionary *titleDic; //理化参数
	

	
}

@property(nonatomic,retain) UIWebView *webView;
@property(nonatomic,retain) NSDictionary *titleDic;

@end
