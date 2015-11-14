//
//  SendMessageViewController.m
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-7-18.
//
//

#import "SendMessageViewController.h"
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "NSBubbleData.h"
#import "MessageInputView.h"
#import "NSString+MessagesView.h"
#import "GMEPS_HZAppDelegate.h"
#import "UserInfo.h"
#import "WebServiceHelper.h"
#import "DBHelper.h"
#import "GUIDGenerator.h"


#define MOBILE  @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
#define CM      @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
#define CU      @"^1(3[0-2]|5[256]|8[56])\\d{8}$"
#define CT      @"^1((33|53|8[09])[0-9]|349)\\d{7}$"

#define INPUT_DATA 0
#define SELECT_DATA 1

extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;

#define INPUT_HEIGHT 40.0f
@interface SendMessageViewController ()

@property (nonatomic, retain) UIPopoverController *popController;
@end

@implementation SendMessageViewController

// -------------------------------------------------------------------------------
//	dealloc
// -------------------------------------------------------------------------------
- (void)dealloc
{
    [_masterNavBar release];
    [_detailNavBar release];
    [_detailItem   release];
    [_listTableView release];
    [_bubbleTable release];
    [_listData release];
    [_inputView release];
    [_messageView release];
    [currentData release];
    [_phoneNumber release];
    [_Recipient   release];
    [_popController release];
   
    [super dealloc];
}

// -------------------------------------------------------------------------------
//	backItemPressed:
// -------------------------------------------------------------------------------
- (void)backItemPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)sendPressed:(id)sender {
    
    NSIndexPath *indexPath = [_listTableView indexPathForSelectedRow];
    NSDictionary *listDict = [_listData objectAtIndex:indexPath.row];
    
    NSString *sendNumber = [listDict objectForKey:@"send_number"];
    NSString *sendText = [self.inputView.textView.text trimWhitespace];
    self.messageTxt = sendText;
    if(data_type == INPUT_DATA){
        if (([sendNumber isEqualToString:@""] || sendNumber == nil)) {
            sendNumber = _contactTxt.text;
            self.phoneNumber = sendNumber;
            self.receiver = @"";
            NSArray *numberAry = [sendNumber componentsSeparatedByString:@","];
            if ([_contactTxt.text isEqualToString:@""]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发送号码不能为空" delegate:nil cancelButtonTitle:@"知道了"otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                return ;
            }
            else if([numberAry count] == 1){
                BOOL isVailed = [self verifyPhoneNumber:sendNumber];
                if (!isVailed) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入手机号码无效" delegate:nil cancelButtonTitle:@"重新输入"otherButtonTitles:nil];
                    [alertView show];
                    [alertView release];
                    self.contactTxt.text = @"";
                    return;
                    
                }

            }
        }
    }
    
    if (data_type == SELECT_DATA) {
        NSLog(@"contactText:%@ phoneNumber:%@",_contactTxt.text,_phoneNumber);
        if ([_contactTxt.text isEqualToString:@""] && ([self.phoneNumber isEqualToString:@""] || !self.phoneNumber)) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收件人不能为空" delegate:nil cancelButtonTitle:@"知道了"otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return ;
        }

        sendNumber = self.phoneNumber;
    }

    [self sendMessage:sendNumber
             withText:sendText];
}

