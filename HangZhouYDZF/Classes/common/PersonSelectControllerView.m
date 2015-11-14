//
//  PersonSelectControllerView.m
//  GMEPS_HZ
//
//  Created by Apple on 12-3-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PersonSelectControllerView.h"
#import "UserInfo.h"
#import "WebServiceHelper.h"

#import "GMEPS_HZAppDelegate.h"
#import "SharedInformations.h"
//#import "DepartmentSelectControllerView.h"
extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;

@implementation PersonSelectControllerView
@synthesize dicPersonInfomation,aryDanWei,dicPersonAll,dicPersonYHMC;
@synthesize surePersonAry,delegate1;
@synthesize updateBtn;

-(void)dealloc
{
    [dicPersonInfomation release];
    [dicPersonAll release];
    [dicPersonYHMC release];
    [aryDanWei release];
    [curData release];
    [webService release];
    [super dealloc];
}

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

//存储按照顺序传过来的单位数组
-(NSString*)personDanweiArypath{
	NSString* documentsDirectory  = [NSHomeDirectory() 
									 stringByAppendingPathComponent:@"Documents//"];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"personInfolist_ary.plist"];
	return filePath;
	
}

//存储按照顺序传过来的单位数组
-(NSString*)personDepartmentpath{
	NSString* documentsDirectory  = [NSHomeDirectory() 
									 stringByAppendingPathComponent:@"Documents//"];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"personlist_Department.plist"];
	return filePath;
	
}

//人员列表存储路径
-(NSString*)personListpath{
	NSString* documentsDirectory  = [NSHomeDirectory() 
									 stringByAppendingPathComponent:@"Documents//"];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"personInfolist.plist"];
	return filePath;
	
}

//人员字典对应存储路径
-(NSString*)personDicListpath{
	NSString* documentsDirectory  = [NSHomeDirectory() 
									 stringByAppendingPathComponent:@"Documents//"];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"personInfoDiclist.plist"];
	return filePath;
	
}


-(void)updatePersonInfoFromWeb{
    updateBtn.enabled = NO;

    curData = [[NSMutableString alloc] initWithCapacity:100];
    self.dicPersonInfomation = [NSMutableDictionary dictionaryWithCapacity:300];
    self.dicPersonAll = [NSMutableDictionary dictionaryWithCapacity:300];
    self.dicPersonYHMC = [NSMutableDictionary dictionaryWithCapacity:300];
    self.aryDanWei = [NSMutableArray arrayWithCapacity:50];
    [self.tableView reloadData];
    
    
    
    NSString *URL = [NSString stringWithFormat: KLogIn_URL,g_appDelegate.ServerIP];
    NSString* params = [WebServiceHelper createParametersWithKey:@"userName"
                          value:g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    webService = [[WebServiceHelper alloc] initWithUrl:URL
             method:@"GetAllUserInfo_Log_UDID"
                                                                     view:self.view           nameSpace:KSoapNameSpace
                                                               parameters:params 
                                                                 delegate:self];
	webService.hudTitle = @"正在更新人员列表，请稍候...";
    [webService run];
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //[self updatePersonInfoFromWeb];
    self.tableView.backgroundColor = [UIColor whiteColor];
    if (self.aryDanWei == nil||[self.aryDanWei count]==0)
    {
        UIBarButtonItem *aButton1 = [[UIBarButtonItem alloc] initWithTitle:@"更新人员列表" style:UIBarButtonItemStyleDone  
                                                                target:self action:@selector(updatePersonInfoFromWeb)];
    
        self.navigationItem.rightBarButtonItem = aButton1;	
        updateBtn = aButton1;
        [aButton1 release];
        self.title = @"杭州市环境保护局";
    }
    
    self.dicPersonInfomation = [NSMutableDictionary dictionaryWithContentsOfFile:[self personListpath]];
    self.dicPersonAll = [NSMutableDictionary dictionaryWithContentsOfFile:[self personDepartmentpath]];
    self.dicPersonYHMC = [NSMutableDictionary dictionaryWithContentsOfFile:[self personDicListpath]];

    if (self.aryDanWei == nil||[self.aryDanWei count]==0) {
        self.aryDanWei = [NSMutableArray arrayWithContentsOfFile:[self personDanweiArypath]];
    }
   
   if (dicPersonAll == nil || [dicPersonAll count]==0
        ) {
        [self updatePersonInfoFromWeb];
    
   }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self.navigationController setNavigationBarHidden:NO animated:YES];	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}



#define TAG_YHID  1
#define TAG_YHMC  2  
#define TAG_BMMC  3  
#define TAG_BMBH  4  
#define TAG_ZFZJBH   5  
#define TAG_YHLX   6  
#define TAG_FSHBJ   7
#define TAG_PHONE  8
/*
 <YHID>zhouzaina</YHID>
 <YHMC>周再纳</YHMC>
 <BMBH>15</BMBH>
 <BMMC>监察支队</BMMC>
 <ZFZJBH>0100160315</ZFZJBH>   
 <YHLX></YHLX> //用户类型
 */
