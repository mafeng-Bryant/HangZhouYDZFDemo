//
//  HouseAndPublicArcFirstView.m
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-16.
//
//

#import "HouseAndPublicArcFirstView.h"

@implementation HouseAndPublicArcFirstView
@synthesize jsxmmcField,jsdwField,yqjgrqField,jsdzField;
@synthesize frdbField,frlxdhField,xmlxrField,lxrdhField;
@synthesize czField,spwhField,spsjField,wsfhjlyqField;
@synthesize zjmgdwzjjlField,sfwtzzdwkzjgysSegCtrl,xmjsqkmsTxtView;
@synthesize fswrfzSegCtrl,hylxSegCtrl,qthyField,xmjsqkSegCtrl;
@synthesize ssqkSegCtrl,gzjbSegCtrl,xmlxSegCtrl;
@synthesize hjjldwmcField,hjjlspyqSegCtrl,sfwthjjlSegCtrl,xmfzrjlxdhField;

-(id)init{
    self = [[[[NSBundle mainBundle] loadNibNamed:@"HouseAndPublicArcFirstView" owner:self options:nil] objectAtIndex:0] retain];
    if (self) {
        
        
    }
    return self;
}

-(NSDictionary*)getValueData{

    NSMutableDictionary *dicValues = [NSMutableDictionary dictionaryWithCapacity:5];
    [dicValues setValue:jsxmmcField.text forKey:@"JSXMMC"];
    [dicValues setValue:jsdwField.text forKey:@"JSDW"];
    if([yqjgrqField.text length] > 0)
        [dicValues setValue:yqjgrqField.text forKey:@"YQJGRQ"];
    [dicValues setValue:jsdzField.text forKey:@"JSDZ"];
    
    [dicValues setValue:frdbField.text forKey:@"FRDB"];
    [dicValues setValue:frlxdhField.text forKey:@"FRLXDH"];
    [dicValues setValue:xmlxrField.text forKey:@"XMLXR"];
    [dicValues setValue:lxrdhField.text forKey:@"LXRDH"];
    [dicValues setValue:xmlxrField.text forKey:@"XMLXR"];
    
    [dicValues setValue:czField.text forKey:@"CZ"];
    [dicValues setValue:spwhField.text forKey:@"SPWH"];
    if([spsjField.text length] > 0)
        [dicValues setValue:spsjField.text forKey:@"SPSJ"];
    [dicValues setValue:wsfhjlyqField.text forKey:@"WSFHJLYQ"];
    
    [dicValues setValue:zjmgdwzjjlField.text forKey:@"ZJMGDWZJJL"];
    [dicValues setValue:xmjsqkmsTxtView.text forKey:@"XMJSQKMS"];
     [dicValues setValue:hjjldwmcField.text forKey:@"HJJLDWMC"];
     [dicValues setValue:xmfzrjlxdhField.text forKey:@"XMFZRJLXDH"];
    
    
    [dicValues setValue:[sfwtzzdwkzjgysSegCtrl titleForSegmentAtIndex:sfwtzzdwkzjgysSegCtrl.selectedSegmentIndex] forKey:@"SFWTZZDWKZJGYS"];
    

    [dicValues setValue:[xmjsqkSegCtrl titleForSegmentAtIndex:xmjsqkSegCtrl.selectedSegmentIndex] forKey:@"XMJSQK"];
    [dicValues setValue:[fswrfzSegCtrl titleForSegmentAtIndex:fswrfzSegCtrl.selectedSegmentIndex] forKey:@"FSWRFZ"];
    [dicValues setValue:[hylxSegCtrl titleForSegmentAtIndex:hylxSegCtrl.selectedSegmentIndex] forKey:@"HYLX"];
    [dicValues setValue:qthyField.text forKey:@"HYLXQ"];
    [dicValues setValue:[xmlxSegCtrl titleForSegmentAtIndex:xmlxSegCtrl.selectedSegmentIndex] forKey:@"XMLX"];
    [dicValues setValue:[ssqkSegCtrl titleForSegmentAtIndex:ssqkSegCtrl.selectedSegmentIndex] forKey:@"SSQK"];
    [dicValues setValue:[gzjbSegCtrl titleForSegmentAtIndex:gzjbSegCtrl.selectedSegmentIndex] forKey:@"GZJB"];
    [dicValues setValue:[hjjlspyqSegCtrl titleForSegmentAtIndex:hjjlspyqSegCtrl.selectedSegmentIndex] forKey:@"HJJLSPYQ"];
    [dicValues setValue:[sfwthjjlSegCtrl titleForSegmentAtIndex:sfwthjjlSegCtrl.selectedSegmentIndex] forKey:@"SFWTHJJL"];
    
    
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

- (void)loadData:(NSDictionary *)values{
    NSString *yqjgrqStr =  [values objectForKey:@"YQJGRQ"];
    yqjgrqStr= [[yqjgrqStr componentsSeparatedByString:@" "] objectAtIndex:0];
    yqjgrqField.text = [yqjgrqStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];

    
    NSString *spsjStr   = [values objectForKey:@"SPSJ"];
    spsjStr= [[spsjStr componentsSeparatedByString:@" "] objectAtIndex:0];
    spsjField.text = [spsjStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
//    NSString *yqjgrqStr = [values objectForKey:@"YQJGRQ"];
//    NSString *spsjStr   = [values objectForKey:@"SPSJ"];
//    if(isRecord && ![yqjgrqStr isEqualToString:@""]){
//        yqjgrqStr =  [yqjgrqStr substringWithRange:NSMakeRange(0, 8)];
//        yqjgrqStr = [yqjgrqStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
//        yqjgrqField.text = yqjgrqStr;
//    }
//    
//    if (isRecord && ![spsjStr isEqualToString:@""]) {
//        spsjStr = [spsjStr substringWithRange:NSMakeRange(0, 8)];
//        spsjStr = [spsjStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
//        spsjField.text = spsjStr;
//    }

    jsxmmcField.text = [values objectForKey:@"JSXMMC"];
    jsdwField.text = [values objectForKey:@"JSDW"];
    
    jsdzField.text = [values objectForKey:@"JSDZ"];
    frdbField.text = [values objectForKey:@"FRDB"];
    frlxdhField.text = [values objectForKey:@"FRLXDH"];
    
    xmlxrField.text = [values objectForKey:@"XMLXR"];
    lxrdhField.text = [values objectForKey:@"LXRDH"];
    xmlxrField.text = [values objectForKey:@"XMLXR"];
    
    czField.text = [values objectForKey:@"CZ"];
    spwhField.text = [values objectForKey:@"SPWH"];
   
    
    wsfhjlyqField.text = [values objectForKey:@"WSFHJLYQ"];
    zjmgdwzjjlField.text = [values objectForKey:@"ZJMGDWZJJL"];
    xmjsqkmsTxtView.text = [values objectForKey:@"XMJSQKMS"];
    hjjldwmcField.text = [values objectForKey:@"HJJLDWMC"];
    xmfzrjlxdhField.text = [values objectForKey:@"XMFZRJLXDH"];
    qthyField.text = [values objectForKey:@"HYLXQT"];
    
    if([[values objectForKey:@"SFWTZZDWKZJGYS"] isEqualToString:@"是"]){
        sfwtzzdwkzjgysSegCtrl.selectedSegmentIndex = 0;
    }else{
        sfwtzzdwkzjgysSegCtrl.selectedSegmentIndex = 1;
    }
    [self modifySeg:xmjsqkSegCtrl Value:[values objectForKey:@"XMJSQK"]];
    [self modifySeg:fswrfzSegCtrl Value:[values objectForKey:@"FSWRFZ"]];
    [self modifySeg:hylxSegCtrl Value:[values objectForKey:@"HYLX"]];
    [self modifySeg:xmlxSegCtrl Value:[values objectForKey:@"XMLX"]];
    [self modifySeg:ssqkSegCtrl Value:[values objectForKey:@"SSQK"]];
    [self modifySeg:gzjbSegCtrl Value:[values objectForKey:@"GZJB"]];
    [self modifySeg:hjjlspyqSegCtrl Value:[values objectForKey:@"HJJLSPYQ"]];
    [self modifySeg:sfwthjjlSegCtrl Value:[values objectForKey:@"SFWTHJJL"]];
    
}



-(void)dealloc{
    [zjmgdwzjjlField release];
    [xmjsqkmsTxtView release];
    [fswrfzSegCtrl release];
    [hylxSegCtrl release];
    [xmjsqkSegCtrl release];
    [ssqkSegCtrl release];
    [gzjbSegCtrl release];
    [jsxmmcField release];
    [jsdwField release];
    [yqjgrqField release];
    [jsdzField release];
    [frdbField release];
    [frlxdhField release];
    [xmlxrField release];
    [lxrdhField release];
    [czField release];
    [spwhField release];
    [spsjField release];
    [xmlxSegCtrl release];
    [sfwtzzdwkzjgysSegCtrl release];
    [wsfhjlyqField release];
    [qthyField release];
    [super dealloc];
}

@end
