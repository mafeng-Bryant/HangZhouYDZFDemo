//
//  UICustomPhotoCell.h
//  NanShanApp
//
//  Created by zhang on 12-10-25.
//  Copyright (c) 2012年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  UICustomPhotoCellDelegate

-(void)sendImgFile:(NSString*)filePath;
-(void)showImgFile:(NSString*)filePath;
@end

@interface UICustomPhotoCell : UIView
@property(nonatomic,copy)NSString *fullImgPath;
@property(nonatomic,retain)id<UICustomPhotoCellDelegate> delegate;
- (id)initWithFrame:(CGRect)frame ImgPath:(NSString*)imgPath andDelegate:(id<UICustomPhotoCellDelegate>)aDelegate;
@end
