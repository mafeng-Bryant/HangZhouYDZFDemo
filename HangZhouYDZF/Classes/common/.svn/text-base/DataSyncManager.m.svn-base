//
//  DataSyncManager.m
//  GMEPS_HZ
//
//  Created by 张仁松 on 13-5-24.
//
//

#import "DataSyncManager.h"
#import "GMEPS_HZAppDelegate.h"
#import "JSONKit.h"
#import "DBHelper.h"

extern GMEPS_HZAppDelegate *g_appDelegate;


@implementation DataSyncManager


- (void)dealloc {
    [super dealloc];
}

-(void)syncWryList{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lastSyncTime = [defaults  objectForKey:LastSyncTime];
    if(lastSyncTime == nil || [lastSyncTime length] <= 0)
        lastSyncTime = @"2013/01/01 12:00:00";
    
    NSString* params = [WebServiceHelper createParametersWithKey:@"Time"
                                                           value:lastSyncTime,nil];
    
	NSString *URL = [NSString  stringWithFormat: KLogIn_URL,g_appDelegate.ServerIP];
	WebServiceHelper *webService = [[WebServiceHelper alloc] initWithUrl:URL
                                                method:@"DataSynchronization"
                                             nameSpace:KSoapNameSpace
                                            parameters:params
                                              delegate:self];
	[webService run];
}

#define PARSER_TABLE 1


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"DataSynchronizationResult"]){
        nParserStatus = PARSER_TABLE;
    }
	else
		nParserStatus = -1;
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (nParserStatus){
        if(curData == nil)
            curData = [[NSMutableString stringWithCapacity:100] retain];
		[curData appendString:string];
    }
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if (nParserStatus >= 0) {
        switch (nParserStatus) {
            case PARSER_TABLE:
                [self handleWryItems:curData];
                break;
           
           
            default:
                break;
        }
    }
	
	[curData setString:@""];
    nParserStatus = -1;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [curData release];
    curData = nil;
}

-(void)handleWryItems:(NSString*)dataString{
    NSArray *aryTmp = [dataString objectFromJSONString];
    if(aryTmp){
        for(NSDictionary *dicItem in aryTmp){
            [[DBHelper sharedInstance] insertWry:dicItem byWryBH:[dicItem objectForKey:@"WRYBH"]];

        }
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *lastSyncTime = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];

    [defaults  setObject:lastSyncTime forKey:LastSyncTime];
    [_syncDelegate syncDataFinished];
}
@end
