
//  WebServiceHelper.m
//  GIS
//
//  Created by yushang on 10-10-17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebServiceHelper.h"
#import "GMEPS_HZAppDelegate.h"
extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation WebServiceHelper
@synthesize url;
@synthesize method;
@synthesize nameSpace;
@synthesize parameters;

@synthesize webData;
@synthesize xmlParser;
@synthesize theConnection;

@synthesize delegate;
@synthesize HUD;
@synthesize hudTitle;
@synthesize errMsg;

+(NSString*) createParametersWithKey:(NSString*) aKey value:(NSString*) aValue, ...
{
    id k, v;
    va_list argumentList;
    NSString* ret = [NSString stringWithFormat:@"<%@>%@</%@>", aKey, aValue, aKey];
    
    va_start(argumentList, aValue);
    while ((k = va_arg(argumentList, id)) && (v = va_arg(argumentList, id))) {
        ret = [NSString stringWithFormat:@"%@<%@>%@</%@>", ret, k, v, k];
    }
    va_end(argumentList);
    return ret;
}

- (WebServiceHelper*)initWithUrl:(NSString*) aUrl
                          method:(NSString*) aMethod
                       nameSpace:(NSString*) aNameSpace
                      parameters:(NSString*) aParameters
                        delegate:(id) aDelegate
{
    self.url = aUrl;
    self.method = aMethod;
    self.nameSpace = aNameSpace;
    self.parameters = aParameters;
    self.delegate = aDelegate;
    self.errMsg = @"提交数据到服务器失败，请检查网络后重试!";
    self.hudTitle = @"正在提交数据，请稍候...";
    return self;
}

- (WebServiceHelper*)initWithUrl:(NSString*) aUrl
                          method:(NSString*) aMethod
                            view:(UIView*)myView
                       nameSpace:(NSString*) aNameSpace
                      parameters:(NSString*) aParameters
                        delegate:(id) aDelegate
{
    self = [super init];
    self.url = aUrl;
    self.method = aMethod;
    self.nameSpace = aNameSpace;
    self.parameters = aParameters;
    self.delegate = aDelegate;
    self.errMsg = @"服务器连接失败，请检查网络后重试!";
    self.hudTitle = @"正在提交数据，请稍候...";
    
    HUD = [[MBProgressHUD alloc] initWithView:myView];
    [myView addSubview:HUD];
    HUD.delegate = self;
    [HUD show:YES];
    
    return self;
}


- (WebServiceHelper*)initWithUrl:(NSString*) aUrl
                          method:(NSString*) aMethod
                       nameSpace:(NSString*) aNameSpace
                        delegate:(id) aDelegate

{
    self.url = aUrl;
    self.method = aMethod;
    self.nameSpace = aNameSpace;
    self.parameters = nil;
    self.delegate = aDelegate;
    self.errMsg = @"服务器连接失败，请检查网络后重试!";
    self.hudTitle = @"正在提交数据，请稍候...";
    return self;
}

- (void)dealloc {
    [url release];
    [method release];
    [nameSpace release];
    [parameters release];
    if (bConnected)
        [theConnection cancel];
    [webData release];
    [xmlParser release];
    [delegate release];
    [theConnection release];
    [hudTitle release];
    [errMsg release];
    [super dealloc];
}

#pragma mark -
- (void)run
{
    
     HUD.labelText = hudTitle;
    if (bConnected)	return;
    bConnected = YES;
    
        
   
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //url
    NSURL *nsurl = [NSURL URLWithString:url];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:nsurl];
    
    //content-type
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //SOAPAction
    NSString *lastChar;
    NSString *slashUsed;
    lastChar = [self.nameSpace substringFromIndex:self.nameSpace.length -1];
    if([lastChar isEqualToString:@"/"]){
        slashUsed = @"";
    } else {
        slashUsed = @"/";
    }
    NSString* soapAction = [NSString stringWithFormat:@"%@%@%@", nameSpace, slashUsed, method];
    [theRequest addValue: soapAction forHTTPHeaderField:@"SOAPAction"];
    [theRequest setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    //httpMethod
    [theRequest setHTTPMethod:@"POST"];
    
    //httpbody
    NSString *soapMessage;
    if (self.parameters != nil) {
        soapMessage = [NSString stringWithFormat:
                       @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                       "<soap:Body>"
                       "<%@ xmlns=\"%@\">"
                       "%@"
                       "</%@>"
                       "</soap:Body>"
                       "</soap:Envelope>",
                       method, nameSpace, parameters, method
                       ];
    } else {
        soapMessage = [NSString stringWithFormat:
                       @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                       "<soap:Body>"
                       "<%@ xmlns=\"%@\">"
                       "</%@>"
                       "</soap:Body>"
                       "</soap:Envelope>",
                       method, nameSpace, method
                       ];
    }
    NSLog(@"%@",soapMessage);
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //length
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setTimeoutInterval:30];//30秒
    //请求
    NSURLConnection* aConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if(aConnection)
    {
        webData = [[NSMutableData data] retain];
    }
    else
    {
        //NSLog(@"theConnection is NULL");
    }
  //NSLog(@"strat");
}

#pragma mark -
#pragma mark NSURLConnectionDelegete

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //NSLog(@"ERROR with theConenction");
    if (HUD.superview != nil) {
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }

    
    bConnected = NO;
    //NSString *str = @"<faultcode>error</faultcode>";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    xmlParser = [[NSXMLParser alloc] initWithData: [str dataUsingEncoding:NSUTF8StringEncoding]];
//    [xmlParser setDelegate: delegate];
//    [xmlParser setShouldResolveExternalEntities: YES];
//    [xmlParser parse];
    
        
        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:@"提示" message:errMsg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alerview show];
        [alerview release];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (HUD.superview != nil) {
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }
    
    NSString *strLog = [[NSString alloc] initWithBytes:[webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSLog(@"response:%@",strLog);
    [strLog release];
    
    
    
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: delegate];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
    
    bConnected = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;


}

- (void)startParseWebData{
    
       
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	
    [self startParseWebData];
}

@end
