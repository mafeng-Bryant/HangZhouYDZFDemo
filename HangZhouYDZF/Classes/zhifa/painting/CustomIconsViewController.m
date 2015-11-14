//
//  CustomIconsViewController.m
//  GMEPS_HZ
//
//  Created by 张 仁松 on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomIconsViewController.h"

@implementation CustomIconItem
@synthesize imgName;
@synthesize title;

- (id)initWithWithImg:(NSString *)imageName
                       andTitle:(NSString*)aTitle{
    self = [super init];
    if (self) {
        self.imgName = imageName;
        self.title = aTitle;
    }

    return self;
}
@end



@implementation CustomIconsViewController
@synthesize scrollView,aryItems,delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)btnPressed:(id)sender{
    
    UIButton *imgBtn  = (UIButton*)sender;
    if([aryItems count] <= imgBtn.tag) return;
    CustomIconItem *item = [aryItems objectAtIndex:imgBtn.tag];
    [delegate selectedItemImageName:item.imgName];

}

-(void)setupItems{
    NSArray *array = [NSArray arrayWithObjects:@"gufei.png",@"gelu.png",@"yancong.png",@"feiqi.png" ,@"noise.png",@"air.png",@"water.png",@"sub.png",@"biao.png",@"rain.png",@"paikou.png",@"radio.png",@"danger.png",@"road_p.png",@"road_l.png",@"river_l.png",@"river_p.png",@"pipe_p.png",@"pipe_l.png",nil];
    NSArray *array1 = [NSArray arrayWithObjects:@"固废",@"锅炉",@"烟囱",@"废气",@"噪声排放源",@"废气处理设施",@"废水处理设施",@"总排口",@"标排口",@"雨水排口",@"排口",@"辐射源",@"危险废物",@"道路",@"道路",@"河流",@"河流",@"水管",@"水管", nil];
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:35];
    for (int i = 0; i < [array count]; i++) {
        CustomIconItem *item = [[[CustomIconItem alloc] initWithWithImg:[array objectAtIndex:i] andTitle:[array1 objectAtIndex:i]] autorelease];
        [tmpArray addObject:item];
    }
    self.aryItems = tmpArray;
    /*
    CustomIconItem *item1 = [[[CustomIconItem alloc] initWithWithImg:@"gufei.png" andTitle:@"固废"] autorelease];
    CustomIconItem *item2 = [[[CustomIconItem alloc] initWithWithImg:@"gelu.png" andTitle:@"锅炉"] autorelease];
    CustomIconItem *item3 = [[[CustomIconItem alloc] initWithWithImg:@"yancong.png" andTitle:@"烟囱"] autorelease];
    CustomIconItem *item4 = [[[CustomIconItem alloc] initWithWithImg:@"feiqi.png" andTitle:@"废气"] autorelease];
    CustomIconItem *item5 = [[[CustomIconItem alloc] initWithWithImg:@"pic.png" andTitle:@"排口"] autorelease];
    self.aryItems = [NSArray arrayWithObjects:item1,item2,item3,item4,item5, nil];
    */
    
    int tabWidth = 13;
    int width = 106,height = 120;
    int imgWidth = 80,imgHeight = 80;
    int labelWidth = 106,labelHeight = 40;
    
    int rows = ([aryItems count]+2)/3;
    [scrollView setContentSize:CGSizeMake(320, rows*height)];
    
    CGRect imgRect;
    CGRect labelRect;
     imgRect = CGRectMake(tabWidth, 0, imgWidth, imgHeight);
    labelRect = CGRectMake(0, imgHeight, labelWidth, labelHeight);
    for (int i =0; i < [aryItems count]; i++) {
        CustomIconItem *aItem = [aryItems objectAtIndex:i];
       
        UIButton *imgBtn = [[UIButton alloc] initWithFrame:imgRect];
        [imgBtn setImage:[UIImage imageNamed:aItem.imgName] forState:UIControlStateNormal];
        [imgBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        imgBtn.tag = i;
        [self.scrollView addSubview:imgBtn];
        [imgBtn release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
        [label setText:aItem.title];
        [label setTextAlignment:UITextAlignmentCenter];
        label.numberOfLines = 2;
        [self.scrollView addSubview:label];
        [label release];
        
        if ((i+1)%3 == 0) {
            imgRect.origin.x = tabWidth;
            imgRect.origin.y += height;
            
            labelRect.origin.x = 0;
            labelRect.origin.y += height;
            
        }
        else{
            imgRect.origin.x += width+1;
            labelRect.origin.x += labelWidth+1;
        }
        
    }
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentSizeForViewInPopover = CGSizeMake(320, 480);
    [self setupItems];
    self.view.userInteractionEnabled = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end
