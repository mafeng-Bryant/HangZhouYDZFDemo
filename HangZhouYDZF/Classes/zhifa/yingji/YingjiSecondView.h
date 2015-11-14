//
//  YingjiSecondView.h
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-15.
//
//

#import <UIKit/UIKit.h>
#import "CommenWordsViewController.h"
@interface YingjiSecondView : UIView<WordsDelegate,UITextFieldDelegate> {
    float yAxs;
    int tagCount;
    int num;
    
}

@property(nonatomic,retain)IBOutlet UITextField *wxpzjsName1;//危险品、重金属品名
@property(nonatomic,retain)IBOutlet UITextField *wxpzjsCapacity1;//危险品、重金属贮存量
@property(nonatomic,retain)IBOutlet UITextField *wxpzjStorage1;//危险品、重金属存储方式
@property(nonatomic,retain)IBOutlet UITextField *wxpzjType1;//危险品、重金属类别
@property(nonatomic,retain)IBOutlet UITextField *wxpzjsName2;//危险品、重金属品名
@property(nonatomic,retain)IBOutlet UITextField *wxpzjsCapacity2;//危险品、重金属贮存量
@property(nonatomic,retain)IBOutlet UITextField *wxpzjStorage2;//危险品、重金属存储方式
@property(nonatomic,retain)IBOutlet UITextField *wxpzjType2;//危险品、重金属类别

@property(nonatomic,retain)IBOutlet UITextField *wxpzjsName3;//危险品、重金属品名
@property(nonatomic,retain)IBOutlet UITextField *wxpzjsCapacity3;//危险品、重金属贮存量
@property(nonatomic,retain)IBOutlet UITextField *wxpzjStorage3;//危险品、重金属存储方式
@property(nonatomic,retain)IBOutlet UITextField *wxpzjType3;//危险品、重金属类别

@property(nonatomic,retain)IBOutlet UILabel *reasonLabel1;
@property(nonatomic,retain)IBOutlet UISegmentedControl *gqsffhSegCtr;//罐区围堰是否符合
@property(nonatomic,retain)IBOutlet UITextField *gqbfhyyField;//罐区围堰不符合原因

@property(nonatomic,retain)IBOutlet UILabel *reasonLabel2;
@property(nonatomic,retain)IBOutlet UISegmentedControl *yjcsffhSegCtr;//应急池是否符合要求
@property(nonatomic,retain)IBOutlet UILabel *reasonLabel3;
@property(nonatomic,retain)IBOutlet UITextField *yjcbfhyyField;//应急池不符合原因
@property(nonatomic,retain)IBOutlet UISegmentedControl *yjfmsfwsSegCtr;//应急池是否完善
@property(nonatomic,retain)IBOutlet UILabel *reasonLabel4;
@property(nonatomic,retain)IBOutlet UITextField *yjfmbwsyyField;//应急阀门不完善原因

@property(nonatomic,retain)IBOutlet UILabel *reasonLabel5;
@property(nonatomic,retain)IBOutlet UISegmentedControl *fsclssSegCtr;//废水处理设施运行
@property(nonatomic,retain)IBOutlet UITextField *fsclssField;//理由

@property(nonatomic,retain)IBOutlet UILabel *reasonLabel6;
@property(nonatomic,retain)IBOutlet UISegmentedControl *fqclssSegCtr;//废气处理设施运行
@property(nonatomic,retain)IBOutlet UITextField *fqclssField;//理由

@property(nonatomic,retain)IBOutlet UILabel *reasonLabel7;
@property(nonatomic,retain)IBOutlet UISegmentedControl *ydqtSegCtr;//有毒气体
@property(nonatomic,retain)IBOutlet UITextField *ydqtField;//内容

@property(nonatomic,retain)IBOutlet UILabel *reasonLabel8;
@property(nonatomic,retain)IBOutlet UISegmentedControl *gqfmSegCtr;//罐区阀门
@property(nonatomic,retain)IBOutlet UITextField *gqfmField;//理由

@property(nonatomic,retain)IBOutlet UISegmentedControl *wxpxzgspSegCtr;//危险品性状公示牌
@property(nonatomic,retain)IBOutlet UISegmentedControl *aqsczdsqSegCtr;//安全生产制度上墙
@property(nonatomic,retain)IBOutlet UISegmentedControl *ywflSegCtr;//雨污分流
@property(nonatomic,retain)IBOutlet UITextField *ywflyyField;//雨污分流不足理由
@property(nonatomic,retain)IBOutlet UISegmentedControl *dqyjssSegCtr;//毒气预警设施
@property(nonatomic,retain)IBOutlet UITextField *yjccapacity;//应急池容积
@property(nonatomic,retain)IBOutlet UISegmentedControl *yjccSegCtr;//应急池有无
@property(nonatomic,retain)IBOutlet UILabel *areaLabel;
@property(nonatomic,retain)IBOutlet UIImageView *lineImageView;

@property(nonatomic,retain) IBOutlet UITextField *emergencyName1;//应急物质品种
@property(nonatomic,retain) IBOutlet UITextField *emergencyQuantity1;//应急物资存量
@property(nonatomic,retain) IBOutlet UITextField *emergencyWay1;//应急物质存储方式

@property(nonatomic,retain) IBOutlet UITextField *emergencyName2;//应急物质品种
@property(nonatomic,retain) IBOutlet UITextField *emergencyQuantity2;//应急物资存量
@property(nonatomic,retain) IBOutlet UITextField *emergencyWay2;//应急物质存储方式

@property(nonatomic,retain) IBOutlet UITextField *emergencyName3;//应急物质品种
@property(nonatomic,retain) IBOutlet UITextField *emergencyQuantity3;//应急物资存量
@property(nonatomic,retain) IBOutlet UITextField *emergencyWay3;//应急物质存储方式

@property (nonatomic,retain) IBOutlet UITextView *qtwtView;//其他问题
@property (nonatomic,retain) IBOutlet UITextView *modifyView;//整改要求

@property (nonatomic, retain) IBOutlet UISegmentedControl *gqywSegCtrl;//罐区有无
@property (nonatomic, retain) IBOutlet UISegmentedControl *fszpSegCtr;//废水总排切断装置



@property (nonatomic, retain) NSMutableArray *textField1Ary;
@property (nonatomic, retain) NSMutableArray *textField2Ary;
@property (nonatomic, retain) NSMutableArray *textField3Ary;
@property (nonatomic, retain) NSMutableArray *reduceBtnAry;

@property (nonatomic, retain) IBOutlet UIView    *qtView;

@property (nonatomic, retain) UIPopoverController *popController;
@property (nonatomic,retain)  UITextField *curField;

@property (nonatomic, assign) BOOL isAdd;


- (IBAction)addEmergencyGoodsItem:(id)sender;

-(NSDictionary*)getValueData;
-(void)loadData:(NSDictionary*)values;

@end
