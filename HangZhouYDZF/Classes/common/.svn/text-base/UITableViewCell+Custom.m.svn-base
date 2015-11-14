//
//  NSString+MD5Addition.m
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import "UITableViewCell+Custom.h"
#import <CommonCrypto/CommonDigest.h>

@implementation UITableViewCell (Custom)

+(UITableViewCell*)makeSubCell:(UITableView *)tableView
					 withTitle:(NSString *)aTitle
                        endDate:(NSString*)date
                          isaj:(NSString*)aj
{
	UILabel* lblTitle = nil;
    UILabel* lblIsan = nil;
	UILabel* lblEndDate = nil;
	//UITableViewCell* aCell = [self getCell:@"Cell_resultTable" forTablieView:tableView];
    
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom4"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom4"] autorelease];
    }

	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
        lblEndDate = (UILabel *)[aCell.contentView viewWithTag:2];
        lblIsan = (UILabel *)[aCell.contentView viewWithTag:3];
		
	}
	
	if (lblTitle == nil) {
		CGRect tRect = CGRectMake(10, 0, 380, 38);
		lblTitle = [[UILabel alloc] initWithFrame:tRect]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor blackColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblTitle.textAlignment = UITextAlignmentLeft;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
        
        CGRect tRect2 = CGRectMake(410, 0, 150, 38);
		lblEndDate = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblEndDate setBackgroundColor:[UIColor clearColor]];
		[lblEndDate setTextColor:[UIColor blackColor]];
		lblEndDate.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblEndDate.textAlignment = UITextAlignmentLeft;;
		lblEndDate.tag = 2;
		[aCell.contentView addSubview:lblEndDate];
		[lblEndDate release];
        
        CGRect tRect3 = CGRectMake(560, 0, 200, 38);
		lblIsan = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblIsan setBackgroundColor:[UIColor clearColor]];
		[lblIsan setTextColor:[UIColor blackColor]];
		lblIsan.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblIsan.textAlignment = UITextAlignmentLeft;
		lblIsan.tag = 3;
		[aCell.contentView addSubview:lblIsan];
		[lblIsan release];
	}
	
	if (lblTitle != nil)	[lblTitle setText:aTitle];
    if (lblEndDate != nil)	[lblEndDate setText:date];
	if (lblIsan != nil)	[lblIsan setText:aj];
    
	return aCell;
}


