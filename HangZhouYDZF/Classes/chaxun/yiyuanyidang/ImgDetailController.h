//
//  ImgDetailController.h
//  GMEPS_HZ
//
//  Created by chen on 11-9-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "ImgListController.h"

@interface ImgDetailController : UIViewController <UIWebViewDelegate>

@property (nonatomic,strong) NSString *wrybh;
@property (nonatomic,strong) NSString *dm;

@property (nonatomic,strong) WebServiceHelper *webservice;
@property (nonatomic,strong) NSMutableString *currentString;

@property (nonatomic,assign) BOOL bItem;
@property (nonatomic,assign) int nParserStatus;

@property (nonatomic,strong) NSString *imgURL;
@property (nonatomic,strong) IBOutlet UIWebView *webView;
@property (nonatomic,strong)MBProgressHUD *HUD;
@end
