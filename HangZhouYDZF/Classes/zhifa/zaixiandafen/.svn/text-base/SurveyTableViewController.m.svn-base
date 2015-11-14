//
//  SurveyTableViewController.m
//  GMEPS_HZ
//
//  Created by ZHONGWEN on 13-6-4.
//
//

#import "SurveyTableViewController.h"
#define Salmon 250/255,128/255,114/255
@interface SurveyTableViewController ()


@end

@implementation SurveyTableViewController

- (void)dealloc {
    [_elementAry  release];
    [_standardAry release];
    [_actuallyAry   release];
    [_tableView   release];
    [_headerTitle release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.elementAry = [NSArray arrayWithObjects:@"SO2",@"NOX",@"CO2",@"NOx",@"H2SO4",@"NO",nil];
//        self.standardAry = [NSArray arrayWithObjects:@"SO2",@"NOX",@"CO2",@"NOx",@"H2SO4",@"NO",nil];
//        self.actuallyAry = [NSArray arrayWithObjects:@"SO2",@"NOX",@"CO2",@"NOx",@"H2SO4",@"NO",nil];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -\
#pragma mark UITableView DataSource 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        UILabel *elementLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 94, 44)];
        elementLabel.textAlignment = UITextAlignmentCenter;
        elementLabel.backgroundColor =
         [UIColor colorWithRed:154.0/255.0 green:205.0/255.0 blue:50.0/255.0 alpha:1.0];
        elementLabel.tag = 101;
        UILabel *standardLabel = [[UILabel alloc] initWithFrame:CGRectMake(96, 0, 94, 44)];
        standardLabel.textAlignment = UITextAlignmentCenter;
        standardLabel.backgroundColor =[UIColor colorWithRed:250.0/255.0 green:128.0/255.0 blue:114.0/255.0 alpha:1.0];
        standardLabel.tag = 102;
        UILabel *actualLabel = [[UILabel alloc] initWithFrame:CGRectMake(192, 0, 94, 44)];
        actualLabel.textAlignment = UITextAlignmentCenter;
        actualLabel.backgroundColor = [UIColor colorWithRed:1.0 green:140.0/255.0 blue:0.0 alpha:1.0];
        actualLabel.tag = 103;
        
        [cell.contentView addSubview:elementLabel];
        [cell.contentView addSubview:standardLabel];
        [cell.contentView addSubview:actualLabel];
        
        [elementLabel release];
        [standardLabel release];
        [actualLabel release];
    }
    
//    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
//    UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
//    cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
    
    UILabel *element = (UILabel *)[cell.contentView viewWithTag:101];
    element.text = [_elementAry objectAtIndex:indexPath.row];
    
    UILabel *standard = (UILabel *)[cell.contentView viewWithTag:102];
    standard.text = [_standardAry objectAtIndex:indexPath.row];

    UILabel *actually = (UILabel *)[cell.contentView viewWithTag:103];
    actually.text = [_actuallyAry objectAtIndex:indexPath.row];

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
     return _headerTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [_elementAry count];
}

@end