+(UITableViewCell*)makeSubCell:(UITableView *)tableView
					 withTitle:(NSString *)aTitle
						 value:(NSString *)aValue
{
	UILabel* lblTitle = nil;
	UILabel* lblValue = nil;
	UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom"] autorelease];
    }

	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lblValue = (UILabel *)[aCell.contentView viewWithTag:2];
	}
	
	if (lblTitle == nil) {
		CGRect tRect2 = CGRectMake(5, 0, 160, 44);
		lblTitle = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor grayColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblTitle.textAlignment = UITextAlignmentRight;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		CGRect tRect3 = CGRectMake(180, 0, 520, 44);
		lblValue = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblValue setBackgroundColor:[UIColor clearColor]];
		[lblValue setTextColor:[UIColor blackColor]];
		lblValue.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblValue.textAlignment = UITextAlignmentLeft;
		lblValue.tag = 2;	
		[aCell.contentView addSubview:lblValue];
		[lblValue release];
	}
	if (aTitle == nil) aTitle = @"";
    if (aValue == nil) aValue = @"";
	if (lblTitle != nil)	[lblTitle setText:aTitle];
	if (lblValue != nil)	[lblValue setText:aValue];
	
    aCell.accessoryType = UITableViewCellAccessoryNone;
	return aCell;
}
//台账列表显示
+(UITableViewCell*)makeSubCell:(UITableView *)tableView 
                     withTitle:(NSString *)title
                     SubValue1:(NSString *)value1 
                     SubValue2:(NSString *)value2 
                     SubValue3:(NSString *)value3
{
    
	UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom2"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom2"] autorelease];
    }
	UILabel* lblTitle = nil;
	UILabel* lbl1 = nil;
	UILabel* lbl2 = nil;
    UILabel* lbl3 = nil;
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lbl1 = (UILabel *)[aCell.contentView viewWithTag:2];
		lbl2 = (UILabel *)[aCell.contentView viewWithTag:3];
        lbl3 = (UILabel *)[aCell.contentView viewWithTag:4];
	}
	
	if (lblTitle == nil) {
		CGRect tRect1 = CGRectMake(60, 2, 460, 48);
		lblTitle = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor blackColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:20.0];
		lblTitle.textAlignment = UITextAlignmentLeft;
		lblTitle.numberOfLines = 2;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		CGRect tRect2 = CGRectMake(60, 38, 400, 40);
		lbl1 = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lbl1 setBackgroundColor:[UIColor clearColor]];
		[lbl1 setTextColor:[UIColor grayColor]];
		lbl1.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		lbl1.textAlignment = UITextAlignmentLeft;
		lbl1.tag = 2;
		[aCell.contentView addSubview:lbl1];
		[lbl1 release];
		
		
		CGRect tRect3 = CGRectMake(530, 8, 250, 40);
		lbl2 = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lbl2 setBackgroundColor:[UIColor clearColor]];
		[lbl2 setTextColor:[UIColor grayColor]];
		lbl2.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		lbl2.textAlignment = UITextAlignmentLeft;
		lbl2.tag = 3;
		[aCell.contentView addSubview:lbl2];
		[lbl2 release];
        
        CGRect tRect4 = CGRectMake(530, 38, 200, 40);
		lbl3 = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		[lbl3 setBackgroundColor:[UIColor clearColor]];
		[lbl3 setTextColor:[UIColor grayColor]];
		lbl3.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		lbl3.textAlignment = UITextAlignmentLeft;
		lbl3.tag = 4;
		[aCell.contentView addSubview:lbl3];
		[lbl3 release];
        
        
		
		lblTitle.backgroundColor = [UIColor clearColor];
		lbl1.backgroundColor = [UIColor clearColor];
		lbl2.backgroundColor = [UIColor clearColor];
        lbl3.backgroundColor = [UIColor clearColor];
	}
	
	if (lblTitle != nil)	[lblTitle setText:title];
	if (lbl1 != nil)        [lbl1 setText:value1];
	if (lbl2 != nil)		[lbl2 setText:value2];
    if (lbl3 != nil)		[lbl3 setText:value3];
    
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return aCell;
}



+(UITableViewCell*)makeSubCell:(UITableView *)tableView 
                     withTitle:(NSString *)title
                     SubValue1:(NSString *)value1 
                     SubValue2:(NSString *)value2 
                     SubValue3:(NSString *)value3
                     SubValue4:(NSString *)value4
{

	UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom2"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom2"] autorelease];
    }
	UILabel* lblTitle = nil;
	UILabel* lbl1 = nil;
	UILabel* lbl2 = nil;
    UILabel* lbl3 = nil;
    UILabel* lbl4 = nil;
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lbl1 = (UILabel *)[aCell.contentView viewWithTag:2];
		lbl2 = (UILabel *)[aCell.contentView viewWithTag:3];
        lbl3 = (UILabel *)[aCell.contentView viewWithTag:4];
        lbl4 = (UILabel *)[aCell.contentView viewWithTag:5];
	}
	
	if (lblTitle == nil) {
		CGRect tRect1 = CGRectMake(10, 3, 700, 48);
		lblTitle = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor blackColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:18.0];
		lblTitle.textAlignment = UITextAlignmentLeft;
		lblTitle.numberOfLines = 2;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		CGRect tRect2 = CGRectMake(10, 48, 350, 24);
		lbl1 = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lbl1 setBackgroundColor:[UIColor clearColor]];
		[lbl1 setTextColor:[UIColor grayColor]];
		lbl1.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lbl1.textAlignment = UITextAlignmentLeft;
		lbl1.tag = 2;
		[aCell.contentView addSubview:lbl1];
		[lbl1 release];
		
		
		CGRect tRect3 = CGRectMake(430, 48, 270, 24);
		lbl2 = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lbl2 setBackgroundColor:[UIColor clearColor]];
		[lbl2 setTextColor:[UIColor grayColor]];
		lbl2.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lbl2.textAlignment = UITextAlignmentRight;
		lbl2.tag = 3;
		[aCell.contentView addSubview:lbl2];
		[lbl2 release];
        
        CGRect tRect4 = CGRectMake(430, 25, 270, 24);
		lbl3 = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		[lbl3 setBackgroundColor:[UIColor clearColor]];
		[lbl3 setTextColor:[UIColor grayColor]];
		lbl3.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lbl3.textAlignment = UITextAlignmentRight;
		lbl3.tag = 4;
		[aCell.contentView addSubview:lbl3];
		[lbl3 release];
        
        CGRect tRect5 = CGRectMake(430, 2, 270, 24);
		lbl4 = [[UILabel alloc] initWithFrame:tRect5]; //此处使用id定义任何控件对象
		[lbl4 setBackgroundColor:[UIColor clearColor]];
		[lbl4 setTextColor:[UIColor grayColor]];
		lbl4.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lbl4.textAlignment = UITextAlignmentRight;
		lbl4.tag = 5;
		[aCell.contentView addSubview:lbl4];
		[lbl4 release];
        
		
		lblTitle.backgroundColor = [UIColor clearColor];
		lbl1.backgroundColor = [UIColor clearColor];
		lbl2.backgroundColor = [UIColor clearColor];
        lbl3.backgroundColor = [UIColor clearColor];
        lbl4.backgroundColor = [UIColor clearColor];
	}
	
	if (lblTitle != nil)	[lblTitle setText:title];
	if (lbl1 != nil)        [lbl1 setText:value1];
	if (lbl2 != nil)		[lbl2 setText:value2];
    if (lbl3 != nil)		[lbl3 setText:value3];
    if (lbl4 != nil)		[lbl4 setText:value4];
    
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return aCell;
}

