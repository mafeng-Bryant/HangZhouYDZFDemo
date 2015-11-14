//
//  UICustomPhotoCell.m
//  NanShanApp
//
//  Created by zhang on 12-10-25.
//  Copyright (c) 2012年 zhang. All rights reserved.
//

#import "UICustomPhotoCell.h"


@implementation UICustomPhotoCell
@synthesize fullImgPath,delegate;

- (id)initWithFrame:(CGRect)frame ImgPath:(NSString*)imgPath andDelegate:(id<UICustomPhotoCellDelegate>)aDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.fullImgPath = imgPath;
        self.delegate = aDelegate;
        // Initialization code
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"customphotocell.png"]];
        bgView.frame = CGRectMake(0, 0, 256, 287);
        [self addSubview:bgView];
        [bgView release];
        
        UIButton *btnImage = [[UIButton alloc] initWithFrame:CGRectMake(25, 15, 210, 210)];
        [btnImage setImage:[UIImage imageWithContentsOfFile:fullImgPath] forState:UIControlStateNormal];
        [btnImage addTarget:self action:@selector(clickedImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnImage];
        [btnImage release];
        
        UIButton *btnSend = [[UIButton alloc] initWithFrame:CGRectMake(75, 240, 120, 35)];
        [btnSend addTarget:self action:@selector(clickedSendButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnSend];
        [btnSend release];
        
        
    }
    return self;
}


-(void)clickedImage:(id)sender{
    [delegate showImgFile:fullImgPath];
}

-(void)clickedSendButton:(id)sender {
    [delegate sendImgFile:fullImgPath];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
