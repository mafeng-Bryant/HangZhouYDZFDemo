//
//  BECheckBox.m
//  
//
//  Created by jordenwu-Mac on 10-11-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "BECheckBox.h"
@implementation BECheckBox

@synthesize isChecked;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentLeft;		
		[self setImage:[UIImage imageNamed:@"com_btn_check.png"] forState:UIControlStateNormal];
		[self addTarget:self action:@selector(checkBoxClicked) forControlEvents:UIControlEventTouchUpInside];
	}
    return self;
}

-(void)setTarget:(id)tar fun:(SEL)ff
{
	target=tar;
	fun=ff;
}

-(void)setIsChecked:(BOOL)check
{   
	isChecked=check;
	if (check) {
		[self setImage:[UIImage imageNamed:@"com_btn_checked.png"] forState:UIControlStateNormal];
		
	}
	else {
		[self setImage:[UIImage imageNamed:@"com_btn_check.png"] forState:UIControlStateNormal];
	}
}

-(IBAction) checkBoxClicked
{
	if(self.isChecked ==NO){
		self.isChecked =YES;
		[self setImage:[UIImage imageNamed:@"com_btn_checked.png"] forState:UIControlStateNormal];
		
	}else{
		self.isChecked =NO;
		[self setImage:[UIImage imageNamed:@"com_btn_check.png"] forState:UIControlStateNormal];
		
	}
	[target performSelector:fun];
}

- (void)dealloc {
	target=nil;
    [super dealloc];
}


@end

