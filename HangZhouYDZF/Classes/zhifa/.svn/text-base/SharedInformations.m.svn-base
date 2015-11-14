//
//  SharedInformations.m
//  GMEPS_HZ
//
//  Created by chen on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SharedInformations.h"
#import "SynthesizeSingleton.h"


@implementation SharedInformations
@synthesize reasonToSurvey;
@synthesize  XCFZR,NL,SFZHM;	
@synthesize GZDW,QTJZR,ZFRY,ZFZH;	
@synthesize ZW,YBAGX,JTZZ,DH,YB,bModifiedZhiFaInfo,lastSelectedComany;	
@synthesize dicStoreTempData;
@synthesize people;
@synthesize JCR,JLR,JCRBH,JCDD,JCKSSJ,JCJSSJ,FRDB;
SYNTHESIZE_SINGLETON_FOR_CLASS(SharedInformations);

- init {
	if ((self = [super init])) {
		self.reasonToSurvey = @"";
        self.XCFZR = @"";
        self.NL = @"";
        self.SFZHM = @"";	
        self.GZDW = QTJZR;
        self.ZFRY = ZFZH;	
        self.ZW = @"";
        self.YBAGX = @"";
        self.JTZZ = @"";
        self.DH = @"";
        self.YB = @"";
        self.JCR = @"";
        self.JCRBH = @"";
        self.JLR = @"";
        self.FRDB = @"";
        self.JCDD = @"";
        self.JCKSSJ = @"";
        self.JCJSSJ = @"";
        bModifiedZhiFaInfo = NO;
        lastSelectedComany = nil;
        dicStoreTempData = [[NSMutableDictionary alloc] initWithCapacity:10];
        people = [[NSMutableArray alloc] initWithCapacity:10];
        /*
        NSString* documentsDirectory = [NSHomeDirectory() 
                                         stringByAppendingPathComponent:@"Documents//"];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"personInfolist.plist"];
         self.dicPersonInfomation = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
         */
	}
	return self;
}




@end
