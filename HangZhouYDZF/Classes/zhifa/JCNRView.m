//
//  JCNRView.m
//  GMEPS_HZ
//
//  Created by zhang on 13-4-7.
//
//

#import "JCNRView.h"


@implementation JCNRView


-(id)init{
    self = [[[[NSBundle mainBundle] loadNibNamed:@"JCNRView" owner:self options:nil] objectAtIndex:0] retain];
    if (self) {
        


    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(NSDictionary*)getValueData{
    NSMutableDictionary *dicValues = [NSMutableDictionary dictionaryWithCapacity:5];
    [dicValues setValue:zycpField.text forKey:@"ZYCP"];

    [dicValues setValue:xcfzrzwField.text forKey:@"XCFZRZW"];
    [dicValues setValue:xcfzrdhField.text forKey:@"XCFZRDH"];
    
    [dicValues setValue:[scqkSegCtrl titleForSegmentAtIndex:scqkSegCtrl.selectedSegmentIndex] forKey:@"SCQK"];
    [dicValues setValue:[scsbSegCtrl titleForSegmentAtIndex:scsbSegCtrl.selectedSegmentIndex] forKey:@"SCSB"];
    [dicValues setValue:[qyhbglzdSegCtrl titleForSegmentAtIndex:qyhbglzdSegCtrl.selectedSegmentIndex] forKey:@"QYHBGLZD"];
    [dicValues setValue:[wryssczgcSegCtrl titleForSegmentAtIndex:wryssczgcSegCtrl.selectedSegmentIndex] forKey:@"WRYSSCZGC"];
    
    if(wsSwitch.on){ //污水
        [dicValues setValue:[wsssyxjlSegCtrl titleForSegmentAtIndex:wsssyxjlSegCtrl.selectedSegmentIndex] forKey:@"WSSSYXJL"];
        [dicValues setValue:[wsclssyxSegCtrl titleForSegmentAtIndex:wsclssyxSegCtrl.selectedSegmentIndex] forKey:@"WSCLSSYX"];
        [dicValues setValue:[wspfkgfhSegCtrl titleForSegmentAtIndex:wspfkgfhSegCtrl.selectedSegmentIndex] forKey:@"WSPFKGFH"];
        [dicValues setValue:[wsyjtjSegCtrl titleForSegmentAtIndex:wsyjtjSegCtrl.selectedSegmentIndex] forKey:@"WSYJTJ"];
        [dicValues setValue:pfszggmsField.text forKey:@"PFSZGGMS"];
        [dicValues setValue:[xcsfcySegCtrl titleForSegmentAtIndex:xcsfcySegCtrl.selectedSegmentIndex] forKey:@"XCSFCY"];
        
    }
    
    if(fqSwitch.on){//废气
        [dicValues setValue:[fqpfkgfhSegCtrl titleForSegmentAtIndex:fqpfkgfhSegCtrl.selectedSegmentIndex] forKey:@"FQPFKGFH"];
        
        [dicValues setValue:[fqssyxjlSegCtrl titleForSegmentAtIndex:fqssyxjlSegCtrl.selectedSegmentIndex] forKey:@"FQSSYXJL"];
        [dicValues setValue:[fqyjtjSegCtrl titleForSegmentAtIndex:fqyjtjSegCtrl.selectedSegmentIndex] forKey:@"FQYJTJ"];
         [dicValues setValue:[yqhdSegCtrl titleForSegmentAtIndex:yqhdSegCtrl.selectedSegmentIndex] forKey:@"YQHD"];
        [dicValues setValue:[fqclssyxSegCtrl titleForSegmentAtIndex:fqclssyxSegCtrl.selectedSegmentIndex] forKey:@"FQCLSSYX"];
        [dicValues setValue:[gyfqwzzpfSegCtrl titleForSegmentAtIndex:gyfqwzzpfSegCtrl.selectedSegmentIndex] forKey:@"GYFQWZZPF"];
        
    }
    
    if(wxfwSwitch.on){
        [dicValues setValue:wfmcField.text forKey:@"WFMC"];
        [dicValues setValue:[sfssSegCtrl titleForSegmentAtIndex:sfssSegCtrl.selectedSegmentIndex] forKey:@"SFSS"];
        [dicValues setValue:[bzbsSegCtrl titleForSegmentAtIndex:bzbsSegCtrl.selectedSegmentIndex] forKey:@"BZBS"];
         [dicValues setValue:[zyldSegCtrl titleForSegmentAtIndex:zyldSegCtrl.selectedSegmentIndex] forKey:@"ZYLD"];
    }
    
    if(cySwitch.on){
        [dicValues setValue:[cyyyjhssSegCtrl titleForSegmentAtIndex:cyyyjhssSegCtrl.selectedSegmentIndex] forKey:@"CYYYJHSS"];
        [dicValues setValue:[cyyyjhssyxSegCtrl titleForSegmentAtIndex:cyyyjhssyxSegCtrl.selectedSegmentIndex] forKey:@"CYYYJHSSYX"];
        [dicValues setValue:[cypwxkzSegCtrl titleForSegmentAtIndex:cypwxkzSegCtrl.selectedSegmentIndex] forKey:@"CYPWXKZ"];
        [dicValues setValue:cypwfjnField.text forKey:@"CYPWFJN"];
    }
    return dicValues;

}

-(void)modifySeg:(UISegmentedControl*)segCtrl Value:(NSString*)value{
    if (value == nil) {
        return;
    }
    for (int i = 0; i < segCtrl.numberOfSegments; i++) {
        if([[segCtrl titleForSegmentAtIndex:i] isEqualToString:value]){
            segCtrl.selectedSegmentIndex = i;
            break;
        }
    }
}

-(void)loadData:(NSDictionary*)values{
    zycpField.text = [NSString stringWithFormat:@"%@", [values objectForKey:@"ZYCP"]];
    pfszggmsField.text = [values objectForKey:@"PFSZGGMS"];
    wfmcField.text = [NSString stringWithFormat:@"%@",[values objectForKey:@"WFMC"]];
    cypwfjnField.text = [NSString stringWithFormat:@"%@",[values objectForKey:@"CYPWFJN"]];
    xcfzrzwField.text = [NSString stringWithFormat:@"%@",[values objectForKey:@"XCFZRZW"]];
    xcfzrdhField.text = [NSString stringWithFormat:@"%@",[values objectForKey:@"XCFZRDH"]];
    
    [self modifySeg:scqkSegCtrl Value:[values objectForKey:@"SCQK"]];
    [self modifySeg:scsbSegCtrl Value:[values objectForKey:@"SCSB"]];
    [self modifySeg:qyhbglzdSegCtrl Value:[values objectForKey:@"QYHBGLZD"]];
    [self modifySeg:wryssczgcSegCtrl Value:[values objectForKey:@"WRYSSCZGC"]];

    [self modifySeg:wsclssyxSegCtrl Value:[values objectForKey:@"WSCLSSYX"]];    
    [self modifySeg:wspfkgfhSegCtrl Value:[values objectForKey:@"WSPFKGFH"]];
    
    
    [self modifySeg:wsssyxjlSegCtrl Value:[values objectForKey:@"WSSSYXJL"]];
    [self modifySeg:fqyjtjSegCtrl Value:[values objectForKey:@"FQYJTJ"]];
    [self modifySeg:xcsfcySegCtrl Value:[values objectForKey:@"XCSFCY"]];
    [self modifySeg:yqhdSegCtrl Value:[values objectForKey:@"YQHD"]];
    [self modifySeg:gyfqwzzpfSegCtrl Value:[values objectForKey:@"GYFQWZZPF"]];
    [self modifySeg:sfssSegCtrl Value:[values objectForKey:@"SFSS"]];    
    [self modifySeg:zyldSegCtrl Value:[values objectForKey:@"ZYLD"]];
    [self modifySeg:bzbsSegCtrl Value:[values objectForKey:@"BZBS"]];
    [self modifySeg:cyyyjhssSegCtrl Value:[values objectForKey:@"CYYYJHSS"]];

    [self modifySeg:cyyyjhssyxSegCtrl Value:[values objectForKey:@"CYYYJHSSYX"]];
    [self modifySeg:cypwxkzSegCtrl Value:[values objectForKey:@"CYPWXKZ"]];
    [self modifySeg:fqclssyxSegCtrl Value:[values objectForKey:@"FQCLSSYX"]];    
    [self modifySeg:fqpfkgfhSegCtrl Value:[values objectForKey:@"FQPFKGFH"]];
    [self modifySeg:wsyjtjSegCtrl Value:[values objectForKey:@"WSYJTJ"]];
    [self modifySeg:fqssyxjlSegCtrl Value:[values objectForKey:@"FQSSYXJL"]];
    
    if([values objectForKey:@"WSSSYXJL"] == nil || [[values objectForKey:@"WSSSYXJL"] length] == 0){
        wsSwitch.on = NO;
        wsLabel.hidden = NO;
    }
    if([values objectForKey:@"FQPFKGFH"] == nil || [[values objectForKey:@"FQPFKGFH"] length] == 0){
        fqSwitch.on = NO;
        fqLabel.hidden = NO;
    }
    if([values objectForKey:@"CYYYJHSS"] == nil || [[values objectForKey:@"CYYYJHSS"] length] == 0){
        cySwitch.on = NO;
        cyLabel.hidden = NO;
    }
    if([values objectForKey:@"SFSS"] == nil || [[values objectForKey:@"SFSS"] length] == 0){
        wxfwSwitch.on = NO;
        wxfwLabel.hidden = NO;
    }
    
}

-(IBAction)switchValChanged:(id)sender{
    if([sender isEqual:wsSwitch]){
         wsLabel.hidden = wsSwitch.on;
    }
    else if([sender isEqual:fqSwitch]){
        fqLabel.hidden = fqSwitch.on;
    }
    else if([sender isEqual:wxfwSwitch]){
        wxfwLabel.hidden = wxfwSwitch.on;
    }
    else if([sender isEqual:cySwitch]){
        cyLabel.hidden = cySwitch.on;
    }
    
}
@end
