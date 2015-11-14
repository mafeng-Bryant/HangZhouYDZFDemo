//
//  ContactListViewController.m
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-7-31.
//
//

#import "ContactListViewController.h"
#import "WebServiceHelper.h"
#import "GMEPS_HZAppDelegate.h"
#import "UserInfo.h"
#import "JSONKit.h"

extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;

@interface ContactListViewController ()

@end

@implementation ContactListViewController

- (void)dealloc {
   [_userAry release];
    [_branchAry release];
    [_contactStr release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.userAry = [NSMutableArray array];
        self.numberAry = [NSMutableArray array];
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [documentPath stringByAppendingPathComponent:@"contacts.plist"];
        self.branchAry = [NSArray arrayWithContentsOfFile:filePath];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"通讯录";
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshContacts)];
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneUserContacts)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = doneButton;
    
    [cancelButton release];
    [doneButton release];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    if (!_branchAry) {
        NSString *URL = [NSString  stringWithFormat: KLogIn_URL,g_appDelegate.ServerIP];
        NSString *method = @"GetAllUser_Phone";
        
        NSString *parameter = [WebServiceHelper createParametersWithKey:@"userName" value:g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
        
        WebServiceHelper *webService = [[[WebServiceHelper alloc] initWithUrl:URL
                                                                       method:method
                                                                         view:self.tableView nameSpace:KSoapNameSpace parameters:parameter
                                                                     delegate:self] autorelease];
        webService.hudTitle =@"正在获取通讯录，请稍候...";
        [webService run];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_branchAry count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *bmDict =[_branchAry objectAtIndex:section];
    NSArray      *userAry = [bmDict objectForKey:@"USERS"];
    
    return [userAry count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *bmDict =[_branchAry objectAtIndex:section];
    NSString *bmMC = [bmDict objectForKey:@"BMMC"];
    return bmMC;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    NSDictionary *bmDict = [_branchAry objectAtIndex:section];
    NSArray *userAry = [bmDict objectForKey:@"USERS"];
    NSDictionary *userDict = [userAry objectAtIndex:row];
    
    NSString *userName = [userDict objectForKey:@"YHMC"];
    NSString *userNumber   = [userDict objectForKey:@"YHSJ"];
    
    cell.textLabel.text = userName;
    cell.detailTextLabel.text = userNumber;
    if ([_numberAry containsObject:userNumber]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *bmDict = [_branchAry objectAtIndex:indexPath.section];
    NSArray *userAry = [bmDict objectForKey:@"USERS"];
    NSDictionary *userDict = [userAry objectAtIndex:indexPath.row];
    
    NSString *userName = [userDict objectForKey:@"YHMC"];
    NSString *userNumber = [userDict objectForKey:@"YHSJ"];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [_userAry removeObject:userName];
        [_numberAry removeObject:userNumber];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [_userAry addObject:userName];
        [_numberAry addObject:userNumber];
    }
}

#pragma mark - UISearchBar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *filePath = [documentPath stringByAppendingPathComponent:@"contacts.plist"];
        
        self.branchAry = [NSArray arrayWithContentsOfFile:filePath];
    }
    
    else
    {
        self.branchAry = [self search:searchText source:_branchAry];
    }
    
    [self.tableView reloadData];

}

- (NSArray *)search:(NSString *)searchTxt source:(NSArray *)dataSource {
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (NSDictionary *bmInfo in dataSource) {
        NSMutableDictionary *bmDict = [NSMutableDictionary dictionary];
        NSString *bmBH = [bmInfo objectForKey:@"BMBH"];
        NSString *bmMC = [bmInfo objectForKey:@"BMMC"];
        
        if ([bmMC rangeOfString:searchTxt].location != NSNotFound) {
            [dataArray addObject:bmInfo];
            
            break;
        }
        else {
            NSArray *userAry = [bmInfo objectForKey:@"USERS"];
            NSMutableArray *users = [NSMutableArray array];
            for (NSDictionary *userDict in userAry) {
                NSString *userName = [userDict objectForKey:@"YHMC"];
                NSString *userNumber   = [userDict objectForKey:@"YHSJ"];
                if ([userName rangeOfString:searchTxt].location != NSNotFound || [userNumber rangeOfString:searchTxt].location != NSNotFound) {
                    [users addObject:userDict];
                }
            }
            
            if ([users count] >=1) {
                [bmDict setObject:bmBH forKey:@"BMBH"];
                [bmDict setObject:bmMC forKey:@"BMMC"];
                [bmDict setObject:users forKey:@"USERS"];
                [dataArray addObject:bmDict];
            }
            
        }
        
        
    }
    
    return dataArray;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Action Methods 
- (void)refreshContacts{
    NSString *URL = [NSString  stringWithFormat: KLogIn_URL,g_appDelegate.ServerIP];
    NSString *method = @"GetAllUser_Phone";
    
    NSString *parameter = [WebServiceHelper createParametersWithKey:@"userName" value:g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    
    WebServiceHelper *webService = [[[WebServiceHelper alloc] initWithUrl:URL
                                                                   method:method
                                                                     view:self.tableView nameSpace:KSoapNameSpace parameters:parameter
                                                                 delegate:self] autorelease];
    webService.hudTitle =@"正在更新通讯录，请稍候...";
    [webService run];

}

- (void)DoneUserContacts{
    NSLog(@"_numberAry:%@",_numberAry);
    NSMutableString *nameStr = [NSMutableString stringWithCapacity:1];
  
    for (NSString *name in _userAry) {
        if ([nameStr length] < 1) {
            [nameStr appendString:name];
        }
        else {
            [nameStr appendFormat:@",%@",name];
        }
    }
    [_contactDelegate returnContacts:nameStr Numbers:_numberAry];
    
}



#pragma mark -
#pragma mark NSXMLParser Delegate
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"GetAllUser_PhoneResult"]) {
        self.currentData = [NSMutableString string];
    }
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (_currentData) {
        [_currentData appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"GetAllUser_PhoneResult"]) {
       NSArray *dataAry =  [[_currentData objectFromJSONString] copy];
        self.branchAry = dataAry;
        [dataAry release];
        NSString *documnetPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *filePath = [documnetPath stringByAppendingPathComponent:@"contacts.plist"];
        
        [dataAry writeToFile:filePath atomically:YES];
        
        
        
         [self.tableView reloadData];
    }
     

}

@end
