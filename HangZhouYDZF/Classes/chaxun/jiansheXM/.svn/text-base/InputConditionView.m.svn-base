    //
//  InputConditionView.m
//  RetrieveExamine
//
//  Created by hejunhua on 11-9-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InputConditionView.h"
#import "ExamineDetailsView.h"
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation InputConditionView
@synthesize infoItem,infoArr,segValue,webservice,currentString,xmmc,startDate,endDate,xzqh,sftg,makeSure;
@synthesize popController,dateController,listTableView,refreshSpinner;
@synthesize wordsSelectViewController,wordsPopoverController;

- (IBAction)backgroundTag:(id)sender {
	[xmmc resignFirstResponder];
	[startDate resignFirstResponder];
	[endDate resignFirstResponder];
	[xzqh resignFirstResponder];
}

- (IBAction)segChanged:(id)sender {
	UISegmentedControl *aSegment = (UISegmentedControl *)sender;
	self.segValue = [NSString stringWithFormat:@"%d",[aSegment selectedSegmentIndex]];
}

-(IBAction)touchFromDate:(id)sender{
	UIControl *btn =(UIControl*)sender;
	[popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	currentTag = btn.tag;
}

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date{ 
	[popController dismissPopoverAnimated:YES];
	if (bSaved) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
		NSString *dateString = [dateFormatter stringFromDate:date];
		[dateFormatter release];  
		
		switch (currentTag) {
			case 1:				
				startDate.text = dateString;
				break;
			case 2:
				endDate.text = dateString;
				break;
				
			default:
				break;
		}
	}
    else{
        switch (currentTag) {
			case 1:				
				startDate.text = @"";
				break;
			case 2:
				endDate.text = @"";
				break;
				
			default:
				break;
        }
    }
}

- (IBAction)makeSurePressed:(id)sender {
	if (infoArr)
		[infoArr removeAllObjects];
	
    isEnd = NO;

    currentPageIndex = 1;
    self.listTableView.hidden = YES;
	//xmmcValue
	NSString *xmmcValue = [[NSString alloc] initWithString:xmmc.text];

	
	//startDateValue
	NSString *startDateValue = [[NSString alloc] initWithString:startDate.text];

	
	//endDataValue
	NSString *endDateValue = [[NSString alloc] initWithString:endDate.text];

	
	//xzqhValue
	NSString *xzqhValue = [[NSString alloc] initWithString:xzqh.text];
    
    //sftgValue
    //self.segValue = [NSString stringWithFormat:@"%d",sftg.selectedSegmentIndex];
	
    isLoading = YES;

	NSString *param = [WebServiceHelper createParametersWithKey:@"xmmc" value:xmmcValue, @"startDate", startDateValue, @"endDate", endDateValue, @"xzqh", xzqhValue, @"sftg", segValue, @"page",@"1", nil];
    NSString *URL = [NSString  stringWithFormat: KExamine_URL,g_appDelegate.ServerIP];
	webservice = [[WebServiceHelper alloc] initWithUrl:URL
												method:@"RetrieveExaminelist"
                                                  view:self.view
											 nameSpace:@"http://tempuri.org/"
											parameters:param 
											  delegate:self];
    webservice.hudTitle = @"正在查询数据，请稍候...";
	[webservice run];
	
	[xmmcValue release];
	[startDateValue release];
	[endDateValue release];
	[xzqhValue release];
}

-(IBAction)beginEditing:(id)sender{
	UIControl *ctrl = (UIControl*)sender;
	CGRect rect;
	rect.origin.x = ctrl.frame.origin.x;	
	rect.origin.y = ctrl.frame.origin.y;
	rect.size.width = ctrl.frame.size.width;
	rect.size.height = ctrl.frame.size.height;
	[wordsSelectViewController.tableView reloadData];
	[self.wordsPopoverController presentPopoverFromRect:rect
												 inView:self.view
							   permittedArrowDirections:UIPopoverArrowDirectionAny
											   animated:YES];
}

- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row{
	
	xzqh.text = words;
	if (wordsPopoverController != nil) {
		[wordsPopoverController dismissPopoverAnimated:YES];
	}
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

- (void)viewDidLoad {
	
    [super viewDidLoad];
    self.title = @"建设项目审批查询";
	
	sftg.selectedSegmentIndex = 1;
	self.segValue = [NSString stringWithFormat:@"%d",sftg.selectedSegmentIndex];
    currentPageIndex = 1;
    
    isEnd = NO;
    
    xzqh.delegate = self;
    
    //refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //refreshSpinner.hidesWhenStopped = YES;
    
	PopupDateViewController *date = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
	self.dateController = date;
	dateController.delegate = self;
	[date release];
	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
	
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	//popController.delegate = self;
	[popover release];
	[nav release];
	
	CommenWordsViewController *tmpController = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
	tmpController.contentSizeForViewInPopover = CGSizeMake(320, 400);
	tmpController.delegate = self;
	tmpController.wordsAry = [NSArray arrayWithObjects:@"下沙区",@"上城区",
							@"下城区", @"江干区",@"拱墅区",@"西湖区",@"滨江区",@"萧山区",@"余杭区",@"桐庐县",@"淳安县",@"建德市",@"富阳市",@"临安市",@"西湖名胜风景区",nil];
    
    UIPopoverController *tmppopover = [[UIPopoverController alloc] initWithContentViewController:tmpController];
	self.wordsSelectViewController = tmpController;
    self.wordsPopoverController = tmppopover;
	
	[tmpController release];
    [tmppopover release];
	
    NSString *pageStr = [[NSString alloc] initWithFormat:@"%d",currentPageIndex];
	
    isLoading = YES;
    
    //[self.listTableView addSubview:refreshSpinner];
    //[refreshSpinner startAnimating];
      
	NSString *param = [WebServiceHelper createParametersWithKey:@"xmmc" value:@"", @"startDate", @"", @"endDate", @"", @"xzqh", @"", @"sftg", @"1", @"page",pageStr, nil];
    NSString *URL = [NSString  stringWithFormat: KExamine_URL,g_appDelegate.ServerIP];
	webservice = [[WebServiceHelper alloc] initWithUrl:URL
												method:@"RetrieveExaminelist"
                                                  view:self.view
											 nameSpace:@"http://tempuri.org/"
											parameters:param 
											  delegate:self];
    webservice.hudTitle = @"正在获取建设项目数据，请稍候...";
	[webservice run];
    [pageStr release];
}

-(void)viewDidAppear:(BOOL)animated{
	[xmmc resignFirstResponder];
	if (wordsPopoverController != nil) {
		[wordsPopoverController dismissPopoverAnimated:YES];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark TableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [infoArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.0;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"查询结果";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *ExamineListCellIdentifier = @"ExamineListCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExamineListCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ExamineListCellIdentifier] autorelease];
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 600, 30)];
        detailLabel.textAlignment = UITextAlignmentLeft;
        detailLabel.textColor = [UIColor grayColor];
        detailLabel.font = [UIFont systemFontOfSize:16];
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.tag = 101;
        
        [cell.contentView addSubview:detailLabel];
        [detailLabel release];

	}
	NSUInteger row = [indexPath row];
    if ([infoArr count]>0) {
        XMInfoItem *aItem = [infoArr objectAtIndex:row];
        cell.textLabel.font  = [UIFont systemFontOfSize:20];
        cell.textLabel.text = [NSString stringWithFormat:@"%d  %@",row+1,aItem.xmmc];
        
        if (!aItem.xzqh) {
            aItem.xzqh = @"";
        }
        
        UILabel *detailLabel = (UILabel *)[cell viewWithTag:101];
        detailLabel.text =[NSString stringWithFormat:@"审批日期：%@  行政区划：%@  是否通过审核：%@",aItem.sprq,aItem.xzqh,aItem.sftgsp];
        
        NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
        UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
        cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
        cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        cell.backgroundView.frame = cell.bounds;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    else {
        cell.textLabel.font  = [UIFont systemFontOfSize:20];
        cell.textLabel.text = @"没有找到满足查询条件的结果";
    }
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	
	if (isLoading) return;
    if (isEnd) return;
	
	//NSIndexPath *index = [NSIndexPath indexPathForRow:currentPageIndex *50+3 inSection:0];
	//UITableViewCell* cell = [self.listTableView cellForRowAtIndexPath:index];
	////NSLog(@"scrollViewDidScroll %d %f %f %f",currentPageIndex *PageSize,
	//	  scrollView.contentOffset.y,,cell.frame.origin.y);
	
    if (scrollView.contentSize.height - scrollView.contentOffset.y <= 850 ) {
        // Released above the header
		
	 isLoading = YES;
		
        currentPageIndex++;
        
        
        //xmmcValue
        NSString *xmmcValue = [[NSString alloc] initWithString:xmmc.text];

        
        //startDateValue
        NSString *startDateValue = [[NSString alloc] initWithString:startDate.text];

        
        //endDataValue
        NSString *endDateValue = [[NSString alloc] initWithString:endDate.text];
     
        
        //xzqhValue
        NSString *xzqhValue = [[NSString alloc] initWithString:xzqh.text];
        
       NSString *pageStr = [NSString stringWithFormat:@"%d",currentPageIndex];
       NSString *param = [WebServiceHelper createParametersWithKey:@"xmmc" value:xmmcValue,@"startDate",startDateValue,@"endDate",endDateValue, @"xzqh", xzqhValue, @"sftg",segValue,@"page",pageStr,nil];
        
        NSString *URL = [NSString  stringWithFormat: KExamine_URL,g_appDelegate.ServerIP];
        webservice = [[WebServiceHelper alloc] initWithUrl:URL
                                                    method:@"RetrieveExaminelist"
                                                      view:self.view
                                                 nameSpace:@"http://tempuri.org/"
                                                parameters:param 
                                                  delegate:self];
        webservice.hudTitle = @"正在加载更多建设项目数据，请稍候...";
        [webservice run];

        
        [xmmcValue release];
        [startDateValue release];
        [endDateValue release];
        [xzqhValue release];
    }
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	ExamineDetailsView *childView = [[ExamineDetailsView alloc] initWithNibName:@"ExamineDetailsView" bundle:nil];
    XMInfoItem *aItem = [infoArr objectAtIndex:row];
    NSString *aString = aItem.xhCode;
	[childView setXhCode:aString];
	[self.navigationController pushViewController:childView animated:YES];
    [childView release];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[infoItem release];
	[segValue release];
	[webservice release];
	[infoArr release];
	[currentString release];
	[xmmc release];
	[startDate release];
	[endDate release];
	[xzqh release];
	[sftg release];
	[makeSure release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSXMLParser Delegate Method

#define kXHCode 1
#define kCaseName 2
#define kExamineDate 3
#define kDistrict 4
#define kPassStatus 5

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = 0;
	bItem = NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
	if ([elementName isEqualToString:@"XH"])
		nParserStatus = kXHCode;
	else if ([elementName isEqualToString:@"XMMC"])
		nParserStatus = kCaseName;
	else if ([elementName isEqualToString:@"SPRQ"])
		nParserStatus = kExamineDate;
	else if ([elementName isEqualToString:@"XZQH"])
		nParserStatus = kDistrict;
	else if ([elementName isEqualToString:@"SFTGSP"])
		nParserStatus = kPassStatus;
	else if ([elementName isEqualToString:@"TmpName"])
	{
		bItem = YES;
		infoItem = [[XMInfoItem alloc] initWithNone];
	}
    else if ([elementName isEqualToString:@"tableTMP"])
        isEnd = YES;
	else 
		nParserStatus = 0;

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (nParserStatus > 0){
		self.currentString = [NSMutableString string];
		[currentString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	//NSString *aString;
	if (nParserStatus > 0){
		switch (nParserStatus) {
			case kXHCode:
				infoItem.xhCode = currentString;
				break;
				
			case kCaseName:
			{
				infoItem.xmmc = currentString;
			}
				break;

			case kExamineDate:
			{

				infoItem.sprq = [currentString substringToIndex:10];
			}
				break;
				
			case kDistrict:
			{
				infoItem.xzqh = currentString;
			}
				break;
				
			case kPassStatus:
			{
				if ([currentString isEqualToString:@"1"]) {
					infoItem.sftgsp = @"已通过审批";
				} else {
					
					infoItem.sftgsp = @"未通过审批";
				}

			}
				break;
                
			default:
				break;
		}
        
		nParserStatus = 0;
        currentString = nil;
	} else {
		if (bItem) {
			if (!infoArr)
			infoArr = [[NSMutableArray alloc] init];	
			[infoArr addObject:infoItem];
			
			infoItem = nil;
			bItem = NO;
		}
	}
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    self.listTableView.hidden = NO;
	if ([infoArr count]!=0){
        isLoading = NO;
        //[refreshSpinner stopAnimating];
		
		
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" 
														message:@"满足条件的审批项目不存在或输入条件格式有误！" 
													   delegate:nil 
											  cancelButtonTitle:@"确定" 
											otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
    [self.listTableView reloadData];
}

@end
