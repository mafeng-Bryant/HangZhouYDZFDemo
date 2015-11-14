//
//  LKDrawLabBgImage.m
//  LabGradualchange
//
//  Created by Pemg kare on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LKDrawLabBgImage.h"

@implementation LKDrawLabBgImage

+ (UIImageView*)getParameterCreateLabBgImage:(NSString*)_strContent strFont:(UIFont*)_strFont
{
//    
    NSString  *strTrimSpaceName   =   [_strContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    CGSize    sizeLabel           =   [strTrimSpaceName sizeWithFont:_strFont];
    
    CGSize    sizeRealLabel       =   CGSizeMake(sizeLabel.width + 40,
                                                               sizeLabel.height + 10);
    
    CGRect backRect = CGRectMake(0,0,sizeRealLabel.width+2 , sizeRealLabel.height+2);
    
    CGRect frontRect = CGRectMake(1,1,sizeRealLabel.width , sizeRealLabel.height);
    
    
    UILabel                 *backLab       =   [[UILabel alloc] init];

    [backLab.layer setMasksToBounds:YES];
    
    [backLab.layer setCornerRadius:15.0f];
    
    [backLab setFrame:backRect]; 
    
    UILabel                 *frontLab       =   [[UILabel alloc] init];
    
    [frontLab.layer setMasksToBounds:YES];
    
    [frontLab.layer setCornerRadius:15.0f];
    
    [frontLab setFrame:frontRect];
    
    
    UILabel                 *textLab       =   [[UILabel alloc] init];
    
    [textLab.layer setMasksToBounds:YES];
    
    [textLab.layer setCornerRadius:15.0f];
    
    [textLab setFrame:frontRect]; 
    
    [textLab setTextAlignment:UITextAlignmentCenter];
    
    [textLab setBackgroundColor:[UIColor clearColor]];
    
    [textLab setText:strTrimSpaceName];
    
    [textLab setFont:_strFont];
    
    UIImageView *tempImage = [[UIImageView alloc] initWithFrame:backRect];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    float red[4] = {163.0/255.0, 189.0/255.0, 235.0/255.0, 1,};
    float green[4] = {142.0/255.0, 162.0/255.0, 223.0/255.0, 1,};
    float blue[4] = {120.0/255.0, 132.0/255.0, 216.0/255.0, 1,};
    
    CGColorRef red1 = CGColorCreate(colorSpace, red);
    CGColorRef green1 = CGColorCreate(colorSpace, green);
    CGColorRef blue1 = CGColorCreate(colorSpace, blue);    
    
    NSArray *colors = [NSArray arrayWithObjects:(__bridge id) red1, (__bridge id) green1, (__bridge id) blue1,nil];
    
    CGColorRelease(red1);
    CGColorRelease(green1);
    CGColorRelease(blue1);
    
    
	CAGradientLayer *_gradientFontLayer = [CAGradientLayer layer];
    _gradientFontLayer.Colors = colors;
    _gradientFontLayer.locations = [NSArray arrayWithObjects:
                                    [NSNumber numberWithFloat:0.0], 
                                    [NSNumber numberWithFloat:0.4], 
                                    [NSNumber numberWithFloat:0.9], 
                                    nil];
    [_gradientFontLayer setMasksToBounds:YES];
    [_gradientFontLayer setCornerRadius:15.0f];
    [_gradientFontLayer setFrame:backLab.layer.frame];
    [tempImage.layer addSublayer:_gradientFontLayer];
    
    
    
    float red2[4] = {221.0/255.0, 231.0/255.0, 246.0/255.0, 1,};
    float green2[4] = {205.0/255.0, 218.0/255.0, 239.0/255.0, 1,};
    float blue2[4] = {191.0/255.0, 207.0/255.0, 234.0/255.0, 1,};
    
    CGColorRef red3 = CGColorCreate(colorSpace, red2);
    CGColorRef green3 = CGColorCreate(colorSpace, green2);
    CGColorRef blue3 = CGColorCreate(colorSpace, blue2);    
    
    NSArray *colors2 = [NSArray arrayWithObjects:(__bridge id) red3, (__bridge id) green3, (__bridge id) blue3,nil];
    
    CGColorSpaceRelease(colorSpace);
    CGColorRelease(red3);
    CGColorRelease(green3);
    CGColorRelease(blue3);
    
	CAGradientLayer *_gradientFontLayer2 = [CAGradientLayer layer];
    _gradientFontLayer2.Colors = colors2;
    _gradientFontLayer2.locations = [NSArray arrayWithObjects:
                                     [NSNumber numberWithFloat:0.0], 
                                     [NSNumber numberWithFloat:0.4], 
                                     [NSNumber numberWithFloat:0.9], 
                                     nil];
    [_gradientFontLayer2 setMasksToBounds:YES];
    [_gradientFontLayer2 setCornerRadius:15.0f];
    [_gradientFontLayer2 setFrame:frontLab.layer.frame];
    [tempImage.layer addSublayer:_gradientFontLayer2];
    
    [tempImage addSubview:textLab];
    
	return tempImage;
}

@end