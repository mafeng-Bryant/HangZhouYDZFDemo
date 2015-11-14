//
//  GoodsSelectViewController.m
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-5-9.
//
//

#import "GoodsSelectViewController.h"

@interface GoodsSelectViewController ()

@end

@implementation GoodsSelectViewController
@synthesize GoodsType1,GoodsType2,GoodsType3,GoodsType4,GoodsQuantity1,GoodsQuantity2,GoodsQuantity3,GoodsQuantity4,GoodsQuantity5,GoodsQuantity6,GoodsQuantity7,GoodsQuantity8;
@synthesize delegate;
- (void)dealloc {
    [GoodsType1 release];
    [GoodsType2 release];
    [GoodsType3 release];
    [GoodsType4 release];
    [GoodsQuantity1 release];
    [GoodsQuantity2 release];
    [GoodsQuantity3 release];
    [GoodsQuantity4 release];
    [GoodsQuantity5 release];
    [GoodsQuantity6 release];
    [GoodsQuantity7 release];
    [GoodsQuantity8 release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)countFillInfo:(id)sener{
    NSMutableString *quantity = [NSMutableString stringWithCapacity:4];
    NSMutableString *goods = [NSMutableString stringWithCapacity:4];
    

    if([GoodsQuantity1.text length] > 0) {
        
        [quantity appendString:GoodsQuantity1.text];
        [goods appendString:@"活性炭"];
    }
    
    if([GoodsQuantity2.text length] > 0) {
        if ([quantity length] < 1) {
            [goods appendString:@"酸"];
            [quantity appendString:GoodsQuantity2.text];
        }
        else {
            [quantity appendFormat:@",%@",GoodsQuantity2.text];
            [goods appendFormat:@",酸"];
        }
    }
    
    
    if([GoodsQuantity3.text length] > 0) {
        if ([quantity length] < 1) {
            [goods appendString:@"碱"];
            [quantity appendString:GoodsQuantity3.text];
        }
        else {
            [goods appendFormat:@"碱"];
            [quantity appendFormat:@",%@",GoodsQuantity3.text];
        }
    }
    
    if([GoodsQuantity4.text length] > 0 ) {
        if ([quantity length] < 1) {
            [goods appendString:@"黄沙"];
            [quantity appendString:GoodsQuantity4.text];
        }
        else {
            [goods appendFormat:@",黄沙"];
            [quantity appendFormat:@",%@",GoodsQuantity4.text];
        }
    }
    
    if([GoodsQuantity5.text length] > 0 && [GoodsType1.text length] >0 ) {
        if ([quantity length] < 1) {
            [goods appendString:GoodsType1.text];
            [quantity appendString:GoodsQuantity5.text];
        }
        else {
            [goods appendFormat:@",%@",GoodsType1.text];
            [quantity appendFormat:@",%@",GoodsQuantity5.text];
        }
    }
    
    if([GoodsQuantity6.text length] > 0  && [GoodsType2.text length] >0) {
        if ([quantity length] < 1) {
            [goods appendString:GoodsType2.text];
            [quantity appendString:GoodsQuantity6.text];
        }
        else {
            [goods appendFormat:@",%@",GoodsType2.text];
            [quantity appendFormat:@",%@",GoodsQuantity6.text];
        }
    }
    
    if([GoodsQuantity7.text length] > 0 && [GoodsType3.text length] >0) {
        if ([quantity length] < 1) {
            [goods appendString:GoodsType3.text];
            [quantity appendString:GoodsQuantity7.text];
        }
        else {
            [goods appendFormat:@",%@",GoodsType3.text];
            [quantity appendFormat:@",%@",GoodsQuantity7.text];
        }
    }
    
    if([GoodsQuantity8.text length] > 0 && [GoodsType3.text length] >0) {
        if ([quantity length] < 1) {
            [goods appendString:GoodsType4.text];
            [quantity appendString:GoodsQuantity8.text];
        }
        else {
            [goods appendFormat:@",%@",GoodsType4.text];
            [quantity appendFormat:@",%@",GoodsQuantity8.text];
        }
    }
    
    [delegate returnEmergencyGoods:goods Quantity:quantity];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(countFillInfo:)];
    self.navigationItem.rightBarButtonItem = doneItem;
    [doneItem release];
    
    
    
      
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
