//
//  SelectJcsyViewController.m
//  GMEPS_HZ
//
//  Created by 张仁松 on 13-4-19.
//
//

#import "SelectJcsyViewController.h"
#import "GGDMJConfig.h"

@interface SelectJcsyViewController ()
@property(nonatomic,retain)NSArray *aryItems;
@property(nonatomic,retain)NSMutableArray *aryChecked;
@end

@implementation SelectJcsyViewController
@synthesize jcsyStr;
@synthesize aryItems,aryChecked,delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [aryChecked release];
    [aryItems release];
    [jcsyStr release];
    [super dealloc];
}

-(void)okBtnPress:(id)sender{
    NSMutableArray *aryDMNR = [NSMutableArray arrayWithCapacity:4];
    NSMutableArray *aryDM = [NSMutableArray arrayWithCapacity:4];
    for(NSString *jcsy  in aryChecked){
        NSInteger row = [aryItems indexOfObject:jcsy];
        NSString *dmnr = [aryItems objectAtIndex:row];
        if([dmnr length] >0){
            [aryDMNR addObject: dmnr];
            [aryDM addObject:[GGDMJConfig getDMByDMJBH:@"JCSY" andDMNR:dmnr]];
        }
            
    }
    [delegate returnJCSYDMNRs:aryDMNR andDMZs:aryDM];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.aryItems = [GGDMJConfig getDMNRByDMJBH:@"JCSY"];
    self.aryChecked = [NSMutableArray arrayWithCapacity:3];
    
    NSRange range = [jcsyStr rangeOfString:@","];
    NSArray *jcsyAry = nil;
    if (range.location != NSNotFound) {
        jcsyAry =  [jcsyStr componentsSeparatedByString:@","];
        for (NSString *jcsy in jcsyAry) {
            [aryChecked addObject:jcsy];
        }

    }
    else {
        if (![jcsyStr isEqualToString:@""]) {
             [aryChecked addObject:jcsyStr];
        }
       
    }
    
        
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(okBtnPress:)] autorelease];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [aryItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSString *str = [aryItems objectAtIndex:indexPath.row];
    cell.textLabel.text = str;
    // Configure the cell...
    if ([aryChecked containsObject:str]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];
    NSString *str=cell.textLabel.text;
        if ([aryChecked containsObject:str]) {
        [aryChecked removeObject:str];
    }else
        [aryChecked addObject:str];
    [tableView reloadData];
    
   
}

@end
