//
//  SendMessageViewController.h
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-7-18.
//
//

#import <UIKit/UIKit.h>
#import "UIBubbleTableViewDataSource.h"
#import "ContactListViewController.h"

@class MessageInputView;
@class UIBubbleTableView;
@class WebServiceHelper;
@interface SendMessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIBubbleTableViewDataSource,UITextViewDelegate,NSXMLParserDelegate,UISearchBarDelegate,selectLinkManDelegate> {
    
    WebServiceHelper *webService;
    BOOL *isAdd;
    NSMutableString *currentData;
    NSInteger data_type;
    BOOL *isSearch;
}

@property (nonatomic, retain) UINavigationItem *detailItem;
@property (nonatomic, retain) NSMutableArray *bubbleData;
@property (nonatomic, retain) NSMutableArray *listData;
@property (nonatomic, retain) IBOutlet UINavigationBar *masterNavBar;
@property (nonatomic, retain) IBOutlet UINavigationBar *detailNavBar;
@property (nonatomic, retain) IBOutlet UITableView *listTableView;
@property (nonatomic, retain) IBOutlet UIBubbleTableView *bubbleTable;
@property (nonatomic, retain) IBOutlet UIView *messageView;
@property (nonatomic, retain) IBOutlet UIView *addContactView;
@property (nonatomic, retain) IBOutlet UITextField *contactTxt;
@property (nonatomic, retain) MessageInputView *inputView;
@property (nonatomic, assign) CGFloat previousTextViewContentHeight;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *receiver;
@property (nonatomic, copy) NSString *Recipient;
@property (nonatomic, copy) NSString *messageTxt;



- (IBAction)addAddressee:(id)sender;

@end
