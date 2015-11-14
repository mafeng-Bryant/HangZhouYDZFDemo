//
//  WasteDetailViewController.h
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-6-21.
//
//

#import <UIKit/UIKit.h>

@interface WasteDetailViewController : UIViewController<UIWebViewDelegate> {
    IBOutlet UIWebView *detailView;
}
@property (nonatomic, retain) NSDictionary *detailDict;
@end
