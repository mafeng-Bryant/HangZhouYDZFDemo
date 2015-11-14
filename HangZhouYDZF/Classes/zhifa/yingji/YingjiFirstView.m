//
//  YingjiFirstView.m
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-15.
//
//

#import "YingjiFirstView.h"
#import <math.h>
@implementation YingjiFirstView
@synthesize  dwmcField,dwdzField,dwLocate,huanbaozg,linkNumber,dwjingdu,dwweidu,mgdNameField,mgdTypeField,mgdJingdu,mgdWeidu,mgdZXJLField,locateButton,fswryzField,fswrpfField,fqwryzField,fqwrpfField,fspfqxField,dwzycpscnl,systemEditTimeField,systemisPrefectField,systemisEstimate,systemisRecord,systemisTrain,systemlastField,systemisExer,exerciseYears,yearLabel,lineImageView,productCase,loadLabel,loadTxt,emergencyPeople,numberLabel,emergencyNumbers,aqyhSegCtr,tzqkSegCtr;
@synthesize wxfwName1,wxfwcapacity1,wxfwccsffhSegCtr1,wxfwxyqx1,wxfwName2,wxfwcapacity2,wxfwccsffhSegCtr2,wxfwxyqx2,wxfwName3,wxfwcapacity3,wxfwccsffhSegCtr3,wxfwxyqx3;

-(id)init{
    self = [[[[NSBundle mainBundle] loadNibNamed:@"YingjiFirstView" owner:self options:nil] objectAtIndex:0] retain];
    return self;
}


-(NSDictionary*)getValueData{
    NSMutableDictionary *dicValues = [NSMutableDictionary dictionaryWithCapacity:15];
    [dicValues setValue:dwmcField.text forKey:@"DWMC"];
    [dicValues setValue:dwdzField.text forKey:@"DWDZ"];
    [dicValues setValue:dwLocate.text forKey:@"SSQY"];
    [dicValues setValue:huanbaozg.text forKey:@"HBZG"];
    [dicValues setValue:linkNumber.text forKey:@"LXDH"];
    [dicValues setValue:fqwryzField.text forKey:@"FQWRYZ"];
    [dicValues setValue:fswryzField.text forKey:@"FSWRYZ"];
    [dicValues setValue:fswrpfField.text forKey:@"FSPFL"];
    [dicValues setValue:fqwrpfField.text forKey:@"FQPFL"];
    [dicValues setValue:fspfqxField.text forKey:@"FSPFQX"];
    [dicValues setValue:dwzycpscnl.text forKey:@"ZYCPJSCL"];
    
    [dicValues setValue:mgdNameField.text forKey:@"MGDMC"];
    [dicValues setValue:mgdTypeField.text forKey:@"MGDLX"];
   
    [dicValues setValue:mgdZXJLField.text forKey:@"MGDZXJL"];
    
    
    [dicValues setValue:[productCase titleForSegmentAtIndex:productCase.selectedSegmentIndex] forKey:@"SCQK"];
    [dicValues setValue:loadTxt.text forKey:@"SCFH"];
    
    [dicValues setValue:[emergencyPeople titleForSegmentAtIndex:emergencyPeople.selectedSegmentIndex] forKey:@"YJDWZL"];
    [dicValues setValue:emergencyNumbers.text forKey:@"YJDWRS"];
    [dicValues setValue:exerciseYears.text forKey:@"YJYL"];
    [dicValues setValue:systemisPrefectField.text forKey:@"SFWS"];
    [dicValues setValue:[systemisEstimate titleForSegmentAtIndex:systemisEstimate.selectedSegmentIndex] forKey:@"SFJGPG"];
    [dicValues setValue:[systemisRecord titleForSegmentAtIndex:systemisRecord.selectedSegmentIndex] forKey:@"SFZHBBA"];
    [dicValues setValue:[systemisTrain titleForSegmentAtIndex:systemisTrain.selectedSegmentIndex] forKey:@"SFJGPX"];
    
    [dicValues setValue:[aqyhSegCtr titleForSegmentAtIndex:aqyhSegCtr.selectedSegmentIndex] forKey:@"HJAQYHPC"];
    
    [dicValues setValue:[tzqkSegCtr titleForSegmentAtIndex:tzqkSegCtr.selectedSegmentIndex] forKey:@"TZQK"];
    
    if([systemEditTimeField.text length] > 0)
        [dicValues setValue:systemEditTimeField.text forKey:@"YABZSJ"];
    if([systemlastField.text length] > 0)
        [dicValues setValue:systemlastField.text forKey:@"ZJYCSJ"];
    
    
    NSMutableString *wxfwNameStr = [NSMutableString stringWithCapacity:5];
    NSMutableString *wxfwcapacityStr = [NSMutableString stringWithCapacity:5];
    
    NSMutableString *wxfwxyqxStr =[NSMutableString stringWithCapacity:5];
    NSMutableString *wxfwccStr = [NSMutableString stringWithCapacity:5];
    
    [wxfwNameStr appendFormat:@"%@",wxfwName1.text];
    [wxfwNameStr appendFormat:@",%@",wxfwName2.text];
    [wxfwNameStr appendFormat:@",%@",wxfwName3.text];
   
    [wxfwcapacityStr appendFormat:@"%@",wxfwcapacity1.text];
    [wxfwcapacityStr appendFormat:@",%@",wxfwcapacity2.text];
    [wxfwcapacityStr appendFormat:@",%@",wxfwcapacity3.text];
   
    
    
    [wxfwxyqxStr appendFormat:@"%@",wxfwxyqx1.text];
    [wxfwxyqxStr appendFormat:@",%@",wxfwxyqx2.text];
    [wxfwxyqxStr appendFormat:@",%@",wxfwxyqx3.text];
  
    
    [wxfwccStr appendFormat:@"%@",[wxfwccsffhSegCtr1 titleForSegmentAtIndex:wxfwccsffhSegCtr1.selectedSegmentIndex]];
    
    [wxfwccStr appendFormat:@",%@",[wxfwccsffhSegCtr2 titleForSegmentAtIndex:wxfwccsffhSegCtr2.selectedSegmentIndex]];
    
    [wxfwccStr appendFormat:@",%@",[wxfwccsffhSegCtr3 titleForSegmentAtIndex:wxfwccsffhSegCtr3.selectedSegmentIndex]];
    
      
    [dicValues setValue:wxfwNameStr forKey:@"WXFWMC"];
    [dicValues setValue:wxfwcapacityStr forKey:@"WXFWZCL"];
    [dicValues setValue:wxfwccStr forKey:@"WXFWCCSFFH"];
    [dicValues setValue:wxfwxyqxStr forKey:@"WXFWXYQX"];
    
    return dicValues;
}


