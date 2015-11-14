//
//  CLMButtonBar.h
//  draw
//
//  Created by cocoa on 12/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLMButtonBarDelegate;


@interface CLMButtonBar : UIView {
	NSMutableArray *btns;
	int selectedIndex;
	id<CLMButtonBarDelegate> _delegate;
}
@property(nonatomic,retain) NSMutableArray *btns;
@property(nonatomic) int selectedIndex;
@property(nonatomic, assign)  id<CLMButtonBarDelegate>_delegate;
- (CLMButtonBar *)initWithItems:(NSMutableArray *)items  delegate:(id<CLMButtonBarDelegate>)delegate  frame:(CGRect)frame;

@end

@protocol CLMButtonBarDelegate

-(void)valueChange:(CLMButtonBar *)btnbar;
-(BOOL)isSavedBilu;
@end


#define KFILLCOLOR [UIColor colorWithRed:0.275 green:0.616 blue:0.882 alpha:1.0].CGColor