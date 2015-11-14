//
//  YingjiSecondView.m
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-15.
//
//

#import "YingjiSecondView.h"

@implementation YingjiSecondView
@synthesize 
gqsffhSegCtr,reasonLabel1,gqbfhyyField,yjcsffhSegCtr,reasonLabel2,yjcbfhyyField,yjfmsfwsSegCtr,reasonLabel3,yjfmbwsyyField,wxpxzgspSegCtr,reasonLabel4,aqsczdsqSegCtr,yjccapacity,qtwtView,fsclssSegCtr,fsclssField,reasonLabel5,fqclssSegCtr,fqclssField,reasonLabel6,ydqtSegCtr,ydqtField,reasonLabel7,gqfmSegCtr,gqfmField,reasonLabel8,fszpSegCtr,gqywSegCtrl;
@synthesize wxpzjsName1,wxpzjsCapacity1,wxpzjStorage1,wxpzjType1,wxpzjsName2,wxpzjsCapacity2,wxpzjStorage2,wxpzjType2,wxpzjsName3,wxpzjsCapacity3,wxpzjStorage3,wxpzjType3,ywflSegCtr,ywflyyField,dqyjssSegCtr,yjccSegCtr,areaLabel,lineImageView,emergencyName1,emergencyQuantity1,emergencyWay1,emergencyName2,emergencyQuantity2,emergencyWay2,emergencyName3,emergencyQuantity3,emergencyWay3,qtView;

@synthesize textField1Ary,textField2Ary,textField3Ary,reduceBtnAry,curField,popController,modifyView,isAdd;

-(id)init{
    self = [[[[NSBundle mainBundle] loadNibNamed:@"YingjiSecondView" owner:self options:nil] objectAtIndex:0] retain];
    self.textField1Ary = [NSMutableArray arrayWithCapacity:3];
    self.textField2Ary = [NSMutableArray arrayWithCapacity:3];
    self.textField3Ary = [NSMutableArray arrayWithCapacity:3];
    self.reduceBtnAry  = [NSMutableArray arrayWithCapacity:3];
    yAxs = 1056.0f;
    tagCount = 0;
    isAdd = NO;
    num = 3;
    
    
    [emergencyName1 addTarget:self action:@selector(emergenccyGoodsName:) forControlEvents:UIControlEventTouchDown];
    
    [emergencyName2 addTarget:self action:@selector(emergenccyGoodsName:) forControlEvents:UIControlEventTouchDown];
    
    [emergencyName3 addTarget:self action:@selector(emergenccyGoodsName:) forControlEvents:UIControlEventTouchDown];
    
    emergencyWay1.delegate = self;
    [emergencyWay1 addTarget:self action:@selector(storageWay:) forControlEvents:UIControlEventTouchDown];
    emergencyWay2.delegate = self;
    [emergencyWay2 addTarget:self action:@selector(storageWay:) forControlEvents:UIControlEventTouchDown];
    emergencyWay3.delegate = self;
    [emergencyWay3 addTarget:self action:@selector(storageWay:) forControlEvents:UIControlEventTouchDown];
    return self;
}

-(void)dealloc{
    [wxpzjsName1 release];
    [wxpzjsCapacity1 release];
    [wxpzjStorage1 release];
    [wxpzjType1 release];
    [wxpzjsName2 release];
    [wxpzjsCapacity2 release];
    [wxpzjStorage2 release];
    [wxpzjType2 release];
    [wxpzjsName3 release];
    [wxpzjsCapacity3 release];
    [wxpzjStorage3 release];
    [wxpzjType3 release];
    
    [emergencyName1 release];
    [emergencyQuantity1 release];
    [emergencyWay1 release];
    
    [emergencyName2 release];
    [emergencyQuantity2 release];
    [emergencyWay2 release];
    
    [emergencyName3 release];
    [emergencyQuantity3 release];
    [emergencyWay3 release];
    
    [textField1Ary release];
    [textField2Ary release];
    [textField3Ary release];
    [reduceBtnAry release];
    
    [gqsffhSegCtr release];
    [gqbfhyyField release];
    [reasonLabel1 release];
    
    [yjcsffhSegCtr release];
    [yjcbfhyyField release];
    [reasonLabel2 release];
    
    
    [yjfmsfwsSegCtr release];
    [yjfmbwsyyField release];
    [reasonLabel3 release];
    
    [fszpSegCtr release];
    [gqywSegCtrl release];
    
    
    [ywflSegCtr release];
    [ywflyyField release];
    [reasonLabel4 release];
    
    [fsclssSegCtr release];
    [fsclssField release];
    [reasonLabel5 release];
    
    [fqclssSegCtr release];
    [fqclssField release];
    [reasonLabel6 release];
    
    [ydqtSegCtr release];
    [ydqtField release];
    [reasonLabel7 release];
    
    [gqfmSegCtr release];
    [gqfmField release];
    [reasonLabel8 release];
    
    
    [wxpxzgspSegCtr release];
    [aqsczdsqSegCtr release];
    [yjccapacity release];
    [qtwtView release];
    
    [dqyjssSegCtr release];
    [yjccSegCtr release];
    [areaLabel release];
    [lineImageView release];
    
    [curField release];
    [qtView release];
    [modifyView release];
    [super dealloc];
}

