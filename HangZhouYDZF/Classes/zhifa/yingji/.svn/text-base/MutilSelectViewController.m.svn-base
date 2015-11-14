//
//  MutilSelectViewController.m
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-5-6.
//
//

#import "MutilSelectViewController.h"
#import "BlockTextPromptAlertView.h"
@interface MutilSelectViewController ()


@property(nonatomic,retain)NSMutableArray *aryChecked;
@end

@implementation MutilSelectViewController
@synthesize multiStr,delegate;
@synthesize aryItems,aryChecked;

- (void)dealloc {
    [aryChecked release];
    [aryItems release];
    [multiStr release];
    [_msg release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style 
{
    self = [super initWithStyle:style];
    if (self) {
        self.aryChecked = [NSMutableArray arrayWithCapacity:3];
        
    }
    return self;
}

- (void)okBtnPress:(id)sender {

    NSMutableString *words = [NSMutableString stringWithCapacity:6];
    for(NSString  *checkStr in aryChecked){
        if([words length] == 0){
            [words appendFormat:@"%@",checkStr];
        }
        else {
             [words appendFormat:@",%@",checkStr];
        }
    }

    [delegate returnSelectedWords:words];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.aryChecked = [NSMutableArray arrayWithCapacity:3];
    
    NSRange range = [multiStr rangeOfString:@","];
    NSArray *selectAry = nil;
    if (range.location != NSNotFound) {
        selectAry =  [multiStr componentsSeparatedByString:@","];
        for (NSString *select in selectAry) {
            [aryChecked addObject:select];
        }
        
    }
    else {
        if (![multiStr isEqualToString:@""]) {
            [aryChecked addObject:multiStr];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    
    if (![aryItems containsObject:str]) {
        str = @"其他";
    }
    
    cell.textLabel.text = str;
    // Configure the cell...
    if ([aryChecked containsObject:str]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else
        cell.accessoryType = UITableViewCellAccessoryNone;

    
    return cell;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *selectTitle=cell.textLabel.text;
    
    if ([selectTitle isEqualToString:@"其他"]) {
        UITextField *textField;
        BlockTextPromptAlertView *alert = [BlockTextPromptAlertView promptWithTitle:_msg message:[NSString stringWithFormat:@"请输入%@，多个以逗号分隔",_msg] textField:&textField block:^(BlockTextPromptAlertView *alert){
            [alert.textField resignFirstResponder];
            
            return YES;
        }];
        
        [alert setCancelButtonWithTitle:@"取消" block:nil];
        [alert addButtonWithTitle:@"确认" block:^{
            [delegate returnSelectedWords:alert.textField.text];
            //[aryChecked addObject:textField.text];
        }];
        [alert show];

    }
    else {
    
    if ([aryChecked containsObject:selectTitle]) {
        [aryChecked removeObject:selectTitle];
    }else
        [aryChecked addObject:selectTitle];
    }
    
    
    [tableView reloadData];

}

@end