- (void)sendMessage:(NSString *)number withText:(NSString *)text {
    NSArray *numberAry = [number componentsSeparatedByString:@","];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *sendTime = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
        [dateFormatter release];
        
        NSMutableString *sql = [[[NSMutableString alloc] initWithCapacity:400] autorelease];
    
    NSString *sign = [GUIDGenerator generateGUID];
        for (int i=0; i< [numberAry count]; i++) {
            NSString *numberStr = [numberAry objectAtIndex:i];
            NSString *xh = [GUIDGenerator generateGUID];
            if (i==0) {
                [sql appendString:@"insert into T_SHORTMESSAGE_TEMP(XH,DESTADDR,CONTENT,SENDTIME,MKBS,SBID,ORGID,SIGN,JGFZ,CZRY,CJR,CJSJ) values("];
                //YWF->YY WF->WFLL QT->QTZS
                [sql appendFormat:@"'%@','%@','%@',to_date('%@' , 'yyyy-mm-dd hh24:mi:ss'),'%@','%@','%@','%@','%@','%@','%@',sysdate)",xh,
                 numberStr,text,sendTime,@"PBDX",g_appDelegate.udid,g_logedUserInfo.userORGID,sign,g_logedUserInfo.userDanwei,g_logedUserInfo.userName,g_logedUserInfo.userName];
            }
            else {
                [sql appendString:@"^ insert into T_SHORTMESSAGE_TEMP(XH,DESTADDR,CONTENT,SENDTIME,MKBS,SBID,ORGID,SIGN,JGFZ,CZRY,CJR,CJSJ) values("];
                [sql appendFormat:@"'%@','%@','%@',to_date('%@' , 'yyyy-mm-dd hh24:mi:ss'),'%@','%@','%@','%@','%@','%@','%@',sysdate)",xh,
                 numberStr,text,sendTime,@"PBDX",g_appDelegate.udid,g_logedUserInfo.userORGID,sign,g_logedUserInfo.userDanwei,g_logedUserInfo.userName,g_logedUserInfo.userName];
            }
        }
        
    
        NSString* params = [WebServiceHelper createParametersWithKey:@"cmdTexts"
                                                               value:sql,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    
    

        NSString *URL = [NSString stringWithFormat:KQueueServiceURL,g_appDelegate.ServerIP];
        webService = [[WebServiceHelper alloc] initWithUrl:URL
                                                    method:@"ProcessQueues_Ipad_Log_UDID"
                                                      view:self.view
                                                 nameSpace:KSoapNameSpace
                                                parameters:params
                                                  delegate:self];
        webService.hudTitle = @"正在发送，请稍候...";
        webService.errMsg = @"发送信息失败，请检查网络后重试！";
        [webService run];
    
}

- (BOOL)verifyPhoneNumber:(NSString *)mobileNum{
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    
    //        NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHS];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}


- (void)handleSwipe:(UIGestureRecognizer *)guestureRecognizer
{
    [self.inputView.textView resignFirstResponder];
}

- (void)addAddressee:(id)sender {
    UIControl *control = (UIControl*)sender;
    ContactListViewController *contactViewController = [[ContactListViewController alloc] initWithStyle:UITableViewStylePlain];
    contactViewController.contactDelegate = self;
    contactViewController.contentSizeForViewInPopover = CGSizeMake(320, 480);
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:contactViewController];
    
    UIPopoverController *tmpPopover = [[UIPopoverController alloc] initWithContentViewController:controller];
    self.popController = tmpPopover;
    
     [contactViewController release];
    [tmpPopover release];
    [controller release];
   
    
    [self.popController presentPopoverFromRect:control.frame
                                        inView:self.messageView
                      permittedArrowDirections:UIPopoverArrowDirectionUp
                                      animated:YES];
    
    self.contactTxt.text = @"";
    
}

- (void)addMessageInfo:(id)sender {
    if (isAdd) {
        return;
    }
    
    data_type = INPUT_DATA;
    _contactTxt.text = @"";
    NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithCapacity:3];
    [newItem setObject:@"新消息" forKey:@"sender"];
    
    if (_listData == nil || [_listData count] < 1) {
        self.listData = [NSMutableArray arrayWithObject:newItem];
        [self.listTableView reloadData];
    }
    
 
    else {
    [self.listData insertObject:newItem atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
       
    [self.listTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    [self.listTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewRowAnimationTop];
    }
    self.bubbleData  = [NSMutableArray arrayWithCapacity:1];
    [_bubbleTable reloadData];
    
    self.detailItem.title = @"新消息";
    [self.contactTxt becomeFirstResponder];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self     action:@selector(cancelAddMessage:)];
    self.detailItem.rightBarButtonItem = cancelButton;
    [cancelButton release];
    
    [self addAnimation];
    isAdd = YES;
    
}

- (void)addAnimation{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"NewMessage" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    float orignY = self.addContactView.frame.origin.y;
    CGRect rect = CGRectMake(281, orignY+132, 488, 44);
    self.addContactView.frame =rect;
    //self.addContactView.alpha = 1;
    
    orignY = _bubbleTable.frame.origin.y;
    rect = CGRectMake(0, orignY+44, 488, 960);
    self.bubbleTable.frame = rect;
    
    [UIView commitAnimations];
    
}

- (void)cancelAnimation{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"NewMessage" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    float orignY = self.addContactView.frame.origin.y;
    CGRect rect = CGRectMake(281, orignY-132, 488, 44);
    self.addContactView.frame =rect;
    
    orignY = _bubbleTable.frame.origin.y;
    rect = CGRectMake(0, orignY-44, 488, 960);
    self.bubbleTable.frame = rect;
    
    [UIView commitAnimations];
    
    
    self.inputView.sendButton.enabled = NO;

}

- (void)cancelAddMessage:(id)sender {

    [self cancelAnimation];
    [self.contactTxt resignFirstResponder];
     [self.inputView.textView resignFirstResponder];
    self.inputView.hidden = YES;
    [self.listData removeObjectAtIndex:0];
    NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    [self.listTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    self.detailItem.rightBarButtonItem = nil;
    NSIndexPath *indexPath = [self.listTableView indexPathForSelectedRow];
    NSInteger row = indexPath.row;
    
    
    if ([_listData count] >1) {
        NSDictionary *msgDict = [_listData objectAtIndex:row];
        NSString *numberStr = [msgDict objectForKey:@"send_number"];
        NSString *senderStr    = [msgDict objectForKey:@"sender"];
        if ([senderStr isEqualToString:@""] || senderStr == nil) {
            _detailItem.title = numberStr;
        }
        else {
            _detailItem.title = senderStr;
        }
        
         [self.listTableView selectRowAtIndexPath:[indexPaths objectAtIndex:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
    isAdd = NO;
}

// -------------------------------------------------------------------------------
//	initWithNibName:bundle:
// -------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initMessageData];
        data_type = SELECT_DATA;
        isSearch = NO;
    }
    return self;
}

- (void)initMessageData{
    DBHelper *helper = [DBHelper sharedInstance];
     NSArray *resultData  = [helper queryMessageList];
    
    if ([resultData count] < 1) {
        return;
    }
    
    self.listData = [NSMutableArray arrayWithArray:resultData];
    
    NSDictionary *msgDict = [_listData objectAtIndex:0];
    NSString *numberStr = [msgDict objectForKey:@"send_number"];
    
    resultData  = [helper queryMessageInfo:numberStr];
    
    NSMutableArray *bubbleAry =  [NSMutableArray arrayWithCapacity:1];
    for (NSDictionary *resultDict in resultData) {
        NSString *dateStr = [resultDict objectForKey:@"send_date"];
        NSString *infoStr  = [resultDict objectForKey:@"send_info"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:dateStr];
        [bubbleAry addObject:[NSBubbleData dataWithText:infoStr andDate:date andType:BubbleTypeMine]];
        
        [dateFormatter release];
    }
    
    self.bubbleData = bubbleAry;
    
    [_bubbleTable reloadData];
}

#pragma mark -
#pragma mark View lifecycle

// -------------------------------------------------------------------------------
//	viewDidLoad:
// -------------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationItem *masterItem =  [[UINavigationItem alloc] init];
    masterItem.title = @"信息";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(backItemPressed:)];
    
    
    UIBarButtonItem *composeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(addMessageInfo:)];
    
    masterItem.leftBarButtonItem = backButton;
    masterItem.rightBarButtonItem = composeButton;
    
    _masterNavBar.items = [NSArray arrayWithObject:masterItem];
    [masterItem release];
    
    NSDictionary *msgDict = [_listData objectAtIndex:0];
    NSString *numberStr = [msgDict objectForKey:@"send_number"];
    NSString *sender    = [msgDict objectForKey:@"sender"];
    _detailItem =  [[UINavigationItem alloc] init];
    _detailNavBar.items = [NSArray arrayWithObject:_detailItem];
   
    if ([sender isEqualToString:@""] || sender == nil) {
        _detailItem.title = numberStr;
        self.phoneNumber = numberStr;
    }
    else {
        _detailItem.title = sender;
        self.phoneNumber = numberStr;
        self.receiver = sender;
    }


    
//    UIBarButtonItem *listButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:nil];
//    
//    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(addMessageInfo:)];
//    
//    _detailItem.leftBarButtonItem = listButton;
//    _detailItem.rightBarButtonItem = editButton;
   
        
    CGSize size = self.messageView.frame.size;
    CGRect inputFrame = CGRectMake(0.0f, size.height - INPUT_HEIGHT, size.width, INPUT_HEIGHT);
    _inputView = [[MessageInputView alloc] initWithFrame:inputFrame];
    self.inputView.textView.delegate = self;
    [self.inputView.sendButton addTarget:self action:@selector(sendPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageView addSubview:self.inputView];
        
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    swipe.numberOfTouchesRequired = 1;
    [self.inputView addGestureRecognizer:swipe];
    
    self.bubbleTable.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1.0];
    
    
    _bubbleTable.bubbleDataSource = self;
    
    [_bubbleTable reloadData];

    
    if ([_listData count]>= 1) {
        [self.listTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    }
    else {
        self.inputView.hidden = YES;
    }

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [self viewDidAppear:YES];
    [self scrollToBottomAnimated:NO];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillShowKeyboard:)
												 name:UIKeyboardWillShowNotification
                                               object:nil];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillHideKeyboard:)
												 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark selectLinkManDelegate
