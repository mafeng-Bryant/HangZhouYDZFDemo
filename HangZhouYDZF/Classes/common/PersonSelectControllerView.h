//
//  PersonSelectControllerView.h
//  GMEPS_HZ
//
//  Created by Apple on 12-3-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "choosePersonControllerView.h"
#import "WebServiceHelper.h"
@protocol PersonDelegate

-(void)returnPersons:(NSMutableArray*)aryPersons;

@end

@interface PersonSelectControllerView : UITableViewController<NSXMLParserDelegate,choosePersonDelegate>
{
    int nParserStatus;
    NSMutableDictionary *aValueDicnary;   //根据xml的数据存储对应的值
    NSMutableString  *curData;
    
    NSMutableDictionary *dicPersonInfomation;
    
    NSMutableArray *aryDanWei;//根据xml传过来的单位名称顺序存储
    
    //NSMutableArray *arySectionItems;//存放SectionItem
    UIBarButtonItem *updateBtn;
    NSMutableArray *surePersonAry;
    WebServiceHelper *webService;
    
}
@property(nonatomic, strong) NSMutableDictionary *dicPersonInfomation;   //根据FSHBJ为key
@property(nonatomic, strong) NSMutableDictionary *dicPersonAll;          //根据BMMC为key
@property(nonatomic, strong) NSMutableDictionary *dicPersonYHMC;         //根据YHMC为key
@property(nonatomic, strong) NSMutableArray      *aryDanWei;             //列表变化显示的值
@property(nonatomic, strong) NSMutableArray      *surePersonAry;         //打钩人员的值
@property(nonatomic, strong) UIBarButtonItem     *updateBtn;             //更新按钮
@property(nonatomic,assign)id<PersonDelegate>   delegate1;              //把打钩的值通过确定按钮传给询问界面


@end
