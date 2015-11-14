//
//  GoodsSelectViewController.h
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-5-9.
//
//

#import <UIKit/UIKit.h>
@protocol GoodsCountDelegate <NSObject>

- (void)returnEmergencyGoods:(NSString *)goods Quantity:(NSString *)quantity;

@end

@interface GoodsSelectViewController : UIViewController
@property(nonatomic,retain)IBOutlet UITextField *GoodsType1;//应急物资其他1
@property(nonatomic,retain)IBOutlet UITextField *GoodsType2;//应急物资其他2
@property(nonatomic,retain)IBOutlet UITextField *GoodsType3;//应急物资其他3
@property(nonatomic,retain)IBOutlet UITextField *GoodsType4;//应急物资其他4
@property(nonatomic,retain)IBOutlet UITextField *GoodsQuantity1;//应急物资存量1
@property(nonatomic,retain)IBOutlet UITextField *GoodsQuantity2;//应急物资存量2
@property(nonatomic,retain)IBOutlet UITextField *GoodsQuantity3;//应急物资存量3
@property(nonatomic,retain)IBOutlet UITextField *GoodsQuantity4;//应急物资存量4
@property(nonatomic,retain)IBOutlet UITextField *GoodsQuantity5;//应急物资存量5
@property(nonatomic,retain)IBOutlet UITextField *GoodsQuantity6;//应急物资存量6
@property(nonatomic,retain)IBOutlet UITextField *GoodsQuantity7;//应急物资存量7
@property(nonatomic,retain)IBOutlet UITextField *GoodsQuantity8;//应急物资存量8
@property(nonatomic,assign) id<GoodsCountDelegate> delegate;
@end