- (void)returnContacts:(NSString *)users Numbers:(NSArray *)numbers{
    data_type = SELECT_DATA;
    self.contactTxt.text = users;
    NSMutableString *numberStr = [NSMutableString string];
    
    for(int i =0;i <[numbers count];i++) {
        NSString *number  = [numbers objectAtIndex:i];
        if (i==0) {
            [numberStr appendString:number];
        }
        else {
            [numberStr appendFormat:@",%@",number];
        }
    }
    self.receiver = users;
    self.phoneNumber = numberStr;
    if (_popController) {
         [_popController dismissPopoverAnimated:YES];
    }
}

#pragma mark -
#pragma mark UIBubbleTableViewDataSource implementation

// -------------------------------------------------------------------------------
//	rowsForBubbleTable:
// -------------------------------------------------------------------------------
- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [_bubbleData count];
}

// -------------------------------------------------------------------------------
//	bubbleTableView:dataForRow:
// -------------------------------------------------------------------------------
- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [_bubbleData objectAtIndex:row];
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    if ([_bubbleTable numberOfSections] < 1) {
        return;
    }

    NSInteger lastSection =  [_bubbleTable numberOfSections] - 1;
    NSInteger rows = [_bubbleTable numberOfRowsInSection:lastSection];
    
    if(rows > 0) {
        [_bubbleTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1  inSection:lastSection]
                           atScrollPosition:UITableViewScrollPositionBottom
                                   animated:animated];