-(NSDictionary*)getValueData{
    NSMutableDictionary *dicValues = [NSMutableDictionary dictionaryWithCapacity:5];
    
    NSMutableString *wxpzjsNameStr = [NSMutableString stringWithCapacity:5];
    NSMutableString *wxpzjsCapacityStr = [NSMutableString stringWithCapacity:5];
    NSMutableString *wxpzjsStorageStr = [NSMutableString stringWithCapacity:5];
    NSMutableString *wxpzjsTypeStr =[NSMutableString stringWithCapacity:5];
    
    [wxpzjsNameStr appendFormat:@"%@",wxpzjsName1.text];
    [wxpzjsNameStr appendFormat:@",%@",wxpzjsName2.text];
    [wxpzjsNameStr appendFormat:@",%@",wxpzjsName3.text];
    
    
    [wxpzjsCapacityStr appendFormat:@"%@",wxpzjsCapacity1.text];
    [wxpzjsCapacityStr appendFormat:@",%@",wxpzjsCapacity2.text];
    [wxpzjsCapacityStr appendFormat:@",%@",wxpzjsCapacity3.text];
  
    
    [wxpzjsStorageStr appendFormat:@"%@",wxpzjStorage1.text];
    [wxpzjsStorageStr appendFormat:@",%@",wxpzjStorage2.text];
    [wxpzjsStorageStr appendFormat:@",%@",wxpzjStorage3.text];
    
    
    [wxpzjsTypeStr appendFormat:@"%@",wxpzjType1.text];
    [wxpzjsTypeStr appendFormat:@",%@",wxpzjType2.text];
    [wxpzjsTypeStr appendFormat:@",%@",wxpzjType3.text];
   
    
    [dicValues setValue:wxpzjsNameStr forKey:@"WXPZJSPM"];
    [dicValues setValue:wxpzjsCapacityStr forKey:@"WXPZJSZCL"];
    [dicValues setValue:wxpzjsStorageStr forKey:@"WXPZJSCCFS"];
    [dicValues setValue:wxpzjsTypeStr forKey:@"WXPZJSLB"];
    
    [dicValues setValue:[gqsffhSegCtr titleForSegmentAtIndex:gqsffhSegCtr.selectedSegmentIndex] forKey:@"GQWYFSFH"];
    [dicValues setValue:gqbfhyyField.text forKey:@"GQWYBFHLY"];
    
    
    [dicValues setValue:[gqfmSegCtr titleForSegmentAtIndex:gqfmSegCtr.selectedSegmentIndex] forKey:@"GQFMSFWS"];
    [dicValues setValue:gqfmField.text forKey:@"GQFMSFWSLY"];
    
    [dicValues setValue:[wxpxzgspSegCtr titleForSegmentAtIndex:wxpxzgspSegCtr.selectedSegmentIndex] forKey:@"WXPXZGSP"];
    [dicValues setValue:[aqsczdsqSegCtr titleForSegmentAtIndex:aqsczdsqSegCtr.selectedSegmentIndex] forKey:@"AQSCZDSQ"];
    
    [dicValues setValue:yjccapacity.text forKey:@"YJCRJ"];
    [dicValues setValue:yjcbfhyyField.text forKey:@"YJCBFHLY"];
    
    [dicValues setValue:[yjcsffhSegCtr titleForSegmentAtIndex:yjcsffhSegCtr.selectedSegmentIndex] forKey:@"YJCSFFH"];
    
    [dicValues setValue:[yjfmsfwsSegCtr titleForSegmentAtIndex:yjfmsfwsSegCtr.selectedSegmentIndex] forKey:@"YJFMSFWS"];
    [dicValues setValue:yjfmbwsyyField.text forKey:@"YJFMBWSLY"];
    
    [dicValues setValue:[ywflSegCtr titleForSegmentAtIndex:ywflSegCtr.selectedSegmentIndex] forKey:@"YWFL"];
    [dicValues setValue:ywflyyField.text forKey:@"YWFLLY"];
    
    [dicValues setValue:[fsclssSegCtr titleForSegmentAtIndex:fsclssSegCtr.selectedSegmentIndex] forKey:@"FSCLSSYX"];
    [dicValues setValue:fsclssField.text forKey:@"FSCLSSYXLY"];
    
    [dicValues setValue:[fqclssSegCtr titleForSegmentAtIndex:fqclssSegCtr.selectedSegmentIndex] forKey:@"FQCLSSYX"];
    [dicValues setValue:fqclssField.text forKey:@"FQCLSSYXLY"];
    
    [dicValues setValue:[ydqtSegCtr titleForSegmentAtIndex:ydqtSegCtr.selectedSegmentIndex] forKey:@"YDQT"];
    [dicValues setValue:ydqtField.text forKey:@"YDQTNR"];


    [dicValues setValue:[dqyjssSegCtr titleForSegmentAtIndex:dqyjssSegCtr.selectedSegmentIndex] forKey:@"DQYJSS"];
    
    [dicValues setValue:[fszpSegCtr titleForSegmentAtIndex:fszpSegCtr.selectedSegmentIndex] forKey:@"SCFSZPQDZZ"];
    
    [dicValues setValue:[gqywSegCtrl titleForSegmentAtIndex:gqywSegCtrl.selectedSegmentIndex] forKey:@"GQ"];
    
   
    
    NSMutableString *yjwzNameStr = [NSMutableString stringWithCapacity:3];
    
    [yjwzNameStr appendFormat:@"%@",emergencyName1.text];
    [yjwzNameStr appendFormat:@",%@",emergencyName2.text];
    [yjwzNameStr appendFormat:@",%@",emergencyName3.text];
    
    
    NSMutableString *yjwzcapacityStr = [NSMutableString stringWithCapacity:3];
    
    [yjwzcapacityStr appendFormat:@"%@",emergencyQuantity1.text];
    [yjwzcapacityStr appendFormat:@",%@",emergencyQuantity2.text];
    [yjwzcapacityStr appendFormat:@",%@",emergencyQuantity3.text];
    
    NSMutableString *yjwzwayStr = [NSMutableString stringWithCapacity:3];
    
    [yjwzwayStr appendFormat:@"%@",emergencyWay1.text];
    [yjwzwayStr appendFormat:@",%@",emergencyWay2.text];
    [yjwzwayStr appendFormat:@",%@",emergencyWay3.text];
    
    
    
    for (int n= 0; n < [textField1Ary count]; n++) {
        UITextField *nameField  = [textField1Ary objectAtIndex:n];
        UITextField *quantityField = [textField2Ary objectAtIndex:n];
        UITextField *wayField = [textField3Ary objectAtIndex:n];
        
        NSString *strName  = nameField.text;
        NSString *strQuantity = quantityField.text;
        NSString *strWay = wayField.text;
        
        if ((![strName isEqualToString:@""]) || (![strQuantity isEqualToString:@""]) || (![strWay isEqualToString:@""])) {
            [yjwzNameStr appendFormat:@",%@",strName];
            [yjwzcapacityStr appendFormat:@",%@",strQuantity];
            [yjwzwayStr appendFormat:@",%@",strWay];
        }
    }
    
    [dicValues setValue:yjwzNameStr forKey:@"YJWZQTPZ"];
    [dicValues setValue:yjwzcapacityStr forKey:@"YJWZQTCL"];
    [dicValues setValue:yjwzwayStr forKey:@"YJWZQTCLFS"];

    
    [dicValues setValue:qtwtView.text forKey:@"QTWT"];
    [dicValues setValue:modifyView.text forKey:@"ZGYQ"];
    
    return dicValues;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

//插入和删除控件时移动
-(void)moveDown:(UIView*)sender tag:(int)tag shift:(int)da
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"MoveUpAndDown" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float rectY = sender.frame.origin.y;
    float rectX = sender.frame.origin.x;
    float rectW = sender.frame.size.width;
    float rectH = sender.frame.size.height;
    CGRect rect=CGRectMake(rectX,rectY+da,rectW,rectH);
    sender.frame = rect;
    [UIView commitAnimations];
    sender.tag =tag;
}