+(UITableViewCell*)makeWeekCell:(UITableView *)tableView
                      withTexts:(NSArray *)titleAry
                       andImage:(UIImage*)image
{
    
    UILabel* lblTitle[6] = {nil};

    UIImageView *imgView = nil;
	UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom"] autorelease];
    }
    
	
	if (aCell.contentView != nil)
	{
        imgView = (UIImageView *)[aCell.contentView viewWithTag:1];
        for (int i =0; i < 6; i++)
            lblTitle[i] = (UILabel *)[aCell.contentView viewWithTag:i+2];

        
	}
	
	if (lblTitle[0] == nil) {
        CGRect tRect1 = CGRectMake(-5, -5, 110, 98);
		imgView = [[UIImageView alloc] initWithFrame:tRect1];
        imgView.tag = 1;
        [aCell.contentView addSubview:imgView];
        [imgView release];
        
		CGRect tRect[6];
        tRect[0] = CGRectMake(75, 0, 80, 33);
        tRect[1] = CGRectMake(160, 0, 510, 33);
        tRect[2] = CGRectMake(75, 35, 80, 33);
        tRect[3] = CGRectMake(160, 35, 510, 33);
        tRect[4] = CGRectMake(75, 70, 80, 33);
        tRect[5] = CGRectMake(160, 70, 510, 33);
        
        for (int i =0; i < 6; i++) {
            lblTitle[i] = [[UILabel alloc] initWithFrame:tRect[i]]; //此处使用id定义任何控件对象
            [lblTitle[i] setBackgroundColor:[UIColor clearColor]];
            [lblTitle[i] setTextColor:[UIColor grayColor]];
            lblTitle[i].font = [UIFont fontWithName:@"Helvetica" size:15.0];
            if(i%2==0)
                lblTitle[i].textAlignment = UITextAlignmentRight;
            else
                lblTitle[i].textAlignment = UITextAlignmentLeft;
            lblTitle[i].tag = i+2;
            [aCell.contentView addSubview:lblTitle[i]];
            [lblTitle[i] release];
        }

	}

    for (int i =0; i < 6; i++){
        [lblTitle[i] setText:@""];

    }
    for (int i =0; i < [titleAry count]; i++){
        [lblTitle[i] setText:[titleAry objectAtIndex:i]];
        
    }
         

	if (imgView !=nil ) 
        [imgView setImage:image];
    aCell.accessoryType = UITableViewCellAccessoryNone;
	return aCell;

    
}

