//
//  AddTestResultViewController.h
//  GMEPS_HZ
//
//  Created by ZHONGWEN on 13-6-4.
//
//

#import <UIKit/UIKit.h>
#define Number @"0123456789."
@protocol TypeInTestResultDelegate <NSObject>

- (void)returnTypeInTestData:(NSArray *)element standard:(NSArray *)standard actually:(NSArray *)actually cellRow:(NSInteger)row;

@end

@interface TypeInTestResultViewController : UIViewController<UITextFieldDelegate> {
    IBOutlet UILabel *typeLabel1;
    IBOutlet UILabel *typeLabel2;
    IBOutlet UILabel *typeLabel3;
    IBOutlet UITextField *elementField1;
    IBOutlet UITextField *elementField2;
    IBOutlet UITextField *standardField1;
    IBOutlet UITextField *standardField2;
    IBOutlet UITextField *actuallyField1;
    IBOutlet UITextField *actuallyField2;
    
    int tagCount;
    UIScrollView *scrollView;
    float yAxs;
}

@property (nonatomic, retain) NSDictionary *targetDict;

@property (nonatomic, retain) NSMutableArray *Lable1Ary;
@property (nonatomic, retain) NSMutableArray *Lable2Ary;
@property (nonatomic, retain) NSMutableArray *Lable3Ary;
@property (nonatomic, retain) NSMutableArray *textField1Ary;
@property (nonatomic, retain) NSMutableArray *textField2Ary;
@property (nonatomic, retain) NSMutableArray *textField3Ary;
@property (nonatomic, retain) NSMutableArray *addBtnAry;
@property (nonatomic, retain) NSMutableArray *reduceBtnAry;
@property (nonatomic, retain) NSArray        *labelAry;
@property (nonatomic, assign) NSInteger *cellRow;
@property (nonatomic, assign) id <TypeInTestResultDelegate> delegate;

- (IBAction)addItemValue:(id)sender;
@end
