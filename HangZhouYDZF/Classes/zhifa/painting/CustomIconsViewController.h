//
//  CustomIconsViewController.h
//  GMEPS_HZ
//
//  Created by 张 仁松 on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CustomIconItem:NSObject
@property(nonatomic,retain)NSString *imgName;
@property(nonatomic,retain)NSString* title;
- (id)initWithWithImg:(NSString *)imageName
             andTitle:(NSString*)aTitle;
@end

@protocol  CustomIconDelegate

-(void)selectedItemImageName:(NSString*)imgName;

@end

@interface CustomIconsViewController : UIViewController
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) NSArray *aryItems;// 存放CustomIconItem的数组

@property(nonatomic,assign) id<CustomIconDelegate> delegate;
@end
