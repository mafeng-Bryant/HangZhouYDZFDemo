//
//  JCNRView.h
//  GMEPS_HZ
//
//  Created by zhang on 13-4-7.
//
//

#import <UIKit/UIKit.h>

@interface JCNRView : UIView{
    //生产情况
    IBOutlet UISegmentedControl *scqkSegCtrl;
    //生产设备跑冒滴漏
    IBOutlet UISegmentedControl *scsbSegCtrl;
    
    //企业环保管理制度
    IBOutlet UISegmentedControl *qyhbglzdSegCtrl;
    
    //污染设施操作规程
    IBOutlet UISegmentedControl *wryssczgcSegCtrl;
    
    //污水处理设施运行
    IBOutlet UISegmentedControl *wsclssyxSegCtrl;
    
    //污水排放口规范化
    IBOutlet UISegmentedControl *wspfkgfhSegCtrl;
    
    //污水设施运行纪录
    IBOutlet UISegmentedControl  *wsssyxjlSegCtrl;
    
    //污水药剂添加
    IBOutlet UISegmentedControl *wsyjtjSegCtrl;
    
    //现场是否采样
    IBOutlet UISegmentedControl *xcsfcySegCtrl;
    
    //废气处理设施运行
    IBOutlet UISegmentedControl *fqclssyxSegCtrl;
    
    //废气排放口规范化
    IBOutlet UISegmentedControl *fqpfkgfhSegCtrl;
    
    //废气设施运行纪录
    IBOutlet UISegmentedControl *fqssyxjlSegCtrl;
    
    //废气药剂添加
    IBOutlet UISegmentedControl *fqyjtjSegCtrl;
    
    //烟气黑度
    IBOutlet UISegmentedControl *yqhdSegCtrl;
    
    //工艺废气无组织排放
    IBOutlet UISegmentedControl *gyfqwzzpfSegCtrl;
    
    //三防措施
    IBOutlet UISegmentedControl *sfssSegCtrl;
    
    //转移联单
    IBOutlet UISegmentedControl *zyldSegCtrl;
    
    //标志标识
    IBOutlet UISegmentedControl *bzbsSegCtrl;
    
    //餐饮油烟净化设施
    IBOutlet UISegmentedControl *cyyyjhssSegCtrl;
    
    //餐饮油烟净化设施运行
    IBOutlet UISegmentedControl *cyyyjhssyxSegCtrl;
    
    //餐饮排污许可证
    IBOutlet UISegmentedControl *cypwxkzSegCtrl;
    
    IBOutlet UITextField *zycpField;//主要产品
    IBOutlet UITextField *pfszggmsField;//排污水质感官描述
    IBOutlet UITextField *wfmcField;//危险废物名称
    IBOutlet UITextField *cypwfjnField;//排污费缴纳
    IBOutlet UITextField *xcfzrzwField;//现场负责人职务
    IBOutlet UITextField *xcfzrdhField;//现场负责人电话
    
    IBOutlet UISwitch *wsSwitch; //污水
    IBOutlet UISwitch *fqSwitch; //废气
    IBOutlet UISwitch *wxfwSwitch; //危险废物
    IBOutlet UISwitch *cySwitch; //餐饮
    IBOutlet UILabel  *wsLabel;
    IBOutlet UILabel  *fqLabel;
    IBOutlet UILabel  *wxfwLabel;
    IBOutlet UILabel  *cyLabel;
    
}

-(id)init;
-(NSDictionary*)getValueData;
-(void)loadData:(NSDictionary*)values;
-(IBAction)switchValChanged:(id)sender;
@end
