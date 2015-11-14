//
//  AddTestResultViewController.m
//  GMEPS_HZ
//
//  Created by ZHONGWEN on 13-6-4.
//
//

#import "TypeInTestResultViewController.h"
@interface TypeInTestResultViewController ()

@end

@implementation TypeInTestResultViewController
@synthesize labelAry,Lable1Ary,Lable2Ary,Lable3Ary,textField1Ary,textField2Ary,textField3Ary,addBtnAry,reduceBtnAry;

- (void)dealloc {
    [typeLabel1 release];
    [typeLabel2 release];
    [typeLabel3 release];
    [elementField1 release];
    [elementField2 release];
    [standardField1 release];
    [standardField2 release];
    [actuallyField1 release];
    [actuallyField2 release];
    [_targetDict release];
    [labelAry    release];
    [Lable1Ary   release];
    [Lable2Ary   release];
    [Lable3Ary   release];
    [textField1Ary release];
    [textField2Ary release];
    [textField3Ary release];
    [addBtnAry release];
    [reduceBtnAry release];
    [scrollView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.Lable1Ary = [NSMutableArray arrayWithCapacity:6];
        self.Lable2Ary = [NSMutableArray arrayWithCapacity:6];
        self.Lable3Ary = [NSMutableArray arrayWithCapacity:6];
        self.textField1Ary = [NSMutableArray arrayWithCapacity:6];
        self.textField2Ary = [NSMutableArray arrayWithCapacity:6];
        self.textField3Ary = [NSMutableArray arrayWithCapacity:6];
        self.addBtnAry = [NSMutableArray arrayWithCapacity:6];
        self.reduceBtnAry = [NSMutableArray arrayWithCapacity:6];
        // Custom initialization
    }
    return self;
}

- (void)cancelfillInTestData:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

//增加新项
- (IBAction)addItemValue:(id)sender {
    [self addNewItem:NO elementData:@"" standardData:@"" actuallyData:@""];
}

