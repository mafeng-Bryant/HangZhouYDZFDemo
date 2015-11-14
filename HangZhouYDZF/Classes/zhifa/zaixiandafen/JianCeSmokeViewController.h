//
//  JianCeSmokeViewController.h
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-4-18.
//
//



#import <UIKit/UIKit.h>
#import "JianCeDetailViewController.h"
#import "ChooseRecordViewController.h"



@interface JianCeSmokeViewController : UIViewController<NSXMLParserDelegate, UITableViewDataSource,UITableViewDelegate,ChooseRecordDelegate,refreshScoreDelegate>{
    IBOutlet UITableView *masterTableView;
    IBOutlet JianCeDetailViewController *detailViewController;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *JCDW;
    IBOutlet UITextField *QYMC;
    IBOutlet UITextField *QYDZ;
    IBOutlet UITextField *YWGS;
    IBOutlet UITextField *CBZB;
    IBOutlet UISegmentedControl *ZDSX;
    IBOutlet UISegmentedControl *CBQK;
    IBOutlet UILabel *ZBLabel;
    IBOutlet UINavigationItem *masterBarItem;
    NSMutableArray *dataArray;
    NSMutableDictionary *checkDict;
    NSMutableDictionary *baseInfo;
    NSString *currentNote;
    int total;
    NSIndexPath *lastSelected;
}

@property(nonatomic, retain) NSIndexPath *currentIndex;
@property(nonatomic,assign) NSInteger recordStatus;
@property(nonatomic, retain) NSDictionary *dicWryInfo;
@property(nonatomic,copy) NSString *tableName;//数据库表名
@property(nonatomic,copy) NSString *tableBH;
@property(nonatomic,copy) NSString *dwbh;
@property(nonatomic,copy) NSString *wrymc;
@property(nonatomic,copy) NSString *xczfbh;
@property(nonatomic,assign) NSInteger menuTagID;//对应按钮的tag
@property(nonatomic,assign) BOOL isHisRecord;
@property(nonatomic,assign) BOOL isSaveRecord;//YES调用最近一次暂存记录


//根据值来显示值
-(void)displayRecordDatas:(id)values;

-(void)saveLocalRecord:(id)valueDatas;
- (IBAction)segmentValueChanged:(id)sender;

@end
