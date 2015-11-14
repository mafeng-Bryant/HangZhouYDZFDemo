//
//  QQSectionHeaderView.m
//  TQQTableView
//
//  Created by Futao on 11-6-22.
//  Copyright 2011 ftkey.com. All rights reserved.
//

#import "QQSectionHeaderView.h"


@implementation QQSectionHeaderView
@synthesize titleLabel, disclosureButton, delegate, section , opened;

-(id)initWithFrame:(CGRect)frame title:(NSString*)title section:(NSInteger)sectionNumber opened:(BOOL)isOpened delegate:(id)aDelegate{
    if ((self = [super initWithFrame:frame])) {
		
		UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self 
																					  action:@selector(toggleAction:)] autorelease];
		[self addGestureRecognizer:tapGesture];
		self.userInteractionEnabled = YES;
		section = sectionNumber;
		delegate = aDelegate;
		opened = isOpened;
		CGRect titleLabelFrame = self.bounds;
        titleLabelFrame.origin.x += 35.0;
        titleLabelFrame.size.width -= 35.0;
        CGRectInset(titleLabelFrame, 0.0, 5.0);
        titleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
        titleLabel.text = title;
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
		
		
		disclosureButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        disclosureButton.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
		[disclosureButton setImage:[UIImage imageNamed:@"carat.png"] forState:UIControlStateNormal];
		[disclosureButton setImage:[UIImage imageNamed:@"carat-open.png"] forState:UIControlStateSelected];
		disclosureButton.userInteractionEnabled = NO;
		disclosureButton.selected = isOpened;
        [self addSubview:disclosureButton];
		
		self.backgroundColor = [UIColor colorWithRed:238.0f/255.0 green:244.0f/255.0 blue:255.0f/255.0 alpha:1.0f];
	}
	return self;
}

-(IBAction)toggleAction:(id)sender {
	
	disclosureButton.selected = !disclosureButton.selected;
	
	if (disclosureButton.selected) {
		if ([delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
			[delegate sectionHeaderView:self sectionOpened:section];
		}
	}
	else {
		if ([delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
			[delegate sectionHeaderView:self sectionClosed:section];
		}
	}

}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */

- (void)dealloc {
	[titleLabel release];
    [disclosureButton release];
    [super dealloc];
}


@end
