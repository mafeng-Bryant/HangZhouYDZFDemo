//
//  AccessoryItem.h
//  GMEPS_HZ
//
//  Created by TianZhuLi on 14-3-21.
//
//描述附件的信息

#import <Foundation/Foundation.h>

@interface AccessoryItem : NSObject

@property(strong,nonatomic) NSString *TID;
@property(strong,nonatomic) NSString *downloadURL;
@property(strong,nonatomic) NSString *filePath;
@property(strong,nonatomic) NSString *fileName;

- (id)initWithTID:(NSString *)tid downloadURL:(NSString *)downloadURL filePath:(NSString *)FilePath fileName:(NSString *)FileName;

@end
