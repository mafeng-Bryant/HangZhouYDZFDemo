//
//  DataSyncManager.h
//  GMEPS_HZ
//
//  Created by 张仁松 on 13-5-24.
//
//

#import <Foundation/Foundation.h>
#define LastSyncTime @"LastSyncTime"
#import "WebServiceHelper.h"

@protocol SyncWryListDelegate <NSObject>

- (void)syncDataFinished;

@end


@interface DataSyncManager : NSObject<NSXMLParserDelegate>{
    NSInteger nParserStatus;
    NSMutableString *curData;
}

@property (nonatomic, assign) id<SyncWryListDelegate> syncDelegate;
-(void)syncWryList;

@end