- (void)addNewItem:(BOOL)bOrigValue elementData:(NSString *)element   standardData:(NSString *)standard actuallyData:(NSString *)actually {
    [standardField1 resignFirstResponder];

    UILabel *elementLabel = [[[UILabel alloc] initWithFrame:CGRectMake(61, yAxs, 90, 45)] autorelease];
    elementLabel.textAlignment = UITextAlignmentCenter;
    elementLabel.text = [NSString stringWithFormat:@"%@:",[labelAry objectAtIndex:0]];
    elementLabel.tag = tagCount;
    
    UITextField *elementTxt = [[[UITextField alloc] initWithFrame:CGRectMake(133, yAxs+8, 116, 30)] autorelease];
    elementTxt.borderStyle = UITextBorderStyleRoundedRect;
    elementTxt.text = @"";
    elementTxt.tag = tagCount;
    
    UILabel *standardLabel = [[[UILabel alloc] initWithFrame:CGRectMake(266, yAxs, 90, 45)] autorelease];
    standardLabel.textAlignment = UITextAlignmentCenter;
    standardLabel.text = [NSString stringWithFormat:@"%@:",[labelAry objectAtIndex:1]];
    standardLabel.tag = tagCount;
    
    UITextField *standardTxt = [[[UITextField alloc] initWithFrame:CGRectMake(337, yAxs+8, 116, 30)] autorelease];
    standardTxt.borderStyle  = UITextBorderStyleRoundedRect;
    standardTxt.keyboardType = UIKeyboardTypeNumberPad;
    standardTxt.text = @"";
    standardTxt.delegate = self;
    standardTxt.tag = tagCount;
    
    UILabel *actuallyLabel = [[[UILabel alloc] initWithFrame:CGRectMake(468, yAxs, 90, 45)] autorelease];
    actuallyLabel.textAlignment = UITextAlignmentCenter;
    actuallyLabel.text = [NSString stringWithFormat:@"%@:",[labelAry objectAtIndex:2]];
    actuallyLabel.tag = tagCount;
    
    UITextField *actuallyTxt = [[[UITextField alloc] initWithFrame:CGRectMake(542, yAxs+8, 116, 30)] autorelease];
    actuallyTxt.keyboardType = UIKeyboardTypeNumberPad;
    actuallyTxt.borderStyle = UITextBorderStyleRoundedRect;
    actuallyTxt.text = @"";
    actuallyTxt.delegate = self;
    actuallyTxt.tag = tagCount;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addBtn setFrame:CGRectMake(666, yAxs+8, 29, 29)];
    [addBtn addTarget:self action:@selector(insertItemValues:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = tagCount;
    
    UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduceBtn setFrame:CGRectMake(700, yAxs+8, 29, 29)];
    [reduceBtn setImage:[UIImage imageNamed:@"jian.png"] forState:UIControlStateNormal];
    [reduceBtn addTarget:self action:@selector(deleteItemValue:) forControlEvents:UIControlEventTouchUpInside];
    reduceBtn.tag = tagCount;
    
    
    [scrollView addSubview:elementLabel];
    [scrollView addSubview:elementTxt];
    [scrollView addSubview:standardLabel];
    [scrollView addSubview:standardTxt];
    [scrollView addSubview:actuallyLabel];
    [scrollView addSubview:actuallyTxt];
    [scrollView addSubview:addBtn];
    [scrollView addSubview:reduceBtn];
    
    
    if (bOrigValue) {
        elementTxt.text = element;
        standardTxt.text = standard;
        actuallyTxt.text = actually;
    }
    
    [Lable1Ary insertObject:elementLabel atIndex:tagCount];
    [Lable2Ary insertObject:standardLabel atIndex:tagCount];
    [Lable3Ary insertObject:actuallyLabel atIndex:tagCount];
    [textField1Ary insertObject:elementTxt atIndex:tagCount];
    [textField2Ary insertObject:standardTxt atIndex:tagCount];
    [textField3Ary insertObject:actuallyTxt atIndex:tagCount];
    [addBtnAry insertObject:addBtn atIndex:tagCount];
    [reduceBtnAry insertObject:reduceBtn atIndex:tagCount];
    
    tagCount ++;
    yAxs += 48;
    
}

- (void)insertItemValues:(id)sender {
    UIButton *btn = (UIButton *)sender;
    UILabel *elementLabel = [Lable1Ary objectAtIndex:btn.tag];
    yAxs = elementLabel.frame.origin.y;
    tagCount = btn.tag;
    [self addNewItem:NO elementData:@"" standardData:@"" actuallyData:@""];
    
    for (int tag = btn.tag + 1; tag < [Lable1Ary count]; tag++) {
        UILabel *elementLabel = [Lable1Ary objectAtIndex:tag];
        UILabel *standardLabel = [Lable2Ary objectAtIndex:tag];
        UILabel *actuallyLabel = [Lable3Ary objectAtIndex:tag];
        UITextField *elementTxt = [textField1Ary objectAtIndex:tag];
        UITextField *standardTxt = [textField2Ary objectAtIndex:tag];
        UITextField *actuallyTxt = [textField3Ary objectAtIndex:tag];
        UITextField *addBtn = [addBtnAry objectAtIndex:tag];
        UITextField *reduceBtn = [reduceBtnAry objectAtIndex:tag];
        
        [self moveDown:elementLabel tag:tag shift:48];
        [self moveDown:standardLabel tag:tag shift:48];
        [self moveDown:actuallyLabel tag:tag shift:48];
        [self moveDown:elementTxt tag:tag shift:48];
        [self moveDown:standardTxt tag:tag shift:48];
        [self moveDown:actuallyTxt tag:tag shift:48];
        [self moveDown:addBtn tag:tag shift:48];
        [self moveDown:reduceBtn tag:tag shift:48];
        
        if (tag == [Lable1Ary count] - 1) {
            yAxs  = elementLabel.frame.origin.y;
            tagCount = elementLabel.tag + 1;
        }
    }
}


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
-(void)deleteUiAndAry:(int)tag
{
    UILabel *elementLabel = [Lable1Ary objectAtIndex:tag];
    UILabel *standardLabel = [Lable2Ary objectAtIndex:tag];
    UILabel *actuallyLabel = [Lable3Ary objectAtIndex:tag];
    UITextField *elementTxt = [textField1Ary objectAtIndex:tag];
    UITextField *standardTxt = [textField2Ary objectAtIndex:tag];
    UITextField *actuallyTxt = [textField3Ary objectAtIndex:tag];
    UIButton *addBtn = [addBtnAry objectAtIndex:tag];
    UIButton *reduceBtn = [reduceBtnAry objectAtIndex:tag];

    
    [elementLabel removeFromSuperview];
    [standardLabel removeFromSuperview];
    [actuallyLabel removeFromSuperview];
    [elementTxt removeFromSuperview];
    [standardTxt removeFromSuperview];
    [actuallyTxt removeFromSuperview];
    [addBtn removeFromSuperview];
    [reduceBtn removeFromSuperview];
    
    [Lable1Ary removeObjectAtIndex:tag];
    [Lable2Ary removeObjectAtIndex:tag];
    [Lable3Ary removeObjectAtIndex:tag];
    [textField1Ary removeObjectAtIndex:tag];
    [textField2Ary removeObjectAtIndex:tag];
    [textField3Ary removeObjectAtIndex:tag];
    [addBtnAry removeObjectAtIndex:tag];
    [reduceBtnAry removeObjectAtIndex:tag];
}


