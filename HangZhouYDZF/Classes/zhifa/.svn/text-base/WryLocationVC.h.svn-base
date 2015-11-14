//
//  WryLocationVC.h
//  GMEPS_HZ
//
//  Created by 张仁松 on 13-4-25.
//
//

#import <UIKit/UIKit.h>
#import "CoreLocationController.h"

@protocol LocationDelegate

-(void)returnLatitude:(NSString*)latitude Longitude:(NSString*)longitude;

-(void)dismissLocation;

@end
@interface WryLocationVC : UIViewController<CoreLocationControllerDelegate>{
    IBOutlet UITextField *jdField;
    IBOutlet UITextField *wdField;
    IBOutlet UIButton    *getButton;
}

-(IBAction)useLocation:(id)sender;

@property (nonatomic, retain) CoreLocationController *CLController;
@property(nonatomic,assign)id<LocationDelegate> delegate;
@end