//删除控件和数组里的值
-(void)deleteCtrAndAry:(int)tag
{
    UITextField *nameTxt = [textField1Ary objectAtIndex:tag];
    UITextField *quantityTxt = [textField2Ary objectAtIndex:tag];
    UITextField *wayTxt = [textField3Ary objectAtIndex:tag];
    UIButton   *reduceBtn = [reduceBtnAry objectAtIndex:tag];
    
    [nameTxt removeFromSuperview];
    [quantityTxt removeFromSuperview];
    [wayTxt removeFromSuperview];
    [reduceBtn removeFromSuperview];
    
    [textField1Ary removeObjectAtIndex:tag];
    [textField2Ary removeObjectAtIndex:tag];
    [textField3Ary removeObjectAtIndex:tag];
    [reduceBtnAry removeObjectAtIndex:tag];
    
    num --;
}

- (void)deleteEmergencyGoodsItem:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self deleteCtrAndAry:btn.tag];
    for (int tag = btn.tag; tag <[textField1Ary count]; tag++) {
       
        UITextField *nameTxt = [textField1Ary objectAtIndex:tag];
        UITextField *quantityTxt = [textField2Ary objectAtIndex:tag];
        UITextField *wayTxt = [textField3Ary objectAtIndex:tag];
        UITextField *reduceBtn = [reduceBtnAry objectAtIndex:tag];
        
        [self moveDown:nameTxt tag:tag shift:-51];
        [self moveDown:quantityTxt tag:tag shift:-51];
        [self moveDown:wayTxt tag:tag shift:-51];
        [self moveDown:reduceBtn tag:tag shift:-51];
                
        if (tag == [textField1Ary count] - 1) {
            yAxs = nameTxt.frame.origin.y + 51;
            tagCount = nameTxt.tag + 1;
        }
    }
    
    [self moveDown:self.qtView tag:tagCount shift:-51];

    
    if (btn.tag>=[textField1Ary count]) {
        yAxs-=51;
        tagCount = btn.tag;
    }
}

