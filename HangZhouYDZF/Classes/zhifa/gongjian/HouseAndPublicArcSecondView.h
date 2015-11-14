//
//  HouseAndPublicArcSecondView.h
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-16.
//
//

#import <UIKit/UIKit.h>


@interface HouseAndPublicArcSecondView : UIView
-(id)init;

@property(nonatomic,retain)IBOutlet UISegmentedControl *gtfwclSegCtrl;
@property(nonatomic,retain)IBOutlet UISegmentedControl *fqwrfzSegCtrl;
@property(nonatomic,retain)IBOutlet UISegmentedControl *zswrfzSegCtrl;

@property(nonatomic,retain)IBOutlet UITextView *fswrfzmsTxtView;//废水污染防治描述

@property(nonatomic,retain)IBOutlet UITextView *fqwrfzmsTxtView;//废气污染防治描述
@property(nonatomic,retain)IBOutlet UITextView *zswrfzmsTxtView;//噪声污染防治描述
@property(nonatomic,retain)IBOutlet UITextView *gtfwclmsTxtView;//固体废物处理描述
@property(nonatomic,retain)IBOutlet UITextView *hbglzdTxtView;//环保管理制度
@property(nonatomic,retain)IBOutlet UITextView *qtTxtView;//其它

-(id)init;
-(NSDictionary*)getValueData;
-(void)loadData:(NSDictionary*)values;

@end
