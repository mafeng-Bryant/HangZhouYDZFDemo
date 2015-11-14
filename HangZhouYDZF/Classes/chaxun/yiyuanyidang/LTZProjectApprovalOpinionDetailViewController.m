//
//  LTZProjectApprovalOpinionDetailViewController.m
//  GMEPS_HZ
//
//  Created by TianZhuLi on 14-3-18.
//
//

#import "LTZProjectApprovalOpinionDetailViewController.h"

@interface LTZProjectApprovalOpinionDetailViewController ()

@end

@implementation LTZProjectApprovalOpinionDetailViewController

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
    // Do any additional setup after loading the view from its nib.
    [self initNavigationItem];
    [self initUIWebView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavigationItem
{
    [[self navigationItem] setTitle:[self titleOfViewController]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goBackAction)];

}

-(void)initUIWebView
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"quickguide-0.34" ofType:@"pdf"];
    NSURL *url =[NSURL fileURLWithPath:filePath];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [_webView setDelegate:self];
}
-(void)initUIActivityIndicatorView
{
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.navigationItem.titleView = _activityIndicatorView;
    [_activityIndicatorView startAnimating];
    self.navigationItem.prompt = @"Loading File …";
}

-(void)stopLoadingFile
{
    if (_activityIndicatorView && [_activityIndicatorView isAnimating]) {
        [_activityIndicatorView stopAnimating];
    }
    self.navigationItem.titleView = nil;
    self.navigationItem.prompt = nil;
}

-(void)goBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [_webView release];
    if ([_activityIndicatorView isAnimating]) {
        [_activityIndicatorView stopAnimating];
    }
    [_activityIndicatorView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIWebViewDelegate Methods
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self initUIActivityIndicatorView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self stopLoadingFile];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notice"
                                                        message:@"ERROR!When Loading The File"
                                                       delegate:self cancelButtonTitle:@"back to last view" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}
#pragma mark -
#pragma mark UIAlertViewDelegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self goBackAction];
}

@end