//        float width = _bubbleTable.frame.size.width;
//        float height= _bubbleTable.frame.size.height;
//        float originX = _bubbleTable.frame.origin.x;
//        float originY = _bubbleTable.frame.origin.y;
//        if (originY == 0) {
//            CGRect rect=CGRectMake(originX,originY-40,width,height);
//            _bubbleTable.frame = rect;
//        }
        
    }
}


#pragma mark -
#pragma mark UITableView DataSource

// -------------------------------------------------------------------------------
//	tableView:numberOfRowsInSection:
// -------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_listData count];
}

// -------------------------------------------------------------------------------
//	numberOfSectionsInTableView:
// -------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// -------------------------------------------------------------------------------
//  tableView:heightForRowAtIndexPath
// -------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 916.0/11;
}

// -------------------------------------------------------------------------------
//  tableView:cellForRowAtIndexPath:
// -------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *myIdentifier = @"myIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier] autorelease];
        
        UILabel *sender = [[UILabel alloc] initWithFrame:CGRectMake(20, 4, 160, 30)];
        sender.lineBreakMode = NSLineBreakByTruncatingTail;
        sender.font  = [UIFont boldSystemFontOfSize:17];
        sender.tag = 101;
        [cell.contentView addSubview:sender];
        [sender release];
        
        
        UILabel *detailInfo = [[UILabel alloc] initWithFrame:CGRectMake(20, 26, 240, 52)];
        detailInfo.textColor = [UIColor grayColor];
        detailInfo.backgroundColor = [UIColor clearColor];
        detailInfo.font = [UIFont systemFontOfSize:15];
        detailInfo.tag  = 103;
        detailInfo.numberOfLines = 0;
        //detailInfo.text = @"Marge, there's something that I want to ask you, but I'm afraid, because if you say no, it will destroy me and make me a criminal.";
        [cell.contentView addSubview:detailInfo];
        [detailInfo release];
        
        
        UILabel *sendDate = [[UILabel alloc] initWithFrame:CGRectMake(210, 4, 60, 30)];
        //sendDate.text = @"13-6-8";
        sendDate.textColor = [UIColor colorWithRed:68.0/255.0 green:155.0/255.0 blue:1.0 alpha:1.0];
        sendDate.font = [UIFont systemFontOfSize:14];
        sendDate.tag = 102;
        [cell.contentView addSubview:sendDate];
        [sendDate release];
    }
    
    NSDictionary *messageDict = [_listData objectAtIndex:indexPath.row];
    NSString *senderStr =[messageDict objectForKey:@"sender"];
    NSString *numberStr = [messageDict objectForKey:@"send_number"];
    NSString *messageStr = [messageDict objectForKey:@"send_info"];
    NSString *latelyStr = [messageDict objectForKey:@"lately"];
    latelyStr = [latelyStr substringWithRange:NSMakeRange(2, 8)];
    
    
    if ([latelyStr isEqualToString:@""] || latelyStr == nil) {
        latelyStr = [messageDict objectForKey:@"send_date"];
        latelyStr = [latelyStr substringWithRange:NSMakeRange(2, 8)];
    }
    
    if (senderStr == nil || [senderStr isEqualToString:@""]) {
        
    }
    
    UILabel *sender = (UILabel *)[cell viewWithTag:101];
    sender.text = senderStr;
    if (senderStr == nil || [senderStr isEqualToString:@""]) {
         sender.text = numberStr;
    }
    
    UILabel *sendDate = (UILabel *)[cell viewWithTag:102];
    sendDate.text = latelyStr;
    
    UILabel *detailInfo = (UILabel *)[cell viewWithTag:103];
    detailInfo.text = messageStr;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// -------------------------------------------------------------------------------
