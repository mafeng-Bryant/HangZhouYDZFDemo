//
//  InquiryWasterViewController.h
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-6-18.
//
//

#import <UIKit/UIKit.h>

@interface InquiryWasterViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton *categoryBtn;

@property (nonatomic, retain) IBOutlet UIButton *sourceBtn;

@property (nonatomic, retain) IBOutlet UIButton *featureBtn;

@property (nonatomic, retain) IBOutlet UITextField *nameField;

@property (nonatomic, retain) IBOutlet UITextField *bhField;
 
- (IBAction)inquiryByWasteCategory:(id)sender;

- (IBAction)inquiryBySourceOfIndustry:(id)sender;

- (IBAction)inquiryByFeatureOfDanger:(id)sender;

-(IBAction)searchBtnClicked:(id)sender;
@end
