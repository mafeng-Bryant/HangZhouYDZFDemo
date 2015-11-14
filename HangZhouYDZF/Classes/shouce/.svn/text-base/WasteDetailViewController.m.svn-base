//
//  WasteDetailViewController.m
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-6-21.
//
//

#import "WasteDetailViewController.h"

@interface WasteDetailViewController ()

@end

@implementation WasteDetailViewController

- (void)dealloc {
    [_detailDict release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }

    
  
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"国家危险废物";
    NSString *headHtmlPath = [[NSBundle mainBundle] pathForResource:@"waste_table" ofType:@"htm"];
	NSMutableString *html = [NSMutableString stringWithContentsOfFile:headHtmlPath encoding:NSUTF8StringEncoding error:nil];
	
    [html replaceOccurrencesOfString:@"wastebhID" withString:[_detailDict objectForKey:@"bh"] options:NSLiteralSearch range:NSMakeRange(0, [html length])];
    
     [html replaceOccurrencesOfString:@"sourceID" withString:[_detailDict objectForKey:@"hl"] options:NSLiteralSearch range:NSMakeRange(0, [html length])];
    
    [html replaceOccurrencesOfString:@"nameID" withString:[_detailDict objectForKey:@"name"] options:NSLiteralSearch range:NSMakeRange(0, [html length])];
    
     [html replaceOccurrencesOfString:@"categoryID" withString:[_detailDict objectForKey:@"category"] options:NSLiteralSearch range:NSMakeRange(0, [html length])];
    
     [html replaceOccurrencesOfString:@"featureID" withString:[_detailDict objectForKey:@"feature"] options:NSLiteralSearch range:NSMakeRange(0, [html length])];
	
	
	
	
		
	[detailView loadHTMLString:html baseURL:nil];
    detailView.delegate = self;
    detailView.dataDetectorTypes = UIDataDetectorTypeNone;
    
//    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"waste_table" ofType:@"htm"];
//    NSURL *url = [NSURL fileURLWithPath:urlStr];
//    [detailView loadRequest:[NSURLRequest requestWithURL:url]];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
#pragma mark  webview delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [webView  stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '150%'"];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
