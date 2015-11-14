//
//  choosePersonControllerView.h
//  GMEPS_HZ
//
//  Created by Apple on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol choosePersonDelegate

-(void)returnChoosePersons:(NSMutableArray*)aryPersons isSure:(BOOL)sure;

@end
@interface SectionItem1 : NSObject {
    
    NSString *sectionName;
    BOOL bOpened;
}
@property(nonatomic,retain)NSString *sectionName;
@property(nonatomic,assign)BOOL bOpened;
@end
@interface choosePersonControllerView : UITableViewController
{

}
@property(nonatomic,strong)NSMutableArray *aryDanwei;//在部门界面里获取人员
@property(nonatomic,strong)NSMutableArray *arySectionItems; //没有用到
@property(nonatomic,retain)NSMutableArray *arySectionPerson;//存储打钩的人员
@property(nonatomic,strong)NSMutableDictionary *dicPersonAll;//根据人员为key，得到的信息
@property(nonatomic,assign)id<choosePersonDelegate> delegate;//委托把打钩的人员值传给部门
//-(void)initializeSectionDatas;
@end