//  滑动删除
// -------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSDictionary *itemDict = [self.listData objectAtIndex:indexPath.row];
    NSString *send_number = [itemDict objectForKey:@"send_number"];
    DBHelper *helper = [DBHelper sharedInstance];
     [helper deleteRecordMessageList:send_number];

    if (isAdd) {
        [self cancelAnimation];
       
        [self.contactTxt resignFirstResponder];
        [self.inputView.textView resignFirstResponder];
        self.inputView.hidden = YES;
        
        isAdd = NO;
    }
    
    [self.listData removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.listTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    [self.bubbleData removeAllObjects];
    [self.bubbleTable reloadData];
    self.detailItem.rightBarButtonItem = nil;
    _detailItem.title = @"";
    
}

#pragma mark -
#pragma mark UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *msgDict = [_listData objectAtIndex:indexPath.row];
    NSString *numberStr = [msgDict objectForKey:@"send_number"];
    NSString *sender    = [msgDict objectForKey:@"sender"];
    
    DBHelper *helper = [DBHelper sharedInstance];
    NSArray *resultData  = [helper queryMessageInfo:numberStr];
    
    NSMutableArray *bubbleAry =  [NSMutableArray arrayWithCapacity:1];
    for (NSDictionary *resultDict in resultData) {
        NSString *dateStr = [resultDict objectForKey:@"send_date"];
        NSString *infoStr  = [resultDict objectForKey:@"send_info"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:dateStr];
        [bubbleAry addObject:[NSBubbleData dataWithText:infoStr andDate:date andType:BubbleTypeMine]];
        
        [dateFormatter release];
        
    }
    self.bubbleData = bubbleAry;
    
    
    if ([sender isEqualToString:@""] || sender == nil) {
        _detailItem.title = numberStr;
    }
    else {
        _detailItem.title = sender;
    }
   
    
    [_bubbleTable reloadData];
    
    if (isAdd) {
        [self cancelAddMessage:nil];
    }
    
}

#pragma mark - UISearchBar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
     isSearch = YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   
    DBHelper *helper = [DBHelper sharedInstance];
    NSArray *resultData  = [helper queryMessageInfo:searchText];
    self.listData = [NSMutableArray arrayWithArray:resultData];
    [_listTableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    isSearch = NO;
}


#pragma mark - Text view delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
	
    if(!self.previousTextViewContentHeight)
		self.previousTextViewContentHeight = textView.contentSize.height;
    
    [self scrollToBottomAnimated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat maxHeight = [MessageInputView maxHeight];
    CGFloat textViewContentHeight = textView.contentSize.height;
    CGFloat changeInHeight = textViewContentHeight - self.previousTextViewContentHeight;
    
    changeInHeight = (textViewContentHeight + changeInHeight >= maxHeight) ? 0.0f : changeInHeight;
    
    if(changeInHeight != 0.0f) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             UIEdgeInsets insets = UIEdgeInsetsMake(0.0f, 0.0f,   _bubbleTable.contentInset.bottom +  changeInHeight, 0.0f);
                             _bubbleTable.contentInset = insets;
                             _bubbleTable.scrollIndicatorInsets = insets;
                             
                             [self scrollToBottomAnimated:NO];
                             
                             CGRect inputViewFrame = self.inputView.frame;
                             self.inputView.frame = CGRectMake(0.0f,
                                                               inputViewFrame.origin.y - changeInHeight,
                                                               inputViewFrame.size.width,
                                                               inputViewFrame.size.height + changeInHeight);
                         }
                         completion:^(BOOL finished) {
                         }];
        
        self.previousTextViewContentHeight = MIN(textViewContentHeight, maxHeight);
    }
    
    self.inputView.sendButton.enabled = ((NSString *)[textView.text trimWhitespace].length > 0);
}