- (void)parserDidStartDocument:(NSXMLParser *)parser {
	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{	
    
	if ([elementName isEqualToString:@"YHID"])
		nParserStatus = TAG_YHID;	
	else if ([elementName isEqualToString:@"YHMC"])
		nParserStatus = TAG_YHMC;
	else if ([elementName isEqualToString:@"BMMC"])
		nParserStatus = TAG_BMMC;
	else if ([elementName isEqualToString:@"BMBH"])
		nParserStatus = TAG_BMBH;
	else if ([elementName isEqualToString:@"ZFZJBH"])
		nParserStatus = TAG_ZFZJBH;
    else if ([elementName isEqualToString:@"YHLX"])
		nParserStatus = TAG_YHLX;
    else if ([elementName isEqualToString:@"FSHBJ"])
		nParserStatus = TAG_FSHBJ;
    else if ([elementName isEqualToString:@"PHONE"])
        nParserStatus = TAG_PHONE;
    else if ([elementName isEqualToString:@"TmpName"]) {
		aValueDicnary = [[NSMutableDictionary alloc] initWithCapacity:6];        
	}
	else {
		nParserStatus = -1;
	}
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (curData) 
		[curData appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	
	if (nParserStatus >=0 && aValueDicnary) {
		switch (nParserStatus) {
                
			case TAG_YHID: {
                NSString *copyCurData = [curData copy];
				[aValueDicnary setObject:copyCurData forKey:@"YHID"];
                [copyCurData release];
            }
				break;
			case TAG_YHMC: {
                
                NSString *copyCurData = [curData copy];
				[aValueDicnary setObject:copyCurData forKey:@"YHMC"];
                [copyCurData release];
            }
				break;
			case TAG_BMMC:{
                
                NSString *copyCurData = [curData copy];
				[aValueDicnary setObject:copyCurData forKey:@"BMMC"];
                [copyCurData release];

            }
				break;
			case TAG_BMBH: {
                NSString *copyCurData = [curData copy];
				[aValueDicnary setObject:copyCurData forKey:@"BMBH"];
                [copyCurData release];
            }
				break;
			case TAG_ZFZJBH:{
                NSString *copyCurData = [curData copy];
				[aValueDicnary setObject:copyCurData forKey:@"ZFZJBH"];
                [copyCurData release];
            }
				break;
            case TAG_YHLX:{
                NSString *copyCurData = [curData copy];
				[aValueDicnary setObject:copyCurData forKey:@"YHLX"];
                [copyCurData release];
            }
                
				break;
            case TAG_FSHBJ: {
                NSString *copyCurData = [curData copy];
				[aValueDicnary setObject:copyCurData forKey:@"FSHBJ"];
                [copyCurData release];
            }
				break;
            case TAG_PHONE: {
                NSString *copyCurData = [curData copy];
				[aValueDicnary setObject:copyCurData forKey:@"PHONE"];
                [copyCurData release];
        
            }
				break;
                
            default:
				break;
		}
       
		nParserStatus = -1;
	} 
    else if (aValueDicnary && [elementName isEqualToString:@"TmpName"]){
            NSString *fshbj = [aValueDicnary objectForKey:@"FSHBJ"];
            NSString *yhmc = [aValueDicnary objectForKey:@"YHMC"];
            NSString *bmmc = [aValueDicnary objectForKey:@"BMMC"];
           
            if(fshbj==nil || [fshbj isEqualToString:@""] || yhmc==nil || [yhmc isEqualToString:@""] || bmmc==nil || [bmmc isEqualToString:@""]){
                 NSLog(@"%@..%@..%@",fshbj,yhmc,bmmc);
                return;
            }
                
            
           
            NSMutableArray *personAry = [dicPersonInfomation objectForKey:fshbj];
            NSMutableArray *personAry1 = [dicPersonAll objectForKey:bmmc];
            NSMutableArray *personAry2 = [dicPersonYHMC objectForKey:yhmc];
            if (personAry) {
                [personAry addObject:aValueDicnary];
            }
			else {
				personAry = [[NSMutableArray alloc] initWithObjects:aValueDicnary,nil];
				
				[dicPersonInfomation setObject:personAry forKey:fshbj];
				[personAry release];
                [aryDanWei addObject:fshbj];
                
			}
            
            if (personAry1) {
                [personAry1 addObject:aValueDicnary];
            }
			else {
				personAry1 = [[NSMutableArray alloc] initWithObjects:aValueDicnary,nil];
				
				[dicPersonAll setObject:personAry1 forKey:bmmc];
				[personAry1 release];
                
			}
            if (personAry2) {
                [personAry2 addObject:aValueDicnary];
                
            }
            else{
				personAry2 = [[NSMutableArray alloc] initWithObjects:aValueDicnary,nil];
				
				[dicPersonYHMC setObject:personAry2 forKey:yhmc];
				[personAry2 release];
            }
            
			
            [aValueDicnary release];
	}
	[curData setString:@""];
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [aryDanWei insertObject:@"监察支队" atIndex:0];
    [aryDanWei removeObject:@"杭州市环境保护局"];
    [curData release];
    [self.dicPersonInfomation writeToFile:[self personListpath] atomically:YES];
    [self.aryDanWei writeToFile:[self  personDanweiArypath] atomically:YES];
    [self.dicPersonAll writeToFile:[self personDepartmentpath] atomically:YES];
    [self.dicPersonYHMC writeToFile:[self personDicListpath] atomically:YES];
    [self.tableView reloadData];

    updateBtn.enabled = YES;
    //[self initializeSectionDatas];
}


//获取选择打钩的人员信息
//sure为no时表示一选择人员就把值传过来，为yes表示点击确定按钮
-(void)returnChoosePersons:(NSMutableArray*)aryPersons isSure:(BOOL)sure
{
    SharedInformations *info = [SharedInformations sharedSharedInformations];
    info.people = aryPersons;
    if (sure == YES) {
        [delegate1 returnPersons:info.people];//为yes时表示点击确定按钮把选择到的人员传过去
    }
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.aryDanWei count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [self.aryDanWei objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SharedInformations *info = [SharedInformations sharedSharedInformations];
    NSArray *ary = [dicPersonInfomation objectForKey:[aryDanWei objectAtIndex:indexPath.row]];
    NSMutableArray *ary1 = [[NSMutableArray alloc] initWithCapacity:10];
    //根据FSHBJ获取对应的部门或者人员
    for (int i = 0; i < [ary count]; i++) {
        NSDictionary *dic = [ary objectAtIndex:i];
        BOOL isSame = [ary1 containsObject:[dic objectForKey:@"BMMC"]];
        if (isSame == NO) 
            [ary1 addObject:[dic objectForKey:@"BMMC"]];
    }
    //根据部门获取打人员信息
    NSArray *ary2 = [dicPersonAll objectForKey:[aryDanWei objectAtIndex:indexPath.row]];
    NSMutableArray *ary3 = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < [ary2 count]; i++) {
        NSDictionary *dic = [ary2 objectAtIndex:i];
        BOOL isSame = [ary3 containsObject:[dic objectForKey:@"YHMC"]];
        if (isSame == NO) 
            [ary3 addObject:[dic objectForKey:@"YHMC"]];
    }
    
    //如果还有子部门，则执行if里的代码，如果没有子部门，直接是人员就执行else里的代码
    if ([ary3 count]==0) {
        
        NSMutableArray *copyAry1 = [ary1 mutableCopy];
        PersonSelectControllerView *controller = [[PersonSelectControllerView alloc] initWithStyle:UITableViewStyleGrouped];
        controller.contentSizeForViewInPopover = CGSizeMake(350, 700);
        
        controller.aryDanWei = copyAry1;
        controller.delegate1 = delegate1;
        controller.surePersonAry = info.people;
        controller.dicPersonAll = self.dicPersonAll;
        controller.dicPersonInfomation = self.dicPersonInfomation;
        controller.dicPersonYHMC = self.dicPersonYHMC;
        //controller.updateBtn.enabled = NO;
        
         controller.title = [aryDanWei objectAtIndex:indexPath.row];
        
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
        [copyAry1 release];
    }
    else
    {
        NSMutableArray *copyAry3 = [ary3 mutableCopy];
        
        choosePersonControllerView *controller = [[choosePersonControllerView alloc] initWithStyle:UITableViewStyleGrouped];
        controller.contentSizeForViewInPopover = CGSizeMake(350, 700);
        controller.aryDanwei = [[[NSMutableArray alloc] initWithCapacity:100] autorelease];
        controller.dicPersonAll = [NSMutableDictionary dictionaryWithCapacity:300];
        controller.dicPersonAll = self.dicPersonYHMC;
        controller.delegate = self;
       
        controller.title = [self.aryDanWei objectAtIndex:indexPath.row];
        self.surePersonAry = info.people;
        NSMutableArray *copyPersonAry = [self.surePersonAry mutableCopy];
        //controller.arySectionPerson = [info.people mutableCopy];
        controller.arySectionPerson = copyPersonAry;
        controller.aryDanwei = copyAry3;
        //[controller initializeSectionDatas];
        
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
        [copyAry3 release];
        [copyPersonAry release];

    }
    [ary1 release];
    [ary3 release];
    [self.tableView reloadData];
}

@end