+(UITableViewCell*)makeSubCell:(UITableView *)tableView 
                     withTitle:(NSString *)title
                        sender:(NSString *)aSender 
                      withDate:(NSString *)aDate
{
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom4"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom4"] autorelease];
    }
    
    UILabel* lblTitle = nil;
	UILabel* lblSender = nil;
	UILabel* lblDate = nil;
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lblSender = (UILabel *)[aCell.contentView viewWithTag:2];
		lblDate = (UILabel *)[aCell.contentView viewWithTag:3];
	}
	
	if (lblTitle == nil) {
		CGRect tRect1 = CGRectMake(60, 3, 700, 48);
		lblTitle = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor blackColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:18.0];
		lblTitle.textAlignment = UITextAlignmentLeft;
		lblTitle.numberOfLines = 2;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		CGRect tRect2 = CGRectMake(75, 48, 150, 24);
		lblSender = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblSender setBackgroundColor:[UIColor clearColor]];
		[lblSender setTextColor:[UIColor grayColor]];
		lblSender.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblSender.textAlignment = UITextAlignmentLeft;
		lblSender.tag = 2;
		[aCell.contentView addSubview:lblSender];
		[lblSender release];
		
		
		CGRect tRect3 = CGRectMake(430, 48, 270, 24);
		lblDate = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblDate setBackgroundColor:[UIColor clearColor]];
		[lblDate setTextColor:[UIColor grayColor]];
		lblDate.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblDate.textAlignment = UITextAlignmentRight;
		lblDate.tag = 3;
		[aCell.contentView addSubview:lblDate];
		[lblDate release];
		
		lblTitle.backgroundColor = [UIColor clearColor];
		lblSender.backgroundColor = [UIColor clearColor];
		lblDate.backgroundColor = [UIColor clearColor];
	}
	
	if (lblTitle != nil)	[lblTitle setText:title];
	if (lblSender != nil)	[lblSender setText:[NSString stringWithFormat:@"发件人:%@", aSender]];
	if (lblDate != nil)	[lblDate setText:[NSString stringWithFormat:@"时间:%@", aDate]];
    aCell.accessoryType = UITableViewCellAccessoryNone;
	return aCell;
}

//信访列表表栏编辑方法
+ (UITableViewCell *)makeSubCell:(UITableView *)tableView 
                       withTitle:(NSString *)aTitle
                          caseCode:(NSString *)aCode 
                   complaintDate:(NSString *)aCDate 
                         endDate:(NSString *)aEDate
                            Mode:(NSString *)aMode
{
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom5"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom5"] autorelease];
    }
    
	UILabel* lblTitle = nil;
	UILabel* lblCode = nil;
	UILabel* lblCDate = nil;
    UILabel* lblEDate = nil;
    UILabel* lblMode = nil;
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lblCode = (UILabel *)[aCell.contentView viewWithTag:2];
		lblCDate = (UILabel *)[aCell.contentView viewWithTag:3];
        lblEDate = (UILabel *)[aCell.contentView viewWithTag:4];
        lblMode = (UILabel *)[aCell.contentView viewWithTag:5];
	}
	
	if (lblTitle == nil) {
		CGRect tRect1 = CGRectMake(60, 3, 700, 48);
		lblTitle = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor blackColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:18.0];
		lblTitle.textAlignment = UITextAlignmentLeft;
		lblTitle.numberOfLines = 2;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		CGRect tRect2 = CGRectMake(60, 48, 150, 24);
		lblCode = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblCode setBackgroundColor:[UIColor clearColor]];
		[lblCode setTextColor:[UIColor grayColor]];
		lblCode.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblCode.textAlignment = UITextAlignmentLeft;
		lblCode.tag = 2;
		[aCell.contentView addSubview:lblCode];
		[lblCode release];
		
		
		CGRect tRect3 = CGRectMake(430, 48, 270, 24);
		lblCDate = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblCDate setBackgroundColor:[UIColor clearColor]];
		[lblCDate setTextColor:[UIColor grayColor]];
		lblCDate.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblCDate.textAlignment = UITextAlignmentRight;
		lblCDate.tag = 3;
		[aCell.contentView addSubview:lblCDate];
		[lblCDate release];
        
        CGRect tRect4 = CGRectMake(430, 25, 270, 24);
		lblEDate = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		[lblEDate setBackgroundColor:[UIColor clearColor]];
		[lblEDate setTextColor:[UIColor grayColor]];
		lblEDate.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblEDate.textAlignment = UITextAlignmentRight;
		lblEDate.tag = 4;
		[aCell.contentView addSubview:lblEDate];
		[lblEDate release];
        
        CGRect tRect5 = CGRectMake(430, 2, 270, 24);
		lblMode = [[UILabel alloc] initWithFrame:tRect5]; //此处使用id定义任何控件对象
		[lblMode setBackgroundColor:[UIColor clearColor]];
		[lblMode setTextColor:[UIColor grayColor]];
		lblMode.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblMode.textAlignment = UITextAlignmentRight;
		lblMode.tag = 5;
		[aCell.contentView addSubview:lblMode];
		[lblMode release];
        
		
		lblTitle.backgroundColor = [UIColor clearColor];
		lblCode.backgroundColor = [UIColor clearColor];
		lblCDate.backgroundColor = [UIColor clearColor];
        lblEDate.backgroundColor = [UIColor clearColor];
        lblMode.backgroundColor = [UIColor clearColor];
	}
	
	if (lblTitle != nil)	[lblTitle setText:aTitle];
	if (lblCode != nil)     [lblCode setText:aCode];
	if (lblCDate != nil)	[lblCDate setText:aCDate];
    if (lblEDate != nil)	[lblEDate setText:aEDate];
    if (lblMode != nil)     [lblMode setText:aMode];
    
    return aCell;
}