- (void)addEmergencyGoodsValue:(BOOL)bOrigValue nameData:(NSString *)nameStr quantityData:(NSString *)quantityStr wayData:(NSString *)wayStr {
    
    UITextField *nameField = [[[UITextField alloc] initWithFrame:CGRectMake(32, yAxs, 168, 30)] autorelease];
    nameField.borderStyle = UITextBorderStyleRoundedRect;
    nameField.text = @"";
    nameField.tag = tagCount;
    [nameField addTarget:self action:@selector(emergenccyGoodsName:) forControlEvents:UIControlEventTouchDown];
    
    UITextField *quantityField = [[[UITextField alloc] initWithFrame:CGRectMake(256, yAxs, 173, 30)] autorelease];
    quantityField.borderStyle = UITextBorderStyleRoundedRect;
    quantityField.text = @"";
    quantityField.keyboardType = UIKeyboardTypeNumberPad;
    quantityField.tag = tagCount;
    
    UITextField *wayField = [[[UITextField alloc] initWithFrame:CGRectMake(471, yAxs, 163, 30)] autorelease];
    wayField.borderStyle = UITextBorderStyleRoundedRect;
    wayField.text = @"";
    wayField.delegate = self;
    wayField.tag = tagCount;
    
    [wayField addTarget:self action:@selector(storageWay:) forControlEvents:UIControlEventTouchDown];
    
    UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduceBtn setFrame:CGRectMake(654, yAxs, 29, 29)];
    [reduceBtn setImage:[UIImage imageNamed:@"jian.png"] forState:UIControlStateNormal];
    [reduceBtn addTarget:self action:@selector(deleteEmergencyGoodsItem:) forControlEvents:UIControlEventTouchUpInside];
    reduceBtn.tag = tagCount;
    
    
    [self addSubview:nameField];
    [self addSubview:quantityField];
    [self addSubview:wayField];
    [self addSubview:reduceBtn];
    
    if (bOrigValue) {
        nameField.text = nameStr;
        quantityField.text = quantityStr;
        wayField.text = wayStr;
    }

    [textField1Ary insertObject:nameField atIndex:tagCount];
    [textField2Ary insertObject:quantityField atIndex:tagCount];
    [textField3Ary insertObject:wayField atIndex:tagCount];
    [reduceBtnAry  insertObject:reduceBtn atIndex:tagCount];
    
    [self moveDown:self.qtView tag:tagCount shift:51];
    
    tagCount ++;
    yAxs += 51;
    num ++;

}

