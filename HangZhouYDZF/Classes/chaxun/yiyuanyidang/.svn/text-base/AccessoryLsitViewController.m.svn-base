//
//  AccessoryLsitViewController.m
//  GMEPS_HZ
//
//  Created by TianZhuLi on 14-3-21.
//
//

#import "AccessoryLsitViewController.h"

@interface AccessoryLsitViewController ()

@end

@implementation AccessoryLsitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithAccessoryArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        [self setListArray:array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(gobackLastView)];
    self.navigationItem.title = @"附件列表";
    [self.listTableView reloadData];
}

-(void)gobackLastView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_listArray && [_listArray count] > 0) {
        return [_listArray count];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *AccessoryCellIdentifier = @"AccessoryCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AccessoryCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AccessoryCellIdentifier] autorelease];
	}
    if (_listArray && [_listArray count] > 0) {
        AccessoryItem *item = [_listArray objectAtIndex:indexPath.row];
        [cell.textLabel setText:[item fileName]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        [cell.textLabel setText:@"Sorry!There is no Accessory"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;

}

#pragma mark -
#pragma mark UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_listArray && [_listArray count] > 0) {
        AccessoryItem *item = [_listArray objectAtIndex:indexPath.row];
        _urlString = [NSString stringWithFormat:@"http://%@/UploadFile/%@", g_appDelegate.yyydIP,item.downloadURL];

        
        
        ImgDetailController *childView = [[ImgDetailController alloc] initWithNibName:@"ImgDetailController" bundle:nil];
        
        [childView setImgURL:_urlString] ;
        [childView setTitle:item.fileName];
        //childView.title = [NSString stringWithFormat:@"%@.%@",item.fileName];
        [self.navigationController pushViewController:childView animated:YES];
        [childView release];

    }
}

- (void)dealloc
{
    [_listArray release];
    [super dealloc];
}

@end