- (NSString *)decimalCovertDegree:(NSString *) dicimal{
    float dicimalDegree = [dicimal floatValue];
   int degree  =  [dicimal intValue];
    
   int minute =  (dicimalDegree - degree)*60;
    
   int second = round(((dicimalDegree - degree)*60 - minute)*60) ;
    
    NSString *result = [NSString stringWithFormat:@"%d°%d′%d″",degree,minute,second];
    return  result;
}

-(void)loadData:(NSDictionary*)values{
    
    NSString *editStr =  [values objectForKey:@"YABZSJ"];
    editStr= [[editStr componentsSeparatedByString:@" "] objectAtIndex:0];
   systemEditTimeField.text = [editStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    
    NSString *lastStr   = [values objectForKey:@"ZJYCSJ"];
    lastStr= [[lastStr componentsSeparatedByString:@" "] objectAtIndex:0];
    systemlastField.text = [lastStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    dwmcField.text = [values objectForKey:@"DWMC"];
    dwdzField.text = [values objectForKey:@"DWDZ"];
    
    NSString *wryJD = [values objectForKey:@"JD"];
    dwjingdu.text =  [self decimalCovertDegree:wryJD];
    
    NSString *wryWD = [values objectForKey:@"WD"];
    dwweidu.text = [self decimalCovertDegree:wryWD];
    
    dwLocate.text = [values objectForKey:@"SSQY"];
    huanbaozg.text = [values objectForKey:@"HBZG"];
    linkNumber.text = [values objectForKey:@"LXDH"];
    fspfqxField.text = [values objectForKey:@"FSPFQX"];
    fswrpfField.text = [values objectForKey:@"FSPFL"];
    fqwrpfField.text = [values objectForKey:@"FQPFL"];
    
    dwzycpscnl.text = [values objectForKey:@"ZYCPJSCL"];
    
    mgdNameField.text = [values objectForKey:@"MGDMC"];
    mgdTypeField.text = [values objectForKey:@"MGDLX"];
    
    NSString *mgdJD = [values objectForKey:@"MGDJD"];
    mgdJingdu.text = [self decimalCovertDegree:mgdJD];
    
    NSString *mgdWD = [values objectForKey:@"MGDWD"];
    mgdWeidu.text = [self decimalCovertDegree:mgdWD];
    mgdZXJLField.text =[values objectForKey:@"MGDZXJL"];
    
    fqwryzField.text = [values objectForKey:@"FQWRYZ"];
    fswryzField.text = [values objectForKey:@"FSWRYZ"];
    
    
    
    NSString *selectTitle = @"无";
    if ([[values objectForKey:@"YJYL"]length] < 1) {
        for (int n=0; n < systemisExer.numberOfSegments; n++) {
            NSString *title = [systemisExer titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                systemisExer.selectedSegmentIndex = n;
            }
        }
        
        yearLabel.hidden = YES;
        lineImageView.hidden = YES;
        exerciseYears.hidden = YES;
        
    }
    
    selectTitle = [values objectForKey:@"SCQK"];
    loadTxt.text = [values objectForKey:@"SCFH"];
    if ([[values objectForKey:@"SCFH"] length] > 0) {
        for (int n=0; n < productCase.numberOfSegments; n++) {
            NSString *title = [productCase titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                productCase.selectedSegmentIndex = n;
            }
        }
        
        loadLabel.hidden = NO;
        loadTxt.hidden = NO;
    }
    
    selectTitle = [values objectForKey:@"YJDWZL"];
    emergencyNumbers.text = [values objectForKey:@"YJDWRS"];
    if ([[values objectForKey:@"YJDWZL"] length] > 0) {
        for (int n=0; n < emergencyPeople.numberOfSegments; n++) {
            NSString *title = [emergencyPeople titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                emergencyPeople.selectedSegmentIndex = n;
            }
        }
        
        numberLabel.hidden = NO;
        emergencyNumbers.hidden = NO;
    }

    exerciseYears.text = [values objectForKey:@"YJYL"];
    systemisPrefectField.text = [values objectForKey:@"SFWS"];
    
    selectTitle = [values objectForKey:@"SFJGPG"];
    for (int n=0; n < systemisEstimate.numberOfSegments; n++) {
        NSString *title = [systemisEstimate titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            systemisEstimate.selectedSegmentIndex = n;
        }
    }
    
    selectTitle = [values objectForKey:@"SFZHBBA"];
    for (int n=0; n < systemisRecord.numberOfSegments; n++) {
        NSString *title = [systemisRecord titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            systemisRecord.selectedSegmentIndex = n;
        }
    }
    
    selectTitle =  [values objectForKey:@"SFJGPX"];
    for (int n=0; n < systemisTrain.numberOfSegments; n++) {
        NSString *title = [systemisTrain titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            systemisTrain.selectedSegmentIndex = n;
        }
    }
    
    
    NSString *wxfwNameStr = [values objectForKey:@"WXFWMC"];
    NSString *wxfwcapacityStr = [values objectForKey:@"WXFWZCL"];
    NSString *wxfwxyqxStr =[values objectForKey:@"WXFWXYQX"];
    NSString *wxfwccStr   =[values objectForKey:@"WXFWCCSFFH"];
    
    NSArray *wxfwNameAry = [wxfwNameStr componentsSeparatedByString:@","];
    NSArray *wxfwcapacityAry = [wxfwcapacityStr componentsSeparatedByString:@","];
    
    NSArray *wxfwxyqxAry = [wxfwxyqxStr componentsSeparatedByString:@","];
    NSArray *wxfwccAry = [wxfwccStr componentsSeparatedByString:@","];
    
    
    wxfwName1.text = [wxfwNameAry objectAtIndex:0];
    wxfwcapacity1.text = [wxfwcapacityAry objectAtIndex:0];
    selectTitle  = [wxfwccAry objectAtIndex:0];
    for (int n=0; n < wxfwccsffhSegCtr1.numberOfSegments; n++) {
        NSString *title = [wxfwccsffhSegCtr1 titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            wxfwccsffhSegCtr1.selectedSegmentIndex = n;
        }
    }
    wxfwxyqx1.text = [wxfwxyqxAry objectAtIndex:0];
    
    wxfwName2.text = [wxfwNameAry objectAtIndex:1];
    wxfwcapacity2.text = [wxfwcapacityAry objectAtIndex:1];
    selectTitle  = [wxfwccAry objectAtIndex:1];
    for (int n=0; n < wxfwccsffhSegCtr2.numberOfSegments; n++) {
        NSString *title = [wxfwccsffhSegCtr2 titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            wxfwccsffhSegCtr2.selectedSegmentIndex = n;
        }
    }
    wxfwxyqx2.text = [wxfwxyqxAry objectAtIndex:1];
    
    
    wxfwName3.text = [wxfwNameAry objectAtIndex:2];
    wxfwcapacity3.text = [wxfwcapacityAry objectAtIndex:2];
    selectTitle  = [wxfwccAry objectAtIndex:2];
    for (int n=0; n < wxfwccsffhSegCtr2.numberOfSegments; n++) {
        NSString *title = [wxfwccsffhSegCtr2 titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            wxfwccsffhSegCtr2.selectedSegmentIndex = n;
        }
    }
    wxfwxyqx3.text = [wxfwxyqxAry objectAtIndex:2];
    
    
    
    wxfwName3.text = [wxfwNameAry objectAtIndex:2];
    wxfwcapacity3.text = [wxfwcapacityAry objectAtIndex:2];
    selectTitle  = [wxfwccAry objectAtIndex:2];
    for (int n=0; n < wxfwccsffhSegCtr3.numberOfSegments; n++) {
        NSString *title = [wxfwccsffhSegCtr3 titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            wxfwccsffhSegCtr3.selectedSegmentIndex = n;
        }
    }
    wxfwxyqx3.text = [wxfwxyqxAry objectAtIndex:2];
    
    
    selectTitle = [values objectForKey:@"HJAQYHPC"];
    for (int n=0; n < aqyhSegCtr.numberOfSegments; n++) {
        NSString *title = [aqyhSegCtr titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            aqyhSegCtr.selectedSegmentIndex = n;
        }
    }
    
    selectTitle = [values objectForKey:@"TZQK"];
    for (int n=0; n < tzqkSegCtr.numberOfSegments; n++) {
        NSString *title = [tzqkSegCtr titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            tzqkSegCtr.selectedSegmentIndex = n;
        }
    }

    
}

-(void)dealloc{
    [dwmcField release];
    [dwdzField release];
    [dwLocate release];
    [huanbaozg release];
    [linkNumber release];
    [dwjingdu release];
    [dwweidu release];
    [mgdNameField release];
    [mgdTypeField release];
    [mgdJingdu release];
    [mgdWeidu release];
    [mgdZXJLField release];
    [locateButton release];
    [fspfqxField release];
    [fswrpfField release];
    [fqwrpfField release];
    [dwzycpscnl release];
    [systemEditTimeField release];
    [systemisPrefectField release];
    [systemisEstimate release];
    [systemisRecord release];
    [systemisTrain release];
    
    [systemlastField release];
    [systemisExer release];
    [exerciseYears release];
    [yearLabel release];
    [lineImageView release];
    
    [loadLabel release];
    [loadTxt release];
    [productCase release];
    
    [wxfwName1 release];
    [wxfwcapacity1 release];
    [wxfwccsffhSegCtr1 release];
    [wxfwxyqx1 release];
    
    [wxfwName2 release];
    [wxfwcapacity2 release];
    [wxfwccsffhSegCtr2 release];
    [wxfwxyqx2 release];
    
    [wxfwName3 release];
    [wxfwcapacity3 release];
    [wxfwccsffhSegCtr3 release];
    [wxfwxyqx3 release];
    
    [emergencyPeople release];
    [emergencyNumbers release];
    [numberLabel release];
    
    [aqyhSegCtr release];
    [tzqkSegCtr release];
    
    [super dealloc];
}
@end
