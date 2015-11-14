//
//  HouseAndPublicArcSecondView.m
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-16.
//
//

#import "HouseAndPublicArcSecondView.h"

@implementation HouseAndPublicArcSecondView
@synthesize fswrfzmsTxtView,fqwrfzmsTxtView;
@synthesize zswrfzmsTxtView,gtfwclmsTxtView,hbglzdTxtView,qtTxtView;
@synthesize gtfwclSegCtrl,fqwrfzSegCtrl,zswrfzSegCtrl;


-(id)init{
    self = [[[[NSBundle mainBundle] loadNibNamed:@"HouseAndPublicArcSecondView" owner:self options:nil] objectAtIndex:0] retain];
    if (self) {
        
    }
    return self;
}




-(NSDictionary*)getValueData{
    
    NSMutableDictionary *dicValues = [NSMutableDictionary dictionaryWithCapacity:5];
    
    [dicValues setValue:fswrfzmsTxtView.text forKey:@"FSWRFZMS"];
    [dicValues setValue:fqwrfzmsTxtView.text forKey:@"FQWRFZMS"];
    [dicValues setValue:zswrfzmsTxtView.text forKey:@"ZSWRFZMS"];
    [dicValues setValue:gtfwclmsTxtView.text forKey:@"GTFWCLMS"];
    
    [dicValues setValue:hbglzdTxtView.text forKey:@"HBGLZD"];
    [dicValues setValue:qtTxtView.text forKey:@"QT"];

    [dicValues setValue:[zswrfzSegCtrl titleForSegmentAtIndex:zswrfzSegCtrl.selectedSegmentIndex] forKey:@"ZSWRFZ"];
    [dicValues setValue:[fqwrfzSegCtrl titleForSegmentAtIndex:fqwrfzSegCtrl.selectedSegmentIndex] forKey:@"FQWRFZ"];
    [dicValues setValue:[gtfwclSegCtrl titleForSegmentAtIndex:gtfwclSegCtrl.selectedSegmentIndex] forKey:@"GTFWCL"];
       
    return dicValues;
    
}

-(void)modifySeg:(UISegmentedControl*)segCtrl Value:(NSString*)value{
    for (int i = 0; i < segCtrl.numberOfSegments; i++) {
        if([[segCtrl titleForSegmentAtIndex:i] isEqualToString:value]){
            segCtrl.selectedSegmentIndex = i;
            break;
        }
    }
}


-(void)loadData:(NSDictionary*)values{
    
    
    fswrfzmsTxtView.text = [values objectForKey:@"FSWRFZMS"];
    fqwrfzmsTxtView.text = [values objectForKey:@"FQWRFZMS"];
    zswrfzmsTxtView.text = [values objectForKey:@"ZSWRFZMS"];
    
    gtfwclmsTxtView.text = [values objectForKey:@"GTFWCLMS"];
    hbglzdTxtView.text = [values objectForKey:@"HBGLZD"];
    qtTxtView.text = [values objectForKey:@"QT"];
    
    [self modifySeg:zswrfzSegCtrl Value:[values objectForKey:@"ZSWRFZ"]];
    [self modifySeg:fqwrfzSegCtrl Value:[values objectForKey:@"FQWRFZ"]];
    [self modifySeg:gtfwclSegCtrl Value:[values objectForKey:@"GTFWCL"]];
}



-(void)dealloc{
    [fswrfzmsTxtView release];
    [fqwrfzmsTxtView release];
    [zswrfzmsTxtView release];
    [gtfwclmsTxtView release];
    [hbglzdTxtView release];
    [qtTxtView release];

    [gtfwclSegCtrl release];
    [fqwrfzSegCtrl release];
    [zswrfzSegCtrl release];
    [super dealloc];
}


@end
