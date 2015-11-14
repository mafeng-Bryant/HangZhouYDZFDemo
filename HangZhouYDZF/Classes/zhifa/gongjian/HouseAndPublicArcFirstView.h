//
//  HouseAndPublicArcFirstView.h
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-16.
//
//

#import <UIKit/UIKit.h>


@interface HouseAndPublicArcFirstView : UIView
-(id)init;
//项目建设情况
@property(nonatomic,retain)IBOutlet UISegmentedControl *xmjsqkSegCtrl;

//废水污染防治
@property(nonatomic,retain)IBOutlet UISegmentedControl *fswrfzSegCtrl;
//行业类型
@property(nonatomic,retain)IBOutlet UISegmentedControl *hylxSegCtrl;

//实施情况
@property(nonatomic,retain)IBOutlet UISegmentedControl *ssqkSegCtrl;

//跟踪级别
@property(nonatomic,retain)IBOutlet UISegmentedControl *gzjbSegCtrl;

//项目类型
@property(nonatomic,retain)IBOutlet UISegmentedControl *xmlxSegCtrl;


@property(nonatomic,retain)IBOutlet UITextField *jsxmmcField;//建设项目名称
@property(nonatomic,retain)IBOutlet UITextField *jsdwField;//建设单位
@property(nonatomic,retain)IBOutlet UITextField *yqjgrqField;//预期竣工日期
@property(nonatomic,retain)IBOutlet UITextField *jsdzField;//建设地址
@property(nonatomic,retain)IBOutlet UITextField *frdbField;//法人代表
@property(nonatomic,retain)IBOutlet UITextField *frlxdhField;//法人联系电话
@property(nonatomic,retain)IBOutlet UITextField *xmlxrField;//项目联系人
@property(nonatomic,retain)IBOutlet UITextField *lxrdhField;//联系人电话
@property(nonatomic,retain)IBOutlet UITextField *czField;//传真
@property(nonatomic,retain)IBOutlet UITextField *spwhField;//审批文号
@property(nonatomic,retain)IBOutlet UITextField *spsjField;//审批时间
@property(nonatomic,retain)IBOutlet UITextField *wsfhjlyqField;//实施情况
@property(nonatomic,retain)IBOutlet UITextField *qthyField;//其他行业
@property(nonatomic,retain)IBOutlet UITextField *zjmgdwzjjlField;//最近敏感点位置及距离
@property(nonatomic,retain)IBOutlet UISegmentedControl *sfwtzzdwkzjgysSegCtrl;//是否已委托资质单位开展竣工验收
@property(nonatomic,retain)IBOutlet UITextView *xmjsqkmsTxtView;//项目建设情况描述

@property(nonatomic,retain)IBOutlet UISegmentedControl *hjjlspyqSegCtrl;//环境监理审批要求
@property(nonatomic,retain)IBOutlet UISegmentedControl *sfwthjjlSegCtrl;//是否委托环境监理
@property(nonatomic,retain)IBOutlet UITextField *hjjldwmcField;//最近敏感点位置及距离
@property(nonatomic,retain)IBOutlet UITextField *xmfzrjlxdhField;//最近敏感点位置及距离

-(id)init;
-(NSDictionary*)getValueData;
- (void)loadData:(NSDictionary *)values;

@end