//一行两项数据的编辑方法(普通表)
+ (UITableViewCell*)makeSubCell:(UITableView *)tableView
                      withTitle:(NSString *)aTitle
                         title2:(NSString *)aTitle2
                          value:(NSString *)aValue
                         value2:(NSString *)aValue2
                         height:(NSInteger)aHeight
{
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom6"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom6"] autorelease];
    }
    
	UILabel* tLabel = nil;
    UILabel* tLabel2 = nil;
    UILabel* vLabel = nil;
    UILabel* vLabel2 = nil;
    
	if (aCell.contentView != nil)
	{
        tLabel = (UILabel *)[aCell.contentView viewWithTag:1];
        vLabel = (UILabel *)[aCell.contentView viewWithTag:2];
        tLabel2 = (UILabel *)[aCell.contentView viewWithTag:3];
        vLabel2 = (UILabel *)[aCell.contentView viewWithTag:4];
    }
	
	if (tLabel == nil) {
		CGRect tRect1 = CGRectMake(0, 0, 162, aHeight);
		tLabel = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[tLabel setBackgroundColor:[UIColor clearColor]];
		[tLabel setTextColor:[UIColor darkGrayColor]];
		tLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel.textAlignment = UITextAlignmentRight;
        tLabel.numberOfLines = 2;
		tLabel.tag = 1;
		[aCell.contentView addSubview:tLabel];
		[tLabel release];
		
		CGRect tRect2 = CGRectMake(162, 0, 260, aHeight);
		vLabel = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[vLabel setBackgroundColor:[UIColor clearColor]];
		[vLabel setTextColor:[UIColor blackColor]];
		vLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		vLabel.textAlignment = UITextAlignmentLeft;
        vLabel.numberOfLines = 2;
		vLabel.tag = 2;
		[aCell.contentView addSubview:vLabel];
		[vLabel release];
        
        CGRect tRect3 = CGRectMake(360, 0, 162, aHeight);
		tLabel2 = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[tLabel2 setBackgroundColor:[UIColor clearColor]];
		[tLabel2 setTextColor:[UIColor darkGrayColor]];
		tLabel2.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel2.textAlignment = UITextAlignmentRight;
        tLabel2.numberOfLines = 2;
		tLabel2.tag = 3;
		[aCell.contentView addSubview:tLabel2];
		[tLabel2 release];
        
        CGRect tRect4 = CGRectMake(520, 0, 200, aHeight);
		vLabel2 = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		[vLabel2 setBackgroundColor:[UIColor clearColor]];
		[vLabel2 setTextColor:[UIColor blackColor]];
		vLabel2.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		vLabel2.textAlignment = UITextAlignmentLeft;
        vLabel2.numberOfLines = 2;
		vLabel2.tag = 4;
		[aCell.contentView addSubview:vLabel2];
		[vLabel2 release];
        
    }
    
    if (tLabel != nil)  [tLabel setText:aTitle];
    if (vLabel != nil)  [vLabel setText:aValue];
    if (tLabel2 != nil) [tLabel2 setText:aTitle2];
    if (vLabel2 != nil) [vLabel2 setText:aValue2];
    
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	return aCell;
}