- (IBAction)addEmergencyGoodsItem:(id)sender{
    [self addEmergencyGoodsValue:NO nameData:@"" quantityData:@"" wayData:@""];
}

-(void)loadData:(NSDictionary*)values{
    NSString *wxpzjsNameStr = [values objectForKey:@"WXPZJSPM"];
    NSString *wxpzjsCapacityStr = [values objectForKey:@"WXPZJSZCL"];
    NSString *wxpzjsStorageStr = [values objectForKey:@"WXPZJSCCFS"];
    NSString *wxpzjsTypeStr =[values objectForKey:@"WXPZJSLB"];
    NSArray *wxpzjsNameAry = [wxpzjsNameStr componentsSeparatedByString:@","];
    NSArray *wxpzjsCapacityAry = [wxpzjsCapacityStr componentsSeparatedByString:@","];
    NSArray *wxpzjsStorageAry = [wxpzjsStorageStr componentsSeparatedByString:@","];
    NSArray *wxpzjsTypeAry = [wxpzjsTypeStr componentsSeparatedByString:@","];
    
    
    wxpzjsName1.text = [wxpzjsNameAry objectAtIndex:0];
    wxpzjsCapacity1.text = [wxpzjsCapacityAry objectAtIndex:0];
    wxpzjStorage1.text = [wxpzjsStorageAry objectAtIndex:0];
    wxpzjType1.text = [wxpzjsTypeAry objectAtIndex:0];
    
    wxpzjsName2.text = [wxpzjsNameAry objectAtIndex:1];
    wxpzjsCapacity2.text = [wxpzjsCapacityAry objectAtIndex:1];
    wxpzjStorage2.text = [wxpzjsStorageAry objectAtIndex:1];
    wxpzjType2.text = [wxpzjsTypeAry objectAtIndex:1];
    
    wxpzjsName3.text = [wxpzjsNameAry objectAtIndex:2];
    wxpzjsCapacity3.text = [wxpzjsCapacityAry objectAtIndex:2];
    wxpzjStorage3.text = [wxpzjsStorageAry objectAtIndex:2];
    wxpzjType3.text = [wxpzjsTypeAry objectAtIndex:2];
    
    NSString *selectTitle = [values objectForKey:@"GQWYFSFH"];
    gqbfhyyField.text = [values objectForKey:@"GQWYBFHLY"];
    if ([[values objectForKey:@"GQWYBFHLY"] length] > 0) {
        for (int n=0; n < gqsffhSegCtr.numberOfSegments; n++) {
            NSString *title = [gqsffhSegCtr titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                gqsffhSegCtr.selectedSegmentIndex = n;
            }
        }
        reasonLabel1.hidden = NO;
        gqbfhyyField.hidden = NO;
    }
    
    selectTitle = [values objectForKey:@"YJCSFFH"];
    yjcbfhyyField.text = [values objectForKey:@"YJCBFHLY"];
    if ([[values objectForKey:@"YJCBFHLY"] length] >0) {
        for (int n=0; n < yjcsffhSegCtr.numberOfSegments; n++) {
            NSString *title = [yjcsffhSegCtr titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                yjcsffhSegCtr.selectedSegmentIndex = n;
            }
        }
        reasonLabel2.hidden = NO;
        yjcbfhyyField.hidden = NO;
    }
    
    
    
    selectTitle = [values objectForKey:@"WXPXZGSP"];
    for (int n=0; n < wxpxzgspSegCtr.numberOfSegments; n++) {
        NSString *title = [wxpxzgspSegCtr titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            wxpxzgspSegCtr.selectedSegmentIndex = n;
        }
    }
    
    selectTitle = [values objectForKey:@"AQSCZDSQ"];
    for (int n=0; n < aqsczdsqSegCtr.numberOfSegments; n++) {
        NSString *title = [aqsczdsqSegCtr titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            aqsczdsqSegCtr.selectedSegmentIndex = n;
        }
    }
    
    selectTitle = @"无";
    if ([[values objectForKey:@"YJCRJ"] length] < 1) {
        for (int n=0; n < yjccSegCtr.numberOfSegments; n++) {
            NSString *title = [yjccSegCtr titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                yjccSegCtr.selectedSegmentIndex = n;
            }
        }
        areaLabel.hidden = YES;
        lineImageView.hidden = YES;
        yjccapacity.hidden = YES;
        
    }
    yjccapacity.text = [values objectForKey:@"YJCRJ"];
    
    selectTitle = [values objectForKey:@"YJFMSFWS"];
    yjfmbwsyyField.text = [values objectForKey:@"YJFMBWSLY"];
    if ([[values objectForKey:@"YJFMBWSLY"] length] >0) {
        for (int n=0; n < yjfmsfwsSegCtr.numberOfSegments; n++) {
            NSString *title = [yjfmsfwsSegCtr titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                yjfmsfwsSegCtr.selectedSegmentIndex = n;
            }
        }
        reasonLabel3.hidden = NO;
        yjfmbwsyyField.hidden = NO;
    }
    
    selectTitle = [values objectForKey:@"YWFL"];
    ywflyyField.text = [values objectForKey:@"YWFLLY"];
    if ([[values objectForKey:@"YWFLLY"] length] > 0) {
        for (int n=0; n < ywflSegCtr.numberOfSegments; n++) {
            NSString *title = [ywflSegCtr titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                ywflSegCtr.selectedSegmentIndex = n;
            }
        }
        reasonLabel4.hidden = NO;
        ywflyyField.hidden = NO;
    }
    
    selectTitle = [values objectForKey:@"FSCLSSYX"];
    fsclssField.text = [values objectForKey:@"FSCLSSYXLY"];
    if ([[values objectForKey:@"FSCLSSYXLY"] length] > 0) {
        for (int n=0; n < fsclssSegCtr.numberOfSegments; n++) {
            NSString *title = [fsclssSegCtr titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                fsclssSegCtr.selectedSegmentIndex = n;
            }
        }
        reasonLabel5.hidden = NO;
        fsclssField.hidden = NO;
    }
    
    selectTitle = [values objectForKey:@"FQCLSSYX"];
    fqclssField.text = [values objectForKey:@"FQCLSSYXLY"];
    if ([[values objectForKey:@"FQCLSSYXLY"] length] > 0) {
        for (int n=0; n < fqclssSegCtr.numberOfSegments; n++) {
            NSString *title = [fqclssSegCtr titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                fqclssSegCtr.selectedSegmentIndex = n;
            }
        }
        reasonLabel6.hidden = NO;
        fqclssField.hidden = NO;
    }
    
    selectTitle = [values objectForKey:@"YDQT"];
    ydqtField.text = [values objectForKey:@"YDQTNR"];
    if ([[values objectForKey:@"YDQTNR"] length] > 0) {
        for (int n=0; n < ydqtSegCtr.numberOfSegments; n++) {
            NSString *title = [ydqtSegCtr titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                ydqtSegCtr.selectedSegmentIndex = n;
            }
        }
        
        reasonLabel7.hidden = NO;
        ydqtField.hidden = NO;
    }
    
    selectTitle = [values objectForKey:@"GQFMSFWS"];
    gqfmField.text = [values objectForKey:@"GQFMSFWSLY"];
    if ([[values objectForKey:@"GQFMSFWSLY"] length] > 0) {
        for (int n=0; n < gqfmSegCtr.numberOfSegments; n++) {
            NSString *title = [gqfmSegCtr titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                gqfmSegCtr.selectedSegmentIndex = n;
            }
        }
        
        reasonLabel8.hidden = NO;
        gqfmField.hidden = NO;
    }

    
    selectTitle = [values objectForKey:@"DQYJSS"];
    for (int n=0; n < dqyjssSegCtr.numberOfSegments; n++) {
        NSString *title = [dqyjssSegCtr titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            dqyjssSegCtr.selectedSegmentIndex = n;
        }
    }
    
    selectTitle = [values objectForKey:@"SCFSZPQDZZ"];
    for (int n=0; n < fszpSegCtr.numberOfSegments; n++) {
        NSString *title = [fszpSegCtr titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            fszpSegCtr.selectedSegmentIndex = n;
        }
    }

    selectTitle = [values objectForKey:@"GQ"];
    for (int n=0; n < gqywSegCtrl.numberOfSegments; n++) {
        NSString *title = [gqywSegCtrl titleForSegmentAtIndex:n];
        if ([title isEqualToString:selectTitle]) {
            gqywSegCtrl.selectedSegmentIndex = n;
        }
    }

   
    
    NSString *yjwzNameStr = [values objectForKey:@"YJWZQTPZ"];
    NSString *yjwzcapacityStr = [values objectForKey:@"YJWZQTCL"];
    NSString *yjwzwayStr = [values objectForKey:@"YJWZQTCLFS"];
    
    NSArray *yjwzNameAry = [yjwzNameStr componentsSeparatedByString:@","];
    NSArray *yjwzcapacityAry = [yjwzcapacityStr componentsSeparatedByString:@","];
    NSArray *yjwzwayAry = [yjwzwayStr componentsSeparatedByString:@","];
    
    emergencyName1.text = [yjwzNameAry objectAtIndex:0];
    emergencyName2.text = [yjwzNameAry objectAtIndex:1];
    emergencyName3.text = [yjwzNameAry objectAtIndex:2];
    
    emergencyQuantity1.text = [yjwzcapacityAry objectAtIndex:0];
    emergencyQuantity2.text = [yjwzcapacityAry objectAtIndex:1];
    emergencyQuantity3.text = [yjwzcapacityAry objectAtIndex:2];
    
    emergencyWay1.text = [yjwzwayAry objectAtIndex:0];
    emergencyWay2.text = [yjwzwayAry objectAtIndex:1];
    emergencyWay3.text = [yjwzwayAry objectAtIndex:2];
    
    NSInteger count = [yjwzNameAry count];
    
    if (num < count) {
        for (int i=num; i < [yjwzNameAry count]; i++) {
            NSString *nameStr =  [yjwzNameAry objectAtIndex:i];
            NSString *quantityStr = [yjwzcapacityAry objectAtIndex:i];
            NSString *wayStr = [yjwzwayAry objectAtIndex:i];
            [self addEmergencyGoodsValue:YES nameData:nameStr quantityData:quantityStr wayData:wayStr];
        }

    }
    
    qtwtView.text = [values objectForKey:@"QTWT"];
    modifyView.text = [values objectForKey:@"ZGYQ"];
}

