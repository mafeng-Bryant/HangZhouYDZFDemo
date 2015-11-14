//
//  WryMapViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WryMapViewController.h"
#import <QuartzCore/QuartzCore.h>






@implementation WryMapViewController
@synthesize mapManager,mapView;
@synthesize delegate;
@synthesize coor,locationManager;
@synthesize isMapImage;
@synthesize dicLocation;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // 要使用百度地图，请先启动BaiduMapManager
       /* mapManager = [[BMKMapManager alloc]init];
        BOOL ret = [mapManager start:@"C42968B2FB398D5C63706C36E6467DB772214220" generalDelegate:self];
        if (!ret) {
            NSLog(@"manager start failed!");
        }
        */
    
    }
     
    return self;
}

-(void)sureImageSTL{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.mapView.layer renderInContext:UIGraphicsGetCurrentContext()];
    //[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [delegate returnMapImage:image];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)saveImage:(id)sender{
    if (isMapImage == NO) {
        [self sureImageSTL];
        return;
    }
    iAlertType = IMAGE_MapSTL;
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"提示" 
                          message:@"要用该模板覆盖原来的绘图?" 
                          delegate:self 
                          cancelButtonTitle:@"确定" 
                          otherButtonTitles:@"取消",nil];
    [alert show];
    [alert release];	

}

-(void)locatong:(id)sender{
    // 设置mapView的Delegate
	locationManager = [[CLLocationManager alloc]init ];
    locationManager.delegate = self;
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    //[self.mapView setCenterCoordinate:coor animated:YES];
     

}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    coor.latitude = newLocation.coordinate.latitude;
    coor.longitude = newLocation.coordinate.longitude;
    [self.mapView setCenterCoordinate:coor animated:YES];
    //NSLog(@"经度：%g",newLocation.coordinate.latitude);
    //NSLog(@"纬度：%g",newLocation.coordinate.longitude);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [mapView setMapType:BMKMapTypeTrafficOn];
    
    // 设置mapView的Delegate
    mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 768, 1004)];
	mapView.delegate = self;
    mapView.showsUserLocation = YES;
	[self.view addSubview:mapView];
    NSString *du_N = [dicLocation objectForKey:@"JDD"];
    NSString *fen_N = [dicLocation objectForKey:@"JDF"];
    NSString *miao_N = [dicLocation objectForKey:@"JDM"];
    NSString *du_E = [dicLocation objectForKey:@"WDD"];
    NSString *fen_E = [dicLocation objectForKey:@"WDF"];
    NSString *miao_E = [dicLocation objectForKey:@"WDM"];
    CLLocationDegrees latitude;
    CLLocationDegrees longitude;
    if (du_N!=nil) {
        latitude = [du_N floatValue] + (([fen_N floatValue] + [miao_N floatValue]/60)/60);
        longitude = [du_E floatValue] + (([fen_E floatValue] + [miao_E floatValue]/60)/60);
    }
    else{
        latitude = 120.323333;
        longitude = 30.284999;
    }
        
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(longitude, latitude);
    BMKCoordinateSpan theSpan = BMKCoordinateSpanMake(0.5, 0.5);
    BMKCoordinateRegion theRegion = BMKCoordinateRegionMake(coord, theSpan);
    [mapView setRegion:theRegion];
    mapView.centerCoordinate = coord;
    
    UIBarButtonItem *aItem = [[UIBarButtonItem alloc] initWithTitle:@"剪切" style:UIBarButtonItemStyleBordered target:self action:@selector(saveImage:)];
    UIBarButtonItem *aItem2 = [[UIBarButtonItem alloc] initWithTitle:@"定位" style:UIBarButtonItemStyleBordered target:self action:@selector(locatong:)];
    
    UIToolbar *tools1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [tools1 setTintColor:[self.navigationController.navigationBar tintColor]]; 
	[tools1 setAlpha:[self.navigationController.navigationBar alpha]]; 
    NSMutableArray* buttons1 = [[NSMutableArray alloc] initWithCapacity:8];
    [buttons1 addObject:aItem];
    [buttons1 addObject:aItem2];
    [aItem release];
    [aItem2 release];
    [tools1 setItems:buttons1 animated:NO];
    [buttons1 release];
    
    UIBarButtonItem *myBItem1 = [[UIBarButtonItem alloc] initWithCustomView:tools1];
    
	self.navigationItem.rightBarButtonItem = myBItem1;
    [myBItem1 release]; 
	[tools1 release];

	
    
}
/*
-(BMKAnnotationView*)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;
        return newAnnotationView;
    }
    return nil;
}
*/
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)dealloc{
    [mapView release];
    [mapManager release];
    [locationManager release];
    [dicLocation release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}


// Override

-(BMKAnnotationView*)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"] autorelease];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;
        return newAnnotationView;
    }
    return nil;
}
/*
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
		BMKPinAnnotationView *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];   
		newAnnotation.pinColor = BMKPinAnnotationColorPurple;   
		newAnnotation.animatesDrop = YES;
		newAnnotation.draggable = YES;
        
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        newAnnotation.leftCalloutAccessoryView = btn;
        
		return newAnnotation;   
	}
	return nil;
}
*/
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (iAlertType == IMAGE_MapSTL) {
        if (buttonIndex == 0) {
            [self sureImageSTL];
        }
    }
}

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
	if (userLocation != nil) {
		NSLog(@"%f %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
	}
	
}

- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
	if (error != nil)
		NSLog(@"locate failed: %@", [error localizedDescription]);
	else {
		NSLog(@"locate failed");
	}
	
}



@end