//一行一项项数据的编辑方法(普通表)
+ (UITableViewCell*)makeSubCell:(UITableView *)tableView
                      withTitle:(NSString *)aTitle
                          value:(NSString *)aValue
                         height:(NSInteger)aHeight
{
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"vencellcustom"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"vencellcustom"] autorelease];
    }
    
	UILabel* tLabel = nil;
    UILabel* vLabel = nil;
    
    
	if (aCell.contentView != nil)
	{
        tLabel = (UILabel *)[aCell.contentView viewWithTag:1];
        vLabel = (UILabel *)[aCell.contentView viewWithTag:2];
    }
	
	if (tLabel == nil) {
		CGRect tRect1 = CGRectMake(0, 0, 162, aHeight);
		tLabel = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[tLabel setBackgroundColor:[UIColor clearColor]];
		[tLabel setTextColor:[UIColor darkGrayColor]];
		tLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		tLabel.textAlignment = UITextAlignmentRight;
        tLabel.numberOfLines = 2;
		tLabel.tag = 1;
		[aCell.contentView addSubview:tLabel];
		[tLabel release];
		
		CGRect tRect2 = CGRectMake(162, 0, 768-200, aHeight);
		vLabel = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[vLabel setBackgroundColor:[UIColor clearColor]];
		[vLabel setTextColor:[UIColor blackColor]];
		vLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		vLabel.textAlignment = UITextAlignmentLeft;
        vLabel.numberOfLines = 2;
		vLabel.tag = 2;
		[aCell.contentView addSubview:vLabel];
		[vLabel release];
        
    }
    
    if (tLabel != nil)  [tLabel setText:aTitle];
    if (vLabel != nil)  [vLabel setText:aValue];
    
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	return aCell;
}


//带textview的表栏编辑方法
+ (UITableViewCell *)makeSubCell:(UITableView *)tableView
                       withTitle:(NSString *)aTitle
                         andText:(NSString *)aText
                          height:(NSInteger)aHeight
{
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom7"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom7"] autorelease];
    }
    
    UILabel* tLabel = nil;
    UITextView *tValue = nil;
    
    if (aCell.contentView != nil)
	{
        tLabel = (UILabel *)[aCell.contentView viewWithTag:1];
        tValue = (UITextView *)[aCell.contentView viewWithTag:2];
    }
    
    if (tLabel == nil) {
		CGRect tRect1 = CGRectMake(0, 0, 162, aHeight);
		tLabel = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[tLabel setBackgroundColor:[UIColor clearColor]];
		[tLabel setTextColor:[UIColor darkGrayColor]];
		tLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel.textAlignment = UITextAlignmentCenter;
        tLabel.numberOfLines = 2;
		tLabel.tag = 1;
		[aCell.contentView addSubview:tLabel];
		[tLabel release];
        
        CGRect tRect2 = CGRectMake(162, 0, 606, aHeight);
        tValue = [[UITextView alloc] initWithFrame:tRect2];
        [tValue setBackgroundColor:[UIColor clearColor]];    
        tValue.font = [UIFont fontWithName:@"Helvetica" size:15.0];;	
        tValue.autocorrectionType = UITextAutocorrectionTypeNo;
        tValue.autocapitalizationType= UITextAutocapitalizationTypeNone;
        tValue.tag = 2;
        tValue.editable = NO;
        [aCell.contentView addSubview:tValue];
        [tValue release];
    }
    
    if (tLabel != nil) [tLabel setText:aTitle];
    if (tValue != nil) [tValue setText:aText];
    
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return aCell;
}


