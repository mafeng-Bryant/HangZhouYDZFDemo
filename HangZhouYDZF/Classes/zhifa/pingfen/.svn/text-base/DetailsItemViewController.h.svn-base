//
//  DetailsItemViewController.h
//  EPad
//
//  Created by chen on 11-5-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//评分细则

#import <UIKit/UIKit.h>


@protocol ReasonsDelegate
- (void)returnReasons:(NSString *)words  
        andItemsIndex:(NSArray*)ary withIndex:(NSUInteger)keyIndex;
@end

@interface DetailsItemViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{

	NSArray *itemsAry;
	id<ReasonsDelegate> delegate;
	
	NSInteger itemsIndex;
	BOOL bSelected[10];//考核细则不超过10项
	
	IBOutlet UITableView *myTableView;

}

@property(nonatomic,retain) NSArray *itemsAry;
@property (nonatomic, assign) id<ReasonsDelegate> delegate;

@property (nonatomic, assign) NSInteger itemsIndex;

@property(nonatomic,retain) UITableView *myTableView;

-(void)clearContents;
@end
