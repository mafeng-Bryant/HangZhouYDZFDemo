    //
//  UIChargeController.m
//  EPad
//
//  Created by chen on 11-6-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIChargeController.h"
#import "UIChargeDetailController.h"
#import "GMEPS_HZAppDelegate.h"
extern sqlite3 *data_db;

@implementation UIChargeController
@synthesize myTableView;
@synthesize dataFGBH,dataFGMC,dataWJMC,dataSFML,dataFGDH;
@synthesize _searchBar,saveFGMC,allInfo,isSelect,isExisSelect,viewTitle;
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


-(void)searchByFIDH:(id)strFIDH root:(id)rootMl{
    self.title =  self.viewTitle = rootMl;
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM FLFG WHERE FIDH = '%@' AND ORGID= 330100 order by FGBH",strFIDH];
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);  
	const char *utfsql = [sqlStr cStringUsingEncoding:enc];
	////NSLog(sqlStr);
	sqlite3_stmt *statement; 
	if (sqlite3_prepare_v2(data_db, utfsql, -1, &statement, nil)==SQLITE_OK) 
    { 
		//NSLog(@"select ok."); 
        
	}
    char *name;
	NSString *text;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:20];
	[dataFGBH removeAllObjects];
	[dataFGMC removeAllObjects];
	[dataSFML removeAllObjects];
	[dataWJMC removeAllObjects];
    [saveFGMC removeAllObjects];
    [allInfo removeAllObjects];
	while (sqlite3_step(statement)==SQLITE_ROW) { 
        
		name=(char *)sqlite3_column_text(statement,0 ); 
        if (name == NULL) {
			[dic setObject:@"" forKey:@"FGBH"];
		}
        else
        {
            text = [NSString stringWithCString:name  encoding:enc];
            NSString *copyText = [text copy];
            [dataFGBH addObject:copyText];
            [dic setObject:text forKey:@"FGBH"];
            [copyText release];
        }
        
        name=(char *)sqlite3_column_text(statement,1 ); 
        if (name == NULL) {
			[dic setObject:@"" forKey:@"FGMC"];
		}
        else
        {
            text = [NSString stringWithCString:name  encoding:enc];
             NSString *copyText = [text copy];
            [dataFGMC addObject:copyText];
            [dic setObject:text forKey:@"FGMC"];
            [copyText release];
        }
        
        name=(char *)sqlite3_column_text(statement,3 ); 
        if (name == NULL) {
			[dic setObject:@"" forKey:@"SFML"];
		}
        else
        {
            text = [NSString stringWithCString:name  encoding:enc];
             NSString *copyText = [text copy];
            [dataSFML addObject:copyText];
            [dic setObject:text  forKey:@"SFML"];
            [copyText release];
        }
        
        name=(char *)sqlite3_column_text(statement,6 ); 
        if (name == NULL) {
			[dic setObject:@"" forKey:@"WJMC"];
		}
        else
        {
            text = [NSString stringWithCString:name  encoding:enc];
             NSString *copyText = [text copy];
            [dataWJMC addObject:copyText];
            [dic setObject:text forKey:@"WJMC"];
            [copyText release];
        }
        
        NSDictionary *copyDic = [dic copy];
        [allInfo addObject:copyDic];
        [copyDic release];
	}
    
    saveFGMC = [dataFGMC mutableCopy];
	//NSLog(@"zuixin:%@",allInfo);
	sqlite3_finalize(statement);
	
	[self.myTableView reloadData];    


}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    isExisSelect = NO;
    //self.title = @"法律法规";
    //  UIBarButtonItem *aButton = [[UIBarButtonItem alloc]initWithTitle:@"名称查询" style:UIBarButtonItemStylePlain target:self action:@selector(selectFGMC:)];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 0.0)];
    _searchBar.delegate = self;
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:_searchBar];
    self.navigationItem.rightBarButtonItem = searchItem;
    [searchItem release];
    
    myTableView.rowHeight = 60;
    NSMutableArray *ary0 = [[NSMutableArray alloc] initWithCapacity:130];	
	self.dataFGBH = ary0;
	[ary0 release];
	
	NSMutableArray *ary1 = [[NSMutableArray alloc] initWithCapacity:130];	
	self.dataFGMC = ary1;
	[ary1 release];
	
	NSMutableArray *ary2 = [[NSMutableArray alloc] initWithCapacity:130];	
	self.dataSFML = ary2;
	[ary2 release];
	
	NSMutableArray *ary3 = [[NSMutableArray alloc] initWithCapacity:130];	
	self.dataWJMC = ary3;
	[ary3 release];
    
    NSMutableArray *ary4 = [[NSMutableArray alloc] initWithCapacity:130];	
	self.saveFGMC = ary4;
	[ary4 release];
    
    NSMutableArray *ary5 = [[NSMutableArray alloc] initWithCapacity:130];	
	self.allInfo = ary5;
	[ary5 release];
	[self.navigationController setNavigationBarHidden:NO animated:YES];	
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [dataFGMC count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int index = [indexPath row];
    
   
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    // Configure the cell...
  //  NSString *image = [NSString stringWithFormat:@"mc_%d",indexPath.row];
  //  cell.imageView.image = [UIImage imageNamed:image];

    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(index%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
    UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
    cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
    cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    cell.backgroundView.frame = cell.bounds;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:22];
    
    if (isSelect == YES) {
        NSMutableDictionary *dic = [dataFGMC objectAtIndex:index];
        cell.textLabel.text = [dic objectForKey:@"FGMC"];
    }
    else
    {
        cell.textLabel.text = [dataFGMC objectAtIndex:index];
    }
    
    //    cell.detailTextLabel.text = [NSString stringWithFormat:@"共%d个",[dataFGBH count]];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = nil;
    //NSLog(@"FD%@",dataFGMC);
    NSString *boolStr = [dataSFML objectAtIndex:[indexPath row]];
	BOOL bHasChild = [boolStr boolValue];
    if (isSelect == NO) 
    {
        if (bHasChild) 
        {
            UIChargeController *detailViewController = [[UIChargeController alloc] initWithNibName:@"UIChargeController" bundle:nil];
            //	detailViewController.title = [dataFGMC objectAtIndex:indexPath.row];
            // Pass the selected object to the new view controller.
            [self.navigationController pushViewController:detailViewController animated:YES];
            [detailViewController searchByFIDH:[dataFGBH objectAtIndex:[indexPath row]] root:[dataFGMC objectAtIndex:indexPath.row]];
            [detailViewController release];
        }
        else
        {
            UIChargeDetailController *detailViewController = [[UIChargeDetailController alloc] initWithNibName:@"UIChargeDetailController" bundle:nil];
            detailViewController.title = [dataFGMC objectAtIndex:indexPath.row];
            // Pass the selected object to the new view controller.
            [self.navigationController pushViewController:detailViewController animated:YES];
            [detailViewController loadHtmlFile:[dataWJMC objectAtIndex:[indexPath row]]];
            [detailViewController release];
            
        }
        
    }
    else
    {
        dic = [dataFGMC objectAtIndex:indexPath.row];
        if (bHasChild) 
        {
            UIChargeController *detailViewController = [[UIChargeController alloc] initWithNibName:@"UIChargeController" bundle:nil];
            //	detailViewController.title = [dataFGMC objectAtIndex:indexPath.row];
            // Pass the selected object to the new view controller.
            [self.navigationController pushViewController:detailViewController animated:YES];
            [detailViewController searchByFIDH:[dic objectForKey:@"FGBH"] root:[dic objectForKey:@"FGMC"]];
            [detailViewController release];
        }
        else
        {
            UIChargeDetailController *detailViewController = [[UIChargeDetailController alloc] initWithNibName:@"UIChargeDetailController" bundle:nil];
            detailViewController.title = [dic objectForKey:@"FGMC"];
            // Pass the selected object to the new view controller.
            [self.navigationController pushViewController:detailViewController animated:YES];
            NSLog(@"%@",[dic objectForKey:@"WJMC"]);
            [detailViewController loadHtmlFile:[dic objectForKey:@"WJMC"]];
            [detailViewController release];
            
        }
        
    }
	
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    isSelect =YES;
    [dataFGMC removeAllObjects];
    if ([searchText isEqualToString:@""]) {
        NSMutableArray *mutableInfoAry = [allInfo mutableCopy];
        self.dataFGMC = mutableInfoAry;
        [self.myTableView reloadData];
        [mutableInfoAry release];
        return;
    }
    int dataCount = [allInfo count];
    NSDictionary *dic;
    NSString *tmp;
    for (int i = 0; i < dataCount; i++) {
        dic = [allInfo objectAtIndex:i];
        tmp = [saveFGMC objectAtIndex:i];
        if ([tmp rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound) {
            NSDictionary *copyDic = [dic copy];
            [dataFGMC addObject:copyDic];
            [copyDic release];
            
        }
    }
    [self.myTableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
}


- (void)dealloc {
	[myTableView release];
    [super dealloc];
}


@end
