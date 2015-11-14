//
//  TakedPhotosViewController.h
//  NanShanApp
//
//  Created by zhang on 12-10-25.
//  Copyright (c) 2012年 zhang. All rights reserved.
//  展示拍取的照片

#import <UIKit/UIKit.h>
#import "UICustomPhotoCell.h"

@interface TakedPhotosViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICustomPhotoCellDelegate,UIAlertViewDelegate,NSXMLParserDelegate>
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,copy) NSString *xczfbh;//现场执法编号
@property(nonatomic,copy) NSString *attachSource;//附件来源
@property(nonatomic,strong) UITextField *nameField;//附件名称
@property(nonatomic,strong) UITextField *remarkField;//附件备注
@property(nonatomic,strong) UIProgressView *myProgressView;
@end
