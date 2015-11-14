//
//  SeePhotoViewController.m
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-3-22.
//
//

#import "SeePhotoViewController.h"

@interface SeePhotoViewController ()

@end

@implementation SeePhotoViewController
@synthesize myImageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//手势缩放
- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer
{
    
    //[self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    //UIView *big = [gestureRecognizer view];
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        
            [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
            [gestureRecognizer setScale:1];
            
        
        
    }
}


-(void)Zoom:(UIView*)sender
{
    UIPinchGestureRecognizer *pinchGesture1 = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
    //[pinchGesture setDelegate:self];
    [self.view addGestureRecognizer:pinchGesture1];
    [pinchGesture1 release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"现场勘验图";
    NSString* tmpPhoto  = [NSHomeDirectory()
                               stringByAppendingPathComponent:@"Documents/tzPhoto.jpg"];
    UIImage *img = [UIImage imageWithContentsOfFile:tmpPhoto];
    self.myImageView.image = img;
    
    //[self Zoom:nil];
    
    //[self.view addSubview:myImageView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
