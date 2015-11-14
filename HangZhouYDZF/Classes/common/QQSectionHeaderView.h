//
//  QQSectionHeaderView.h
//  TQQTableView
//
//  Created by Futao on 11-6-22.
//  Copyright 2011 ftkey.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QQSectionHeaderViewDelegate;

@interface QQSectionHeaderView : UIView {

}
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *disclosureButton;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) BOOL opened;

@property (nonatomic, assign) id <QQSectionHeaderViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame title:(NSString*)title section:(NSInteger)sectionNumber opened:(BOOL)isOpened delegate:(id<QQSectionHeaderViewDelegate>)delegate;

@end

@protocol QQSectionHeaderViewDelegate <NSObject> 

@optional
-(void)sectionHeaderView:(QQSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section;

-(void)sectionHeaderView:(QQSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section;
@end