#pragma mark - Keyboard notifications
- (void)handleWillShowKeyboard:(NSNotification *)notification
{
    [self keyboardWillShowHide:notification];
}

- (void)handleWillHideKeyboard:(NSNotification *)notification
{
    [self keyboardWillShowHide:notification];
}

- (void)keyboardWillShowHide:(NSNotification *)notification
{
    if (self.inputView.hidden && !isSearch) {
        self.inputView.hidden = NO;
    }
    
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGFloat keyboardY = [self.messageView convertRect:keyboardRect fromView:nil].origin.y;
                         
                         CGRect inputViewFrame = self.inputView.frame;
                         self.inputView.frame = CGRectMake(inputViewFrame.origin.x,
                                                           keyboardY - inputViewFrame.size.height,
                                                           inputViewFrame.size.width,
                                                           inputViewFrame.size.height);
                         
                         UIEdgeInsets insets = UIEdgeInsetsMake(0.0f,
                                                                0.0f,
                                                                self.messageView .frame.size.height - self.inputView.frame.origin.y - INPUT_HEIGHT,
                                                                0.0f);
                         
                         _bubbleTable.contentInset = insets;
                         _bubbleTable.scrollIndicatorInsets = insets;
                     }
                     completion:^(BOOL finished) {
                     }];
}

#pragma mark -
#pragma mark NSXMLParser Delegate
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	
	if( [elementName isEqualToString:@"ProcessQueues_Ipad_Log_UDIDResult"])
	{
		currentData = [NSMutableString string];
	}
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (currentData)
		[currentData appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	
	if(currentData && [elementName isEqualToString:@"ProcessQueues_Ipad_Log_UDIDResult"])
	{
		if([currentData isEqualToString:@"true"])
		{
            if (isAdd) {
                [self cancelAnimation];
                 isAdd = NO;
            }
            
           
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
            
            [dateFormatter release];

            NSDictionary *itemDict = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumber,@"send_number",_messageTxt,@"send_info",dateStr,@"send_date",_receiver,@"sender",nil];
            [_listData replaceObjectAtIndex:0 withObject:itemDict];
            [_listTableView reloadData];
            
            [_bubbleData addObject:[NSBubbleData dataWithText:self.messageTxt andDate:[NSDate dateWithTimeIntervalSinceNow:400] andType:BubbleTypeMine]];
            
            DBHelper *helper = [DBHelper sharedInstance];
            [helper saveMessage:self.messageTxt number:self.phoneNumber sender:self.receiver];
            
            [_bubbleTable reloadData];

			UIAlertView *alert = [[UIAlertView alloc]
								  initWithTitle:@"提示"
								  message:@"信息发送成功"
								  delegate:self
								  cancelButtonTitle:@"确定"
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
            
            
            self.inputView.textView.text = @"";
            [self.inputView.textView resignFirstResponder];
            _detailItem.rightBarButtonItem = nil;
            
            if (!self.receiver || [_receiver isEqualToString:@""]) {
                _detailItem.title = self.phoneNumber;
            }
            else {
                _detailItem.title = self.receiver;
            }
            
            
            //recordStatus= Record_Commited_Success;
            //[[DBHelper sharedInstance] saveXCZFBH:self.xczfbh Wrymc:self.wrymc TableName:self.tableName];
            
		}
		else {
			
			UIAlertView *alert = [[UIAlertView alloc]
								  initWithTitle:@"错误"
								  message:@"提交数据到服务器失败！"  delegate:self
								  cancelButtonTitle:@"确定"
								  otherButtonTitles:nil];
            [[[alert subviews] objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0.5 green:0.0f blue:0.0f alpha:1.0f]];
			[alert show];
			[alert release];
            //recordStatus = Record_Commited_Failed;
		}
		
	}
}

@end