- (void)emergenccyGoodsName:(id)sender {
    UITextField *ctrl = (UITextField*)sender;
    self.curField = ctrl;
    CommenWordsViewController *tmpController = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
	tmpController.contentSizeForViewInPopover = CGSizeMake(200, 350);
	tmpController.delegate = self;
    tmpController.contentSizeForViewInPopover = CGSizeMake(200, 176);
    tmpController.wordsAry = [NSArray arrayWithObjects:@"活性炭",@"酸",@"碱",@"黄沙",nil];
    
    UIPopoverController *tmppopover = [[UIPopoverController alloc] initWithContentViewController:tmpController];
    self.popController = tmppopover;
	[tmpController release];
    [tmppopover release];
    
    [self.popController presentPopoverFromRect: ctrl.frame
                                        inView:self
                      permittedArrowDirections:UIPopoverArrowDirectionAny
                                      animated:YES];
}

-(void)storageWay:(id)sender {
    UITextField *ctrl = (UITextField*)sender;
    self.curField = ctrl;
    CommenWordsViewController *tmpController = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
	tmpController.contentSizeForViewInPopover = CGSizeMake(200, 350);
	tmpController.delegate = self;
    tmpController.contentSizeForViewInPopover = CGSizeMake(200, 176);
    tmpController.wordsAry = [NSArray arrayWithObjects:@"隔离",@"隔开",@"分离",@"露天",nil];
    
    UIPopoverController *tmppopover = [[UIPopoverController alloc] initWithContentViewController:tmpController];
    self.popController = tmppopover;
	[tmpController release];
    [tmppopover release];
    
    [self.popController presentPopoverFromRect: ctrl.frame
                                        inView:self
                      permittedArrowDirections:UIPopoverArrowDirectionAny
                                      animated:YES];
    
}

- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row {
    curField.text = words;
    if (popController != nil) {
        [popController dismissPopoverAnimated:YES];
    }

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	return NO;
}

@end
