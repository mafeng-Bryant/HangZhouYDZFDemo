//
//  ShowImgController.m
//  NanShanApp
//
//  Created by zhang on 12-10-25.
//  Copyright (c) 2012年 zhang. All rights reserved.
//

#import "ShowImgController.h"

@interface ShowImgController ()

@end

@implementation ShowImgController
@synthesize imgView,imgPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
    /*
    CGFloat width = 768.0;
    CGFloat height = 768.0/img.size.width*img.size.height;
    CGFloat ypos = (960-height)/2;
    CGRect rect = CGRectMake(0, ypos, width, height);
    
    imgView.frame = rect;*/
    
    imgView.image = img;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [super dealloc];
}
@end
