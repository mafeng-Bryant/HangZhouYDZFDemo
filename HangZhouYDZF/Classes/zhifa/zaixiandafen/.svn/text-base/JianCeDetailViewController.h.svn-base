//
//  JianCeDetailViewController.h
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-4-18.
//
//

#import <UIKit/UIKit.h>
#import "ZrsUtils.h"
#import "TypeInTestResultViewController.h"

@class SurveyTableViewController;
@protocol refreshScoreDelegate
- (void)refreshScore:(NSString *)currentScore;

@end

@interface JianCeDetailViewController : UITableViewController<TypeInTestResultDelegate,UITextFieldDelegate> {
    NSMutableArray *cellHeightAry;
    BOOL isSelected;
    SurveyTableViewController *surveyTableController;
}
@property (nonatomic, assign) id<refreshScoreDelegate> refreshDelegate;
@property (nonatomic, retain) NSDictionary *tableDict;
@property (nonatomic, retain) NSIndexPath *currentIndex;
@property (nonatomic, retain) NSMutableArray *cellHeightAry;
@property (nonatomic, assign) int scoreTotal;
@property (nonatomic, assign) BOOL isSave;
@property (nonatomic, copy)   NSString *shortName;
@property (nonatomic, copy)   NSString *factorScore;

- (BOOL)saveLastDetailViewData;
- (void)reloadTableView;

@end
