//
//  MutilSelectViewController.h
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-5-6.
//
//

#import <UIKit/UIKit.h>

@protocol MultiWordsDelegate <NSObject>

- (void)returnSelectedWords:(NSString *)words ;

@end

@interface MutilSelectViewController : UITableViewController<UIAlertViewDelegate>
@property (nonatomic,assign) id<MultiWordsDelegate> delegate;
@property (nonatomic,retain) NSArray *aryItems;
@property (nonatomic, copy)  NSString *multiStr;
@property (nonatomic, copy)  NSString *msg;
@end
