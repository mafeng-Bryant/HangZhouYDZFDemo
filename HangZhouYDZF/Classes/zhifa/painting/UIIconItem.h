//
//  UIIconItem.h
//  GMEPS_HZ
//
//  Created by  on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIIconItem : UIButton
@property(nonatomic,retain)UIImage *image;
+ (UIIconItem *)tabItemWithIcon:(UIImage *)icon;
@end
