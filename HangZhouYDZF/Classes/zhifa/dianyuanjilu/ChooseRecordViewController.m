//
//  ChooseRecordViewController.m
//  GMEPS_HZ
//
//  Created by power humor on 12-7-27.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import "ChooseRecordViewController.h"
#import "UITableViewCell+Custom.h"
#import "DBHelper.h"

#import "WebServiceHelper.h"
#import "UserInfo.h"
extern UserInfo *g_logedUserInfo;
#import "GMEPS_HZAppDelegate.h"
extern GMEPS_HZAppDelegate *g_appDelegate;
#import "JSONKit.h"
#import "SharedInformations.h"
#import "GUIDGenerator.h"

@implementation ChooseRecordViewController
@synthesize chooseAry;
@synthesize delegate,type;
@synthesize blName,wrymc;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(void)dealloc{
    [_currentdata release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
//    //如果是获取历史数据（联网的就不能编辑
//    if (!_isGetHistory) {
//        UIBarButtonItem *editBut = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editButClick:)];
//        self.navigationItem.rightBarButtonItem = editBut;
//        [editBut release];
//    }
   

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isGetHistory) {
        if (self.navigationItem.rightBarButtonItem!=nil) {
            self.navigationItem.rightBarButtonItem = nil;
        }
        [self requestServerHisRecord];
        return;
    }
    
    if (self.navigationItem.rightBarButtonItem == nil) {
        UIBarButtonItem *editBut = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editButClick:)];
        self.navigationItem.rightBarButtonItem = editBut;
        [editBut release];
    }
    
    self.chooseAry = [[DBHelper sharedInstance] queryRecordByWrymc:wrymc andTableName:blName TYPE:type];
    
    [self.tableView reloadData];
}

-(void)requestServerHisRecord{
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
    NSString* params = [WebServiceHelper createParametersWithKey:@"TableName"														   value:[dic objectForKey:@"TableName"],@"strDWMC",[dic objectForKey:@"strDWMC"],@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    
    NSString *url = [NSString  stringWithFormat: kLedger_URL,g_appDelegate.ServerIP];
    
    WebServiceHelper *webService = [[[WebServiceHelper alloc] initWithUrl:url
                                                                   method:@"GetHistoryJsonList_Log_UDID"
                                                        view:self.view
                                                   nameSpace:@"http://tempuri.org/"
                                                               parameters:params
                                                                 delegate:self] autorelease];
    [webService run];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	
	if( [elementName isEqualToString:@"GetHistoryJsonList_Log_UDIDResult"])
	{
		self.currentdata = [NSMutableString string];
        
	}else if([elementName isEqualToString:@"faultcode"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"错误"
                              message:@"失败！"  delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [[[alert subviews] objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0.5 green:0.0f blue:0.0f alpha:1.0f]];
        [alert show];
        [alert release];
        
    }
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (_currentdata)
		[_currentdata appendString:string];
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
	if(_currentdata && [elementName isEqualToString:@"GetHistoryJsonList_Log_UDIDResult"])
	{
      NSString *jsonData = _currentdata;
      jsonData = [jsonData stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        id object = [NSJSONSerialization JSONObjectWithData:[jsonData dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSArray *arr = [NSArray arrayWithObject:(NSDictionary *)object];
            self.chooseAry = arr;
        }
        else if([object isKindOfClass:[NSArray class]]){
            self.chooseAry = (NSArray *)object;
        }
        else{
            self.chooseAry = [NSArray array];
        }
        
        [self.tableView reloadData];
	}
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)editButClick:(UIBarButtonItem *)sender{
   
    BOOL isedit = self.tableView.editing;
    if (isedit) {
        self.tableView.editing = NO;
        [sender setTitle:@"编辑"];
    }
    else{
        self.tableView.editing = YES;
        [sender setTitle:@"完成"];
    }
    
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (!_isGetHistory)
             return @"          企业名称                                                         检查人员与时间";
    else
           return @"          企业名称                                                              检查时间";
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [chooseAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    //cell = [UITableViewCell makeSubCell:tableView withTitle:titleValue SubValue1:@"" SubValue2:leftValue SubValue3:rightValue];
    NSUInteger row = indexPath.row;
     NSDictionary *dic = [chooseAry objectAtIndex:row];

    
    if (_isGetHistory) {
        NSString *mcStr = [dic objectForKey:@"DWMC"];
        if (mcStr == nil) {
            mcStr = [dic objectForKey:@"JSXMMC"];
        }
        cell.textLabel.text = mcStr;
        NSString *jcsjStr = [dic objectForKey:@"CJSJ"];
        cell.detailTextLabel.textAlignment = UITextAlignmentLeft;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",jcsjStr];
    }
    
    else{
        NSString *jcrStr = [dic objectForKey:@"JCR"];
        NSString *jcsjStr = [dic objectForKey:@"JCSJ"];
        cell.textLabel.text = [dic objectForKey:@"WRYMC"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@(%@)",jcrStr,jcsjStr];
    }
    
        
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    
    // Configure the cell...
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (_isGetHistory) {
        return NO;
    }
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    NSDictionary *dic = [chooseAry objectAtIndex:row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSString *bh = [dic objectForKey:@"XCZFBH"];
        NSString *mc = [dic objectForKey:@"WRYMC"];
        [[DBHelper sharedInstance] deleteRecordByXCZFBH:bh andTableName:blName andWRYMC:mc andType:type];
        self.chooseAry = [[DBHelper sharedInstance] queryRecordByWrymc:wrymc andTableName:blName TYPE:type];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSUInteger row = indexPath.row;
    if (_isGetHistory) {
        [delegate returnInfo:[chooseAry objectAtIndex:row]];
    }
    else{
        NSDictionary *dic = [chooseAry objectAtIndex:row];
        NSString *valueJson = [dic objectForKey:@"JSON"];
        NSData   *imageData = [dic objectForKey:@"SignName"];
        
        NSDictionary *dataInfo =  [NSJSONSerialization JSONObjectWithData:[valueJson dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if (imageData != nil) {
            
            [delegate returnInfo:imageData];

        }
        else {
            [delegate returnInfo:dataInfo];
        }
      
        

    }
   
}

@end
