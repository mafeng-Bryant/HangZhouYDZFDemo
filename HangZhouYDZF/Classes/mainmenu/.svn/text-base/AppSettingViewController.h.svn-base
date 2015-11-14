//
//  AppSettingViewController.h
//  GMEPS_HZ
//
//  Created by ZHONGWEN on 13-5-24.
//
//

#import <UIKit/UIKit.h>
@class WebServiceHelper;
@interface AppSettingViewController : UIViewController<NSXMLParserDelegate,UIAlertViewDelegate> {
    WebServiceHelper *webService;
    NSMutableData *webData;
    NSXMLParser *xmlParser;
    NSString    *currentNode;
    BOOL        _modifyStatus;
}

@property (nonatomic, retain) IBOutlet UITextField *oldPasswordField;
@property (nonatomic, retain) IBOutlet UITextField *password0Field;
@property (nonatomic, retain) IBOutlet UITextField *password1Field;
@end