//流程表栏编辑方法
+ (UITableViewCell *)makeSubCell:(UITableView *)tableView
                           Title:(NSString *)aTitle
                         Opinion:(NSString *)aOpinion
                       Signature:(NSString *)aSignature
{
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom8"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom8"] autorelease];
    }
    
    UILabel *titleLabel = nil;
    UILabel *opinionLabel = nil;
    UILabel *signatureLabel = nil;
    
    if (aCell.contentView != nil) {
        titleLabel = (UILabel *)[aCell.contentView viewWithTag:1];
        opinionLabel = (UILabel *)[aCell.contentView viewWithTag:2];
        signatureLabel = (UILabel *)[aCell.contentView viewWithTag:3];
    }
    
    if (titleLabel == nil) {
        CGRect tRect1 = CGRectMake(0, 0, 162, 33*2);
		titleLabel = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[titleLabel setBackgroundColor:[UIColor colorWithRed:(0x30/255.0f) green:(0x72/255.0f) blue:(0xa4/255.0f) alpha:1.0]];
		[titleLabel setTextColor:[UIColor whiteColor]];
		titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
		titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.numberOfLines = 2;
		titleLabel.tag = 1;
		[aCell.contentView addSubview:titleLabel];
		[titleLabel release];
        
        CGRect tRect2 = CGRectMake(162, 0, 606, 33);
		opinionLabel = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[opinionLabel setBackgroundColor:[UIColor colorWithRed:(0xde/255.0f) green:(0xf0/255.0f) blue:(0xfd/255.0f) alpha:1.0]];
		[opinionLabel setTextColor:[UIColor blackColor]];
		opinionLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		opinionLabel.textAlignment = UITextAlignmentCenter;
        opinionLabel.numberOfLines = 2;
		opinionLabel.tag = 1;
		[aCell.contentView addSubview:opinionLabel];
		[opinionLabel release];
        
        CGRect tRect3 = CGRectMake(162, 33, 606, 33);
		signatureLabel = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[signatureLabel setBackgroundColor:[UIColor colorWithRed:(0xde/255.0f) green:(0xf0/255.0f) blue:(0xfd/255.0f) alpha:1.0]];
		[signatureLabel setTextColor:[UIColor blackColor]];
		signatureLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		signatureLabel.textAlignment = UITextAlignmentRight;
        signatureLabel.numberOfLines = 2;
		signatureLabel.tag = 1;
		[aCell.contentView addSubview:signatureLabel];
		[signatureLabel release];
    }
    
    if (titleLabel != nil)     [titleLabel setText:aTitle];
    if (opinionLabel != nil)   [opinionLabel setText:aOpinion];
    if (signatureLabel != nil) [signatureLabel setText:aSignature];
    
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return aCell;
}


