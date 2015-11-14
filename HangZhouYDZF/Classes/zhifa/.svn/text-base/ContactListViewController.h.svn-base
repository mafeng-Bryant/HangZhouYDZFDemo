//
//  ContactListViewController.h
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-7-31.
//
//

#import <UIKit/UIKit.h>
@protocol selectLinkManDelegate <NSObject>

- (void)returnContacts:(NSString *)users Numbers:(NSArray *)numbers;

@end

@interface ContactListViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, retain) NSMutableArray *userAry;
@property (nonatomic, retain) NSArray *branchAry;
@property (nonatomic, copy)   NSString *contactStr;
@property (nonatomic, retain) NSMutableArray *numberAry;
@property (nonatomic, retain) NSMutableString *currentData;
@property (nonatomic, assign) id <selectLinkManDelegate> contactDelegate;

@end