- (void)deleteItemValue:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self deleteUiAndAry:btn.tag];
    for (int tag = btn.tag; tag <[Lable1Ary count]; tag++) {
        UILabel *elementLabel = [Lable1Ary objectAtIndex:tag];
        UILabel *standardLabel = [Lable2Ary objectAtIndex:tag];
        UILabel *actuallyLabel = [Lable3Ary objectAtIndex:tag];
        UITextField *elementTxt = [textField1Ary objectAtIndex:tag];
        UITextField *standardTxt = [textField2Ary objectAtIndex:tag];
        UITextField *actuallyTxt = [textField3Ary objectAtIndex:tag];
        UITextField *addBtn = [addBtnAry objectAtIndex:tag];
        UITextField *reduceBtn = [reduceBtnAry objectAtIndex:tag];
        
        [self moveDown:elementLabel tag:tag shift:-48];
        [self moveDown:standardLabel tag:tag shift:-48];
        [self moveDown:actuallyLabel tag:tag shift:-48];
        [self moveDown:elementTxt tag:tag shift:-48];
        [self moveDown:standardTxt tag:tag shift:-48];
        [self moveDown:actuallyTxt tag:tag shift:-48];
        [self moveDown:addBtn tag:tag shift:-48];
        [self moveDown:reduceBtn tag:tag shift:-48];
        
        if (tag == [Lable1Ary count] - 1) {
            yAxs = elementLabel.frame.origin.y + 48;
            tagCount = elementLabel.tag + 1;
        }
    }
    if (btn.tag>=[Lable1Ary count]) {
        yAxs-=48;
        tagCount = btn.tag;
    }

}