//三个标题两个值
+ (UITableViewCell*)makeSubVenCell:(UITableView *)tableView
                      withTitle:(NSString *)aTitle
                         title1:(NSString *)aTitle1
                         title2:(NSString *)aTitle2
                          value1:(NSString *)aValue1
                         value2:(NSString *)aValue2
                         height:(NSInteger)aHeight
{
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom122"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom122"] autorelease];
    }
    UILabel* mtLabel = nil;
	UILabel* tLabel = nil;
    UILabel* tLabel2 = nil;
    UILabel* vLabel = nil;
    UILabel* vLabel2 = nil;
    
	if (aCell.contentView != nil)
	{
        mtLabel = (UILabel *)[aCell.contentView viewWithTag:5];
        tLabel = (UILabel *)[aCell.contentView viewWithTag:1];
        vLabel = (UILabel *)[aCell.contentView viewWithTag:2];
        tLabel2 = (UILabel *)[aCell.contentView viewWithTag:3];
        vLabel2 = (UILabel *)[aCell.contentView viewWithTag:4];
    }
	
	if (tLabel == nil) {
        
        CGRect tRect0 = CGRectMake(0, 0, 120, aHeight);
		mtLabel = [[UILabel alloc] initWithFrame:tRect0]; //此处使用id定义任何控件对象
		[mtLabel setBackgroundColor:[UIColor clearColor]];
		[mtLabel setTextColor:[UIColor blackColor]];
		mtLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
		mtLabel.textAlignment = UITextAlignmentCenter;
        mtLabel.numberOfLines = 2;
		mtLabel.tag = 5;
		[aCell.contentView addSubview:mtLabel];
		[mtLabel release];
        
		tLabel = [[UILabel alloc] init]; //此处使用id定义任何控件对象
		[tLabel setBackgroundColor:[UIColor clearColor]];
		[tLabel setTextColor:[UIColor darkGrayColor]];
		tLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel.textAlignment = UITextAlignmentRight;
        tLabel.numberOfLines = 2;
		tLabel.tag = 1;
		[aCell.contentView addSubview:tLabel];
		[tLabel release];
		
		vLabel = [[UILabel alloc] init]; //此处使用id定义任何控件对象
		[vLabel setBackgroundColor:[UIColor clearColor]];
		[vLabel setTextColor:[UIColor blackColor]];
		vLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		vLabel.textAlignment = UITextAlignmentLeft;
        vLabel.numberOfLines = 2;
		vLabel.tag = 2;
		[aCell.contentView addSubview:vLabel];
		[vLabel release];
        
		tLabel2 = [[UILabel alloc] init]; //此处使用id定义任何控件对象
		[tLabel2 setBackgroundColor:[UIColor clearColor]];
		[tLabel2 setTextColor:[UIColor darkGrayColor]];
		tLabel2.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel2.textAlignment = UITextAlignmentRight;
        tLabel2.numberOfLines = 2;
		tLabel2.tag = 3;
		[aCell.contentView addSubview:tLabel2];
		[tLabel2 release];
        
		vLabel2 = [[UILabel alloc] init]; //此处使用id定义任何控件对象
		[vLabel2 setBackgroundColor:[UIColor clearColor]];
		[vLabel2 setTextColor:[UIColor blackColor]];
		vLabel2.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		vLabel2.textAlignment = UITextAlignmentLeft;
        vLabel2.numberOfLines = 2;
		vLabel2.tag = 4;
		[aCell.contentView addSubview:vLabel2];
		[vLabel2 release];
        
    }
    if (mtLabel != nil)  [mtLabel setText:aTitle];
    if (tLabel != nil)  [tLabel setText:aTitle1 ];
    if (vLabel != nil)  [vLabel setText:aValue1];
    if (tLabel2 != nil) [tLabel2 setText:aTitle2];
    if (vLabel2 != nil) [vLabel2 setText:aValue2];
    if ([aTitle1 isEqualToString:@""]&&[aTitle2 isEqualToString:@""]) {
        [tLabel setFrame:CGRectMake(100.0, 0.0, 0, aHeight)];
        [vLabel setFrame:CGRectMake(120.0, 0.0, 768.0-120.0, aHeight)];
        [tLabel2 setFrame:CGRectMake(100.0, 0.0, 0, aHeight)];
        [vLabel2 setFrame:CGRectMake(100.0, 0.0, 0, aHeight)];
    }
    else{
        [tLabel setFrame:CGRectMake(100, 0, 162, aHeight)];
        [vLabel setFrame:CGRectMake(162+120, 0, 162, aHeight)];
        [tLabel2 setFrame:CGRectMake(324+100, 0, 162, aHeight)];
        [vLabel2 setFrame:CGRectMake(486+120, 0, 162, aHeight)];
    }
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	return aCell;
}


//一个标题一个值 
+ (UITableViewCell*)makeSubVenCell:(UITableView *)tableView
                         withTitle:(NSString *)aTitle
                           value:(NSString *)aValue
                            height:(NSInteger)aHeight
{
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom133"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom133"] autorelease];
    }
    
	UILabel* tLabel = nil;
    UILabel* vLabel = nil;
    
	if (aCell.contentView != nil)
	{
        tLabel = (UILabel *)[aCell.contentView viewWithTag:1];
        vLabel = (UILabel *)[aCell.contentView viewWithTag:2];
    }
	
	if (tLabel == nil) {
        
        
		CGRect tRect1 = CGRectMake(100, 0, 162, aHeight);
		tLabel = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[tLabel setBackgroundColor:[UIColor clearColor]];
		[tLabel setTextColor:[UIColor darkGrayColor]];
		tLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel.textAlignment = UITextAlignmentRight;
        tLabel.numberOfLines = 2;
		tLabel.tag = 1;
		[aCell.contentView addSubview:tLabel];
		[tLabel release];
		
		CGRect tRect2 = CGRectMake(162+120, 0,768-300, aHeight);
		vLabel = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[vLabel setBackgroundColor:[UIColor clearColor]];
		[vLabel setTextColor:[UIColor blackColor]];
		vLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		vLabel.textAlignment = UITextAlignmentLeft;
        vLabel.numberOfLines = 2;
		vLabel.tag = 2;
		[aCell.contentView addSubview:vLabel];
		[vLabel release];
        
    }
    if (tLabel != nil)  [tLabel setText:aTitle];
    if (vLabel != nil)  [vLabel setText:aValue];
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	return aCell;
}



@end
