//
//  GGDMJConfig.h
//  GMEPS_HZ
//
//  Created by zhang on 13-4-8.
//
//

#import <Foundation/Foundation.h>

@interface GGDMJConfig : NSObject
+(NSArray*)getDMNRByDMJBH:(NSString*)dmjbh;
+(NSString*)getDMByDMJBH:(NSString*)dmjbh andDMNR:(NSString*)dmnr;
+(NSString*)getDMNRByDMJBH:(NSString*)dmjbh andDM:(NSString*)dm;
@end