- (void)initWithOriginalTestData {
    NSString *type1 = [[_targetDict objectForKey:@"type1"] objectForKey:@"name"];
    NSString *type2 = [[_targetDict objectForKey:@"type2"] objectForKey:@"name"];
    NSString *type3 = [[_targetDict objectForKey:@"type3"] objectForKey:@"name"];
    
    NSArray *type1Ary = [[_targetDict objectForKey:@"type1"] objectForKey:@"data"];
    NSArray *type2Ary = [[_targetDict objectForKey:@"type2"] objectForKey:@"data"];
    NSArray *type3Ary = [[_targetDict objectForKey:@"type3"] objectForKey:@"data"];
    
    self.labelAry = [NSArray arrayWithObjects:type1,type2,type3,nil];
    
    typeLabel1.text = type1;
    typeLabel2.text = type2;
    typeLabel3.text = type3;
    
    elementField1.text = [type1Ary objectAtIndex:0];
    elementField2.text = [type1Ary objectAtIndex:1];
    
    standardField1.text = [type2Ary objectAtIndex:0];
    standardField2.text = [type2Ary objectAtIndex:1];
    
    actuallyField1.text = [type3Ary objectAtIndex:0];
    actuallyField2.text = [type3Ary objectAtIndex:1];
    
    tagCount = 0;
    for (int i=2; i < [type1Ary count]; i++) {
        NSString *elementStr =  [type1Ary objectAtIndex:i];
        NSString *standardStr = [type2Ary objectAtIndex:i];
        NSString *actuallyStr = [type3Ary objectAtIndex:i];

        [self addNewItem:YES elementData:elementStr standardData:standardStr actuallyData:actuallyStr];
    }
}



- (void)saveTestDataAndCalculator:(id)sender {
    NSInteger row = [sender tag];
    

    NSMutableArray *elementAry = [NSMutableArray arrayWithObjects:elementField1.text,elementField2.text,nil];
    NSMutableArray *standardAry = [NSMutableArray arrayWithObjects:standardField1.text,standardField2.text,nil];
    NSMutableArray *actuallyAry = [NSMutableArray arrayWithObjects:actuallyField1.text,actuallyField2.text,nil];
    
    for (int n= 0; n < [textField1Ary count]; n++) {
        UITextField *elementField  = [textField1Ary objectAtIndex:n];
        UITextField *standardField = [textField2Ary objectAtIndex:n];
        UITextField *actuallyField = [textField3Ary objectAtIndex:n];
        
        NSString *strElement  = elementField.text;
        NSString *strStandard = standardField.text;
        NSString *strActually = actuallyField.text;
        
        if ((![strElement isEqualToString:@""]) || (![strStandard isEqualToString:@""]) || (![strActually isEqualToString:@""])) {
            [elementAry  addObject:strElement];
            [standardAry addObject:strStandard];
            [actuallyAry addObject:strActually];
        }
    }
    
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            [subView resignFirstResponder];
        }
    }
    
    
    [self.delegate returnTypeInTestData:elementAry standard:standardAry actually:actuallyAry cellRow:row];
    [self dismissModalViewControllerAnimated:YES];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"录入检测数据";
    yAxs = 12.0f;
    UIBarButtonItem *CancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelfillInTestData:)];
    UIBarButtonItem *DoneItem = [[UIBarButtonItem alloc] initWithTitle:@"保存并计算分数" style:UIBarButtonItemStyleDone target:self action:@selector(saveTestDataAndCalculator:)];
    DoneItem.tag = self.cellRow;
    self.navigationItem.leftBarButtonItem = CancelItem;
    self.navigationItem.rightBarButtonItem = DoneItem;
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, 768, 410)];
    scrollView.contentSize = CGSizeMake(768, 1024);
    
    [self.view addSubview:scrollView];
    
    [CancelItem release];
    [DoneItem release];
    
    [self initWithOriginalTestData];
    
    
    
//    [self.elementAry addObject:elementField1.text];
//    [self.elementAry addObject:elementField2.text];
//    
//    [self.standardAry addObject:@""];
//    [self.standardAry addObject:@""];
//    
//    [self.actuallyAry addObject:@""];
//    [self.actuallyAry addObject:@""];

    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSInteger tag = textField.tag;
    
    if (tag == 2) {
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width=self.view.frame.size.width;
        float height=self.view.frame.size.height;
        CGRect rect=CGRectMake(0.0f,-48.0f,width,height);//上移，按实际情况设置
        self.view.frame=rect;
        [UIView commitAnimations];
    }
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:Number] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字或小数点"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        return NO;
        
    }
    return YES;
}



@end
