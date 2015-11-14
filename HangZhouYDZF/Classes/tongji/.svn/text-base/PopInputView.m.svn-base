//
//  PopInputView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PopInputView.h"
#import "AreaStatisticsInputView.h"
#import "IndustryStatisticsMainView.h"
#import "BranchStatisticsView.h"
#import "BusinessStatisticsView.h"
#import "SupervisionTaskMainView.h"
#import "MutiConditionViewController.h"

@implementation PopInputView
@synthesize beginDateField;
@synthesize endDateField;
@synthesize makeSure;
@synthesize popController;
@synthesize dateController;
@synthesize parentTag;
@synthesize areaParentView;
@synthesize industryParentView;
@synthesize branchParentView;
@synthesize businessParentView;
@synthesize supervisionParentView;
@synthesize mutiConditionParentView;

- (IBAction)makeSurePressed:(id)sender {
    //beginDateValue
    
	NSString *beginDateValue;
	if (![beginDateField.text isEqualToString:@""])
		beginDateValue =[NSString stringWithString:beginDateField.text]; 
	else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"起始时间不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
	
	//endDataValue
	NSString *endDateValue;
	if (![endDateField.text isEqualToString:@""])
		endDateValue = [NSString stringWithString:endDateField.text];
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"结束时间不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
	}
    
    if (([beginDateValue compare:endDateValue] == NSOrderedDescending)||
        [beginDateValue compare:endDateValue] == NSOrderedSame)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"结束时间应大于起始时间"
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];

        return;
    }

    
    switch (parentTag) {
        case 0:
            [areaParentView initWithBeginDate:beginDateValue endDate:endDateValue];
            break;
            
        case 1:
            [industryParentView initWithBeginDate:beginDateValue endDate:endDateValue];
            break;
            
        case 2:
            [branchParentView initWithBeginDate:beginDateValue endDate:endDateValue];
            break;
            
        case 3:
            [businessParentView initWithBeginDate:beginDateValue endDate:endDateValue];
            break;
            
        case 4:
            [supervisionParentView initWithBeginDate:beginDateValue endDate:endDateValue];
            break;
            
        case 5:
            [mutiConditionParentView initWithBeginDate:beginDateValue endDate:endDateValue];
            break;
            
        default:
            break;
    }
        
    
    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction)backgroundTag:(id)sender {
    [beginDateField resignFirstResponder];
	[endDateField resignFirstResponder];
}


- (IBAction)touchFromDate:(id)sender {
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
				beginDateField.text = dateString;
				break;
			case 2:
				endDateField.text = dateString;
				break;
				
			default:
				break;
		}
    }
}

- (void)cancelPressed {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    [beginDateField release];
    [endDateField release];
    [makeSure release];
    [popController release];
    [dateController release];
    [areaParentView release];
    [industryParentView release];
    [branchParentView release];
    [businessParentView release];
    [supervisionParentView release];
    [mutiConditionParentView release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    PopupDateViewController *date = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
	self.dateController = date;
	dateController.delegate = self;
	[date release];
	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
	
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
    
    UIBarButtonItem *aItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain
															 target:self
															 action:@selector(cancelPressed)];
	self.navigationItem.rightBarButtonItem = aItem;
	[popover release];
	[nav release];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60*60]];
    [dateFormatter release];
   
    endDateField.text = dateString;
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

@end
