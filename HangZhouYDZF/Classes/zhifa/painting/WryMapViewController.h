//
//  WryMapViewController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

#define IMAGE_MapSTL   3     //是否使用地图为模板
@protocol WryMapDelegate

-(void)returnMapImage:(UIImage*)image;

@end
@interface WryMapViewController : UIViewController<BMKGeneralDelegate,BMKMapViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>{
    NSInteger iAlertType;
    
}
@property(nonatomic,retain) BMKMapView* mapView;
@property(nonatomic,retain) BMKMapManager* mapManager;
@property(nonatomic,assign) id<WryMapDelegate> delegate;
@property(nonatomic,assign) CLLocationCoordinate2D coor;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property(nonatomic,assign) BOOL isMapImage;
@property(nonatomic,retain) NSMutableDictionary *dicLocation;

-(void)saveImage:(id)sender;
-(void)locatong:(id)sender;
@end
