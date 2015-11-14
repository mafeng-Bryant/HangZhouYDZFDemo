//
//  WendaDetailsViewController.h
//  GMEPS_HZ
//
//  Created by apple on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommenWordsViewController.h"

@protocol WendaDelegate
-(void)returnquesAry:(NSMutableArray*)values returnansAry:(NSMutableArray*)values1; //得到问和答的值
@end

@interface WendaDetailsViewController : UIViewController <WordsDelegate,UITextFieldDelegate,UITextViewDelegate>{
    NSString *QYMC;
    
    int currentFieldTag;
    NSMutableArray *quesAry;//存储的是UITextField
	NSMutableArray *ansAry;
    IBOutlet UIScrollView *scrollView;
    float yAxs;//问答的y坐标
    BOOL upkeyboard;//判断键盘
    int tagCount;
    
    CommenWordsViewController* wordsSelectViewController;
    UIPopoverController *wordsPopoverController;
    id<WendaDelegate> delegate;
    UIBarButtonItem *saveButton;
    
    NSMutableArray *quesValueAry;
    NSMutableArray *ansValueAry;
}

@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIPopoverController *wordsPopoverController;
@property(nonatomic,retain)CommenWordsViewController *wordsSelectViewController;

@property(nonatomic,assign)id<WendaDelegate> delegate;
@property(nonatomic,retain)NSString *QYMC;
@property(nonatomic,retain)UIBarButtonItem *saveButton;
@property(nonatomic,retain)NSMutableArray *quesAry;//存储的是UITextField
@property(nonatomic,retain)NSMutableArray *ansAry;

@property(nonatomic,retain)NSMutableArray *quesValueAry;
@property(nonatomic,retain)NSMutableArray *ansValueAry;
@property(nonatomic,strong)NSMutableArray *buttonAry;
@property(nonatomic,strong)NSMutableArray *quesLabelAry;
@property(nonatomic,strong)NSMutableArray *ansLabelAry;
@property(nonatomic,strong)NSMutableArray *deleteAry;

-(IBAction)addNewQuestion:(id)sender;
-(void)addQAViewWithOrigValue:(BOOL)bOrigValue andQues:(NSString*)queStr 
                       andAns:(NSString*)ansStr;
@end
