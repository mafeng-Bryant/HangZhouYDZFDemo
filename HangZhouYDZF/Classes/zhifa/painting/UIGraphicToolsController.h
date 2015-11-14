//
//  UIGraphicToolsController.h
//  GMEPS_HZ
//
//  Created by 张 仁松 on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tool.h"

@protocol SelectGraphToolDelegate
-(void)returnSelectedTool:(id <Tool>)aTool;
@end

@interface UIGraphicToolsController : UIViewController
@property(nonatomic,assign)id<SelectGraphToolDelegate> delegate;
-(IBAction)btnPressed:(id)sender;
@end
