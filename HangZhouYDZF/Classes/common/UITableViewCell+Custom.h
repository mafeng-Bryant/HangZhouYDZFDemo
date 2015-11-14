//
//  NSString+MD5Addition.h
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITableViewCell (Custom)

+(UITableViewCell*)makeSubCell:(UITableView *)tableView
					 withTitle:(NSString *)aTitle
						 value:(NSString *)aValue;

+(UITableViewCell*)makeSubCell:(UITableView *)tableView 
                     withTitle:(NSString *)title
                     SubValue1:(NSString *)value1 
                     SubValue2:(NSString *)value2 
                     SubValue3:(NSString *)value3
                     SubValue4:(NSString *)value4;

+(UITableViewCell*)makeSubCell:(UITableView *)tableView 
                     withTitle:(NSString *)title
                     SubValue1:(NSString *)value1 
                     SubValue2:(NSString *)value2 
                     SubValue3:(NSString *)value3;

//一周的cell
+(UITableViewCell*)makeWeekCell:(UITableView *)tableView
                      withTexts:(NSArray *)titleAry
                       andImage:(UIImage*)image;


+(UITableViewCell*)makeSubCell:(UITableView *)tableView 
                     withTitle:(NSString *)title
                        sender:(NSString *)aSender 
                      withDate:(NSString*) aDate;


//信访列表表栏编辑方法
+ (UITableViewCell *)makeSubCell:(UITableView *)tableView 
                       withTitle:(NSString *)aTitle
                        caseCode:(NSString *)aCode 
                   complaintDate:(NSString *)aCDate 
                         endDate:(NSString *)aEDate
                            Mode:(NSString *)aMode;


//一栏两项的编辑方法(普通表)
+ (UITableViewCell *)makeSubCell:(UITableView *)tableView
                      withTitle:(NSString *)aTitle
                         title2:(NSString *)aTitle2
                          value:(NSString *)aValue
                         value2:(NSString *)aValue2
                          height:(NSInteger)aHeight;


//带textview的表栏编辑方法
+ (UITableViewCell *)makeSubCell:(UITableView *)tableView
                       withTitle:(NSString *)aTitle
                         andText:(NSString *)aText
                          height:(NSInteger)aHeight;


//流程表栏编辑方法
+ (UITableViewCell *)makeSubCell:(UITableView *)tableView
                           Title:(NSString *)aTitle
                         Opinion:(NSString *)aOpinion
                       Signature:(NSString *)aSignature;

+(UITableViewCell*)makeSubCell:(UITableView *)tableView
					 withTitle:(NSString *)aTitle
                       endDate:(NSString*)date
                          isaj:(NSString*)aj;

+ (UITableViewCell*)makeSubCell:(UITableView *)tableView
                      withTitle:(NSString *)aTitle
                          value:(NSString *)aValue
                         height:(NSInteger)aHeight;

+ (UITableViewCell*)makeSubVenCell:(UITableView *)tableView
                         withTitle:(NSString *)aTitle
                            title1:(NSString *)aTitle1
                            title2:(NSString *)aTitle2
                            value1:(NSString *)aValue1
                            value2:(NSString *)aValue2
                            height:(NSInteger)aHeight;

+ (UITableViewCell*)makeSubVenCell:(UITableView *)tableView
                         withTitle:(NSString *)aTitle
                             value:(NSString *)aValue
                            height:(NSInteger)aHeight;
@end
