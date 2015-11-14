//
//  WryLocationVC.m
//  GMEPS_HZ
//
//  Created by 张仁松 on 13-4-25.
//
//

#import "WryLocationVC.h"

@interface WryLocationVC ()
@property (nonatomic, copy) NSString *JingDu;
@property (nonatomic, copy) NSString *WeiDu;
@end

@implementation WryLocationVC
@synthesize CLController,delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [_JingDu release];
    [_WeiDu release];
    [CLController release];
    [super dealloc];
}

-(IBAction)useLocation:(id)sender{
   
    if (delegate) {
        [delegate returnLatitude:self.WeiDu Longitude:self.JingDu];
    }
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.contentSizeForViewInPopover = CGSizeMake(320, 480);
    CLController = [[CoreLocationController alloc] init];
	CLController.delegate = self;
    [CLController.locMgr startUpdatingLocation];
}

-(NSString*)locationTransformation:(CLLocationDegrees )sender{
    NSString *all_N = [NSString stringWithFormat:@"%f", sender];
    //得到度的值
    NSRange duRange = [all_N rangeOfString:@"."];
    NSString *duTrue = [NSString stringWithFormat:@"%@",[all_N substringToIndex:duRange.location]];
    //得到分的值
    NSString *fenStr = [NSString stringWithFormat:@"0%@",[all_N substringFromIndex:duTrue.length]];
    NSString *allFenStr = [NSString stringWithFormat:@"%f",[fenStr floatValue]*60];
    NSRange fenRange = [allFenStr rangeOfString:@"."];
    NSString *fenTrue = [NSString stringWithFormat:@"%@",[allFenStr substringToIndex:fenRange.location]];
    //得到秒的值
    NSString *miaoStr = [NSString stringWithFormat:@"0%@",[allFenStr substringFromIndex:fenTrue.length]];
    NSString *allMiaoStr = [NSString stringWithFormat:@"%f",[miaoStr floatValue]*60];
    NSRange miaoRange = [allMiaoStr rangeOfString:@"."];
    NSString *miaoTrue = [NSString stringWithFormat:@"%@",[allMiaoStr substringToIndex:miaoRange.location]];
    //把值和符号合并起来
    NSString *result = [NSString stringWithFormat:@"%@.%@.%@",duTrue,fenTrue,miaoTrue];
    return result;
}

- (void)locationUpdate:(CLLocation *)location {
    NSString *longitude  = [self locationTransformation:location.coordinate.longitude];
    NSArray *jdAry = [longitude componentsSeparatedByString:@"."];
    NSString *degree = [jdAry objectAtIndex:0];
    NSString *minute = [jdAry objectAtIndex:1];
    NSString *second = [jdAry objectAtIndex:2];
    self.JingDu = [NSString stringWithFormat:@"%@.%@.%@",degree,minute,second];
    jdField.text = [NSString stringWithFormat:@"%@°%@′%@″",degree,minute,second];
    
    NSString *latitude = [self locationTransformation:location.coordinate.latitude];
    NSArray *wdAry = [latitude componentsSeparatedByString:@"."];
    degree = [wdAry objectAtIndex:0];
    minute = [wdAry objectAtIndex:1];
    second = [wdAry objectAtIndex:2];
    self.WeiDu = [NSString stringWithFormat:@"%@.%@.%@",degree,minute,second];
    wdField.text = [NSString stringWithFormat:@"%@°%@′%@″",degree,minute,second];
        
    
}

- (void)locationError:(NSError *)error {
    [delegate dismissLocation];
    NSLog(@"Error: %@",[error localizedDescription]);
    NSString *errorString; 
    switch([error code]) {
        case kCLErrorDenied:
            //Access denied by user
            errorString = @"请在系统设置中打开\"定位服务\"来允许\"环保执法通\"确定你的位置";
            //Do something...
            break;
        case kCLErrorLocationUnknown:
            //Probably temporary...
            errorString = @"获取GPS信息失败";
            //Do something else...
            break;
        default:
            errorString = @"未知错误";
            break;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorString delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [CLController.locMgr stopUpdatingLocation];
    [super viewWillDisappear:animated];
}

@end
