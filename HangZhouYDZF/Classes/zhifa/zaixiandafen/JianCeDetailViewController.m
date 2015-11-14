//
//  JianCeDetailViewController.m
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-4-18.
//
//

#import "JianCeDetailViewController.h"
#import "TTControlItem.h"
#import "TTSwitch.h"
#import "CalculateJianceScore.h"
#import "LKDrawLabBgImage.h"
#import "SurveyTableViewController.h"

@interface JianCeDetailViewController ()
@property (nonatomic, retain) UIPopoverController *popController;

@end

@implementation JianCeDetailViewController
@synthesize tableDict,currentIndex,scoreTotal,cellHeightAry,refreshDelegate,isSave,shortName,factorScore;
@synthesize popController;

- (void)dealloc {
    [tableDict release];
    [currentIndex release];
    [cellHeightAry release];
    [shortName release];
    [factorScore release];
    [popController release];
    [surveyTableController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)fillInSurveyTable:(id)sender {
    NSInteger row = [sender tag];
    NSDictionary   *target = [[[[tableDict objectForKey:@"cellArray"] objectAtIndex:1] objectAtIndex:row] objectForKey:@"target"];
    TypeInTestResultViewController *typeInTestReslutViewController = [[TypeInTestResultViewController alloc] initWithNibName:@"TypeInTestResultViewController" bundle:nil];
    typeInTestReslutViewController.targetDict = target;
    typeInTestReslutViewController.delegate  = self;
    typeInTestReslutViewController.cellRow = row;
    //    typeInTestReslutViewController.contentSizeForViewInPopover = CGSizeMake(300.0, 190.0);
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:typeInTestReslutViewController];
    navigation.modalPresentationStyle =  UIModalPresentationFullScreen;
    
    [self presentModalViewController:navigation animated:YES];
    //navigation.view.superview.frame = CGRectMake(0, 410, 768, 1004);
    
    [typeInTestReslutViewController release];
    [navigation release];
}

- (void)scoreBoardValueChanged:(UISegmentedControl *)scoreBoard{
    NSInteger row = [scoreBoard tag] - 1005;
    NSInteger section = 1;
    
    NSInteger scoreIndex = [scoreBoard selectedSegmentIndex];
    
    NSMutableDictionary *dict =  [[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row];
    
    
    NSString *score = [[[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row] objectForKey:@"score"] ;
    
    NSInteger scoreNumber = [score integerValue];
    
    
    if (scoreIndex > scoreNumber) {
        scoreNumber = scoreIndex - scoreNumber;
        scoreTotal =  scoreTotal + scoreNumber;
    }
    else{
        scoreNumber = scoreNumber - scoreIndex;
        scoreTotal = scoreTotal - scoreNumber;
    }
    
    [dict setObject:[NSNumber numberWithInteger:scoreIndex] forKey:@"score"];
    NSString *currentScore = [NSString stringWithFormat:@"%d",scoreTotal];
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [refreshDelegate refreshScore:currentScore];
    
}

- (void)calculateScores:(id)sender {
    NSInteger row = [sender tag] - 1004;
    NSInteger section = 1;
    
    NSMutableDictionary *dict =  [[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row];
    
    NSString *score = [[[[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row] objectForKey:@"rule"] objectForKey:@"fullmark"];
    
    int scoreNumber = [score intValue];
    TTSwitch *defaultSwitch = (TTSwitch *)sender;
    
    if (defaultSwitch.on) {
        
        [dict setObject:@"1" forKey:@"switch"];
        [dict setObject:[NSString stringWithFormat:@"%d",scoreNumber] forKey:@"score"];
        scoreNumber = - scoreNumber;
        
    }
    else {
        [dict setObject:@"0" forKey:@"switch"];
        [dict setObject:@"0" forKey:@"score"];
    }
    scoreTotal =  scoreTotal - scoreNumber;
    NSString *currentScore = [NSString stringWithFormat:@"%d",scoreTotal];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [refreshDelegate refreshScore:currentScore];
}

- (void)calculateFactorScore:(NSInteger)row {
    NSInteger calculateScore = 0;
    NSMutableDictionary *content= [[[tableDict objectForKey:@"cellArray"] objectAtIndex:1] objectAtIndex:row];
    NSDictionary *target =  [content objectForKey:@"target"];
    NSString *score = [content objectForKey:@"score"] ;
    NSDictionary *type2 = [target objectForKey:@"type2"];
    NSDictionary *type3 = [target objectForKey:@"type3"];
    
    
    NSMutableArray *type2Ary = [NSMutableArray array];
    NSMutableArray *type3Ary = [NSMutableArray array];
    
    
    NSMutableArray *standardAry  = [type2 objectForKey:@"data"];
    NSMutableArray *actuallyAry = [type3 objectForKey:@"data"];
    for (int n=0; n < [standardAry count]; n++) {
        NSString *strStandard = [standardAry objectAtIndex:n];
        NSString *strActually = [actuallyAry objectAtIndex:n];
        
        if ((![strStandard isEqualToString:@""]) && (![strActually isEqualToString:@""])) {
            [type2Ary  addObject:strStandard];
            [type3Ary addObject:strActually];
        }
    }
    
    if ([shortName isEqualToString:@"FQXZXT"]) {
        calculateScore = [CalculateJianceScore calcStandardAry:type2Ary andActuallyAry:type3Ary andType:@"smoke"];
    }
    else if([shortName isEqualToString:@"FQSJYZX"]) {
        calculateScore = [CalculateJianceScore calcShiceAry:type2Ary andShucaiAry:type3Ary andType:@"smoke"];
    }
    else if([shortName isEqualToString:@"FSXZXT"]) {
         calculateScore = [CalculateJianceScore calcStandardAry:type2Ary andActuallyAry:type3Ary andType:@"water"];
    }
    else {
        calculateScore = [CalculateJianceScore calcShiceAry:type2Ary andShucaiAry:type3Ary andType:@"water"];
    }
    NSString *itemScore = [NSString stringWithFormat:@"%d",calculateScore];
    int scoreNumber = [score intValue];
    [content setObject:itemScore forKey:@"score"];
    
    scoreTotal =  scoreTotal - (scoreNumber - calculateScore);
    NSString *currentScore = [NSString stringWithFormat:@"%d",scoreTotal];
    
     [self calculateCellHeight];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [refreshDelegate refreshScore:currentScore];
}

- (void)returnTypeInTestData:(NSArray *)element standard:(NSArray *)standard actually:(NSArray *)actually cellRow:(NSInteger)row{
    NSMutableDictionary *content= [[[tableDict objectForKey:@"cellArray"] objectAtIndex:1] objectAtIndex:row] ;
    NSMutableDictionary *target =  [content objectForKey:@"target"];
    NSMutableDictionary *type1 = [target objectForKey:@"type1"];
    NSMutableDictionary *type2 = [target objectForKey:@"type2"];
    NSMutableDictionary *type3 = [target objectForKey:@"type3"];
    
    
    [type1 setObject:element forKey:@"data"];
    [type2 setObject:standard forKey:@"data"];
    [type3 setObject:actually forKey:@"data"];
    
    
    
    surveyTableController.elementAry = element;
    surveyTableController.standardAry = standard;
    surveyTableController.actuallyAry = actually;
    [surveyTableController.tableView reloadData];
    
    [self calculateFactorScore:row];
}


- (BOOL)saveLastDetailViewData {
    NSArray *sectionAry = [tableDict objectForKey:@"section"];
    NSArray *cellAry = [[tableDict objectForKey:@"cellArray"] objectAtIndex:1];
    NSString *flag = [[sectionAry objectAtIndex:1] objectForKey:@"flag"];
    
    if ([flag isEqualToString:@"select"]) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                UITextField *reasonTxt = (UITextField *)[cell.contentView viewWithTag:1003];
        NSMutableDictionary *content= [[[tableDict objectForKey:@"cellArray"] objectAtIndex:2] objectAtIndex:0] ;
        [content setObject:reasonTxt.text forKey:@"text"];
        [reasonTxt resignFirstResponder];
        
    }
    else if([flag isEqualToString:@"switch"]) {
        for (int row=0; row < [cellAry count]; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:1];
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            UITextField *reasonTxt = (UITextField *)[cell.contentView viewWithTag:1003];
            
            NSDictionary *cellItem = [cellAry objectAtIndex:row];
            NSDictionary *target = [cellItem objectForKey:@"target"];
            if (!target) {
                NSMutableDictionary *content= [[[tableDict objectForKey:@"cellArray"] objectAtIndex:1] objectAtIndex:row] ;
                [content setObject:reasonTxt.text forKey:@"text"];
                [reasonTxt resignFirstResponder];
            }
        }        
    }
    else {
        for (int row=0; row < [cellAry count]; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:1];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            UITextField *reasonTxt = (UITextField *)[cell.contentView viewWithTag:1003];
                NSMutableDictionary *content= [[[tableDict objectForKey:@"cellArray"] objectAtIndex:1] objectAtIndex:row] ;
                [content setObject:reasonTxt.text forKey:@"text"];
                [reasonTxt resignFirstResponder];
        }
    }
    
    return YES;
}

- (void)awakeFromNib {
    [[TTSwitch appearance] setTrackImage:[UIImage imageNamed:@"square-switch-track"]];
    [[TTSwitch appearance] setOverlayImage:[UIImage imageNamed:@"square-switch-overlay"]];
    [[TTSwitch appearance] setTrackMaskImage:[UIImage imageNamed:@"square-switch-mask"]];
    [[TTSwitch appearance] setThumbImage:[UIImage imageNamed:@"square-switch-thumb"]];
    [[TTSwitch appearance] setThumbHighlightImage:[UIImage imageNamed:@"square-switch-thumb-highlight"]];
    [[TTSwitch appearance] setThumbMaskImage:[UIImage imageNamed:@"square-switch-mask"]];
    [[TTSwitch appearance] setThumbInsetX:-3.0f];
    [[TTSwitch appearance] setThumbOffsetY:-3.0f];
    
}

- (UITableViewCell *)makeSubCell:(UITableView *)tableview
                     withContent:(NSString *)content
                            rule:(NSString *)rule
                            text:(NSString *)text
                            flag:(NSString *)flag
                          target:(NSDictionary *)target
                        selected:(NSString *)select
                          height:(CGFloat)height
                             row:(NSInteger)row
                           score:(NSInteger)score
{
    NSString *cellIdentifier = @"table";
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        contentLabel.numberOfLines = 0;
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.font = [UIFont fontWithName:@"STHeitiJ-Medium" size:14];
        contentLabel.textColor = [UIColor darkGrayColor];
        contentLabel.tag = 1001;
        [cell.contentView addSubview:contentLabel];
        [contentLabel release];
        
        UILabel *ruleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        ruleLabel.numberOfLines = 0;
        ruleLabel.backgroundColor = [UIColor clearColor];
        ruleLabel.font = [UIFont fontWithName:@"STHeitiJ-Medium" size:14];
        ruleLabel.textColor = [UIColor darkGrayColor];
        ruleLabel.tag =  1002;
        [cell.contentView addSubview:ruleLabel];
        [ruleLabel release];
    }
    
    else{
        for (UIView *subView in cell.subviews) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                [subView removeFromSuperview];
            }
        }
        if (surveyTableController) {
            [surveyTableController.view removeFromSuperview];
        }
        
        UITextField *view_text = (UITextField *)[cell viewWithTag:1003];
        if (view_text) {
            [view_text removeFromSuperview];
        }
        
        TTSwitch *view_switch = (TTSwitch *)[cell viewWithTag:1004+row];
        // 删除cell中的子对象,刷新覆盖问题。
        if (view_switch) {
            [view_switch removeFromSuperview];
        }
        
        UISegmentedControl *view_segment = (UISegmentedControl *)[cell viewWithTag:1005+row];
        if (view_segment) {
            [view_segment removeFromSuperview];
        }
        
        UILabel *view_label = (UILabel *)[cell viewWithTag:1006];
        if(view_label) {
            [view_label removeFromSuperview];
        }
    }
    
    content = [content stringByReplacingOccurrencesOfString:@"（" withString:@"("];
    content = [content stringByReplacingOccurrencesOfString:@"）" withString:@")"];
    
    content = [content stringByReplacingOccurrencesOfString:@"，" withString:@","];
    content = [content stringByReplacingOccurrencesOfString:@"；" withString:@";"];
    
    rule = [rule stringByReplacingOccurrencesOfString:@"（" withString:@"("];
    rule = [rule stringByReplacingOccurrencesOfString:@"）" withString:@")"];
    
    rule = [rule stringByReplacingOccurrencesOfString:@"，" withString:@","];
    rule = [rule stringByReplacingOccurrencesOfString:@"；" withString:@";"];
    
    
    UILabel *contentLabel = (UILabel *)[cell.contentView viewWithTag:1001];
    CGRect frame = CGRectMake(10, 0, 194, height-30);
    contentLabel.frame = frame;
    contentLabel.text = content;
    
    
    UILabel *ruleLabel = (UILabel *)[cell.contentView viewWithTag:1002];
    frame = CGRectMake(207, 0, 94, height-30);
    ruleLabel.frame = frame;
    ruleLabel.text = rule;
    
    if (target != nil) {
        CGFloat table_height = [[[target objectForKey:@"type1"] objectForKey:@"data"] count] * 44 +22;
        
        UILabel *contentLabel = (UILabel *)[cell.contentView viewWithTag:1001];
        CGRect frame = CGRectMake(10, 0, 194, height-table_height- 20);
        contentLabel.frame = frame;
        contentLabel.text = content;
        
        
        UILabel *ruleLabel = (UILabel *)[cell.contentView viewWithTag:1002];
        frame = CGRectMake(207, 0, 94, height-table_height-10);
        ruleLabel.frame = frame;
        ruleLabel.text = rule;
        
        UILabel *scoreTxtLabel = [[UILabel alloc] initWithFrame:CGRectMake(340, 8, 80, 44)];
        scoreTxtLabel.numberOfLines = 1;
        scoreTxtLabel.backgroundColor = [UIColor clearColor];
        scoreTxtLabel.font = [UIFont systemFontOfSize:16.0];
        scoreTxtLabel.textColor = [UIColor blackColor];
        scoreTxtLabel.tag = 1006;
        scoreTxtLabel.text = [NSString stringWithFormat:@"得分%d分",score];
        [cell.contentView addSubview:scoreTxtLabel];
        [scoreTxtLabel release];
        
        UIButton *calculate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [calculate setFrame:CGRectMake(0.0, 0.0, 71.0, 36.0)];
        [calculate setBackgroundImage:[UIImage imageNamed:@"button_grey.png"] forState:UIControlStateNormal];
        [calculate setTitle:@"录入数据" forState:UIControlStateNormal];
        [calculate setTitleColor:[UIColor colorWithRed:233/255.0 green:226/255.0 blue:154/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [calculate addTarget:self action:@selector(fillInSurveyTable:) forControlEvents:UIControlEventTouchUpInside];
        calculate.tag = row;
        cell.accessoryView = calculate;
        
        
        NSString *type1 = [[target objectForKey:@"type1"] objectForKey:@"name"];
        NSString *type2 = [[target objectForKey:@"type2"] objectForKey:@"name"];
        NSString *type3 = [[target objectForKey:@"type3"] objectForKey:@"name"];
        
        surveyTableController = [[SurveyTableViewController alloc] initWithNibName:@"SurveyTableViewController" bundle:nil];
        surveyTableController.headerTitle = [NSString stringWithFormat:@"    %@            %@           %@",type1,type2,type3];
        surveyTableController.elementAry = [[target objectForKey:@"type1"] objectForKey:@"data"];
        surveyTableController.standardAry = [[target objectForKey:@"type2"] objectForKey:@"data"];
        surveyTableController.actuallyAry = [[target objectForKey:@"type3"] objectForKey:@"data"];
        
        surveyTableController.view.frame  = CGRectMake(10, height - table_height-8, 286, table_height+4);
        [cell.contentView addSubview:surveyTableController.view];
        
    }
    
    else if([flag isEqualToString:@"switch"]) {
        frame = CGRectMake(10, height-36, 273, 30);
        UITextField  *reasonText = [[UITextField alloc] initWithFrame:CGRectZero];
        reasonText.tag = 1003;
        reasonText.delegate = self;
        reasonText.text = text;
        reasonText.frame = frame;
        reasonText.borderStyle = UITextBorderStyleRoundedRect;
        reasonText.font = [UIFont fontWithName:@"STHeitiJ-Medium" size:15];
        reasonText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        reasonText.placeholder = @"填写扣分原因:";
        reasonText.returnKeyType = UIReturnKeyDone;
        
        
        [cell.contentView addSubview:reasonText];
        [reasonText release];
        
        TTSwitch *defaultSwitch = [[TTSwitch alloc] initWithFrame:(CGRect){ CGPointZero, { 76.0f, 28.0f } }] ;
        BOOL isOn = [select boolValue];
        defaultSwitch.on = isOn;
        [defaultSwitch addTarget:self action:@selector(calculateScores:) forControlEvents:UIControlEventValueChanged];
        defaultSwitch.tag = 1004+row;
        cell.accessoryView = defaultSwitch;
        
    }
    else if([flag isEqualToString:@"select"])
    {
        TTSwitch *defaultSwitch = [[TTSwitch alloc] initWithFrame:(CGRect){ CGPointZero, { 76.0f, 28.0f } }] ;
        
        BOOL isOn = [select boolValue];
        defaultSwitch.on = isOn;
        [defaultSwitch addTarget:self action:@selector(calculateScores:) forControlEvents:UIControlEventValueChanged];
        defaultSwitch.tag = 1004+row;
        cell.accessoryView = defaultSwitch;
        
    }
    else
    {
        frame = CGRectMake(10, height-36, 273, 30);
        UITextField  *reasonText = [[UITextField alloc] initWithFrame:CGRectZero];
        reasonText.tag = 1003;
        reasonText.delegate = self;
        reasonText.text = text;
        reasonText.frame = frame;
        reasonText.borderStyle = UITextBorderStyleRoundedRect;
        reasonText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        reasonText.font = [UIFont fontWithName:@"STHeitiJ-Medium" size:15];
        reasonText.placeholder = @"填写扣分原因:";
        reasonText.returnKeyType = UIReturnKeyDone;
        
        [cell.contentView addSubview:reasonText];
        
        [reasonText release];
        
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:4];
        for (int i=0; i<= [select intValue]; i++) {
            [items addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        UISegmentedControl *scoreBoard = [[UISegmentedControl alloc] initWithItems:items];
        scoreBoard.frame = CGRectMake(0.0, 0.0, 124.0, 30);
        [scoreBoard addTarget:self action:@selector(scoreBoardValueChanged:) forControlEvents:UIControlEventValueChanged];
        scoreBoard.selectedSegmentIndex = score;
        scoreBoard.tag = 1005+row;
        scoreBoard.segmentedControlStyle = UISegmentedControlStyleBar;
        cell.accessoryView = scoreBoard;
        [scoreBoard release];
    }
    
    return cell;
}


- (void)calculateCellHeight{
    isSave = NO;
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:8] ;
    NSArray *cellArray = [tableDict objectForKey:@"cellArray"];
    
    //计算cell高度
    CGFloat cellHeight= 0;
    for (int i = 0 ;i< [cellArray count]; i++) {
        NSMutableArray *heightAry = [NSMutableArray array];
        NSString *type = [[[tableDict objectForKey:@"section"] objectAtIndex:i] objectForKey:@"type"];
        NSString *flag = [[[tableDict objectForKey:@"section"] objectAtIndex:i] objectForKey:@"flag"];
        
        if([type isEqualToString:@"label"]) {
            if (flag != nil) {
                for (NSMutableDictionary *dict in [cellArray objectAtIndex:i]) {
                    NSString *content = [dict objectForKey:@"content"];
                    cellHeight = [ZrsUtils calculateTextHeight:content byFontSize:20 andWidth:430];
                    
                    [heightAry addObject:[NSNumber numberWithFloat:cellHeight]];
                }
            }
            else{
                for (NSString *content in [cellArray objectAtIndex:i] ) {
                    
                    cellHeight = [ZrsUtils calculateTextHeight:content byFontSize:20 andWidth:430];
                    
                    [heightAry addObject:[NSNumber numberWithFloat:cellHeight]];
                }
            }
        }
        
        else if([type isEqualToString:@"table"])
        {
            for (NSDictionary *contentDict in [cellArray objectAtIndex:i]) {
                NSString *content = [contentDict objectForKey:@"content"];
                NSDictionary *target = [contentDict objectForKey:@"target"];
                
                if ([flag isEqualToString:@"select"]) {
                    cellHeight = [ZrsUtils calculateTextHeight:content byFontSize:14 andWidth:196];
                }
                if ([flag isEqualToString:@"switch"] || [flag isEqualToString:@"segment"]) {
                    if (target != nil) {
                        NSArray *type1Ary = [[target objectForKey:@"type1"] objectForKey:@"data"];
                        cellHeight = [ZrsUtils calculateTextHeight:content byFontSize:14 andWidth:196];
                        if (cellHeight < 80.0) {
                            cellHeight = 80+[type1Ary count]*44 + 16;
                        }
                        else {
                            cellHeight = cellHeight +[type1Ary count]*44 + 16;
                        }
                    }
                    else{
                        cellHeight = [ZrsUtils calculateTextHeight:content byFontSize:14 andWidth:196] + 30.0;
                    }
                }
                if (cellHeight < 80.0) {
                    cellHeight = 80.0;
                }
                [heightAry addObject:[NSNumber numberWithFloat:cellHeight]];
                
            }
        }
        else {
            cellHeight = 58.0;
            [heightAry addObject:[NSNumber numberWithFloat:cellHeight]];
        }
        
        [ary addObject:heightAry];
        
    }
    self.cellHeightAry = ary;
    [ary release];

}

- (void)reloadTableView {
    [self calculateCellHeight];
    [self.tableView reloadData];
}

//- (BOOL)disablesAutomaticKeyboardDismissal{
//    return NO;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TextField delagate

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField.tag == 101) {
//        NSLog(@"tag:%d: length:%d",textField.tag,[textField.text length]);
//        if ([textField.text length] > 0) {
//            NSMutableDictionary  *content= [[[tableDict objectForKey:@"cellArray"] objectAtIndex:0] objectAtIndex:0] ;
//            [content setObject:regionsText.text forKey:@"text"];
//            //NSLog(@"%d",[regionsText isFirstResponder]?YES:NO);
//
//            [handleText becomeFirstResponder];
//        }
//    }
//    if (textField.tag == 102) {
//        if ([textField.text length] > 0) {
//            NSMutableDictionary  *content= [[[tableDict objectForKey:@"cellArray"] objectAtIndex:1] objectAtIndex:0] ;
//            [content setObject:handleText.text forKey:@"text"];
//            NSLog(@"%@",tableDict);
//
//
//        }
//
//    }
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    CGFloat totalHeight = 0.0;
//    for (NSArray *sectionAry in cellHeightAry) {
//        for (NSNumber *number in sectionAry) {
//            CGFloat  cellHeight = [number floatValue];
//            totalHeight = totalHeight + cellHeight;
//        }
//    }
//    if (surveyTableController.view.superview != nil) {
//        NSNumber *number = [[cellHeightAry objectAtIndex:1] lastObject];
//        CGFloat cellHeight = [number floatValue];
//        totalHeight = totalHeight - cellHeight;
//        
//    }
//    
//    
//    NSLog(@"y:%f",textField.bounds.origin.y);
//    
//    if ( totalHeight > 428) {
//        NSTimeInterval animationDuration=0.30f;
//        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//        [UIView setAnimationDuration:animationDuration];
//        float width=self.view.frame.size.width;
//        float height=self.view.frame.size.height;
//        CGRect rect=CGRectMake(281.0f,44-(totalHeight-428),width,height);//上移，按实际情况设置
//        self.view.frame=rect;
//        [UIView commitAnimations];
//        
//    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
//	NSTimeInterval animationDuration=0.30f;
//	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//	[UIView setAnimationDuration:animationDuration];
//	float width=self.view.frame.size.width;
//	float height=self.view.frame.size.height;
//	CGRect rect=CGRectMake(281.0f,342.0f,width,height);
//	self.view.frame=rect;
//	[UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[tableDict objectForKey:@"section"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    CGFloat height = [[[cellHeightAry objectAtIndex:section] objectAtIndex:row ] floatValue];
    return height;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSString *title =  [[[tableDict objectForKey:@"section"] objectAtIndex:section] objectForKey:@"title"];
        NSMutableString *newTitle = [NSMutableString stringWithFormat:@"%@%d分",title,scoreTotal];
        return newTitle;
    }
    return [[[tableDict objectForKey:@"section"] objectAtIndex:section] objectForKey:@"title"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *content = nil;
    NSString *rule = nil;
    NSString *text = nil;
    NSDictionary *target= nil;
    NSString *select=nil;
    NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = nil;
    @autoreleasepool {
    
    CGFloat height = [[[cellHeightAry objectAtIndex:section] objectAtIndex:row ] floatValue];
    NSString *type = [[[tableDict objectForKey:@"section"] objectAtIndex:section] objectForKey:@"type"];
    NSString *flag = [[[tableDict objectForKey:@"section"] objectAtIndex:section] objectForKey:@"flag"];
    NSString *itemScore= nil;
    if ([type isEqualToString:@"table"]) {
        content = [[[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row] objectForKey:@"content"];
        rule = [[[[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row] objectForKey:@"rule"] objectForKey:@"text"];
        text = [[[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row] objectForKey:@"text"] ;
        target = [[[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row] objectForKey:@"target"];
        
        if ([flag isEqualToString:@"segment"]) {
            select = [[[[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row] objectForKey:@"rule"] objectForKey:@"fullmark"] ;
        }
        if (![flag isEqualToString:@"segment"]) {
            select = [[[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row] objectForKey:@"switch"] ;
        }
                
        itemScore = [[[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row] objectForKey:@"score"] ;

        cell =[self makeSubCell:tableView withContent:content rule:rule text:text flag:flag target:target selected:select height:height row:row score:[itemScore integerValue]];
        
    }
    else if ([type  isEqualToString:@"text"]){
        
        content = [[[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row] objectForKey:@"text"];
        cellIdentifier = @"reason";
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        }
        
        float inset = 8.0;
        UITextField *reasonText = [[UITextField alloc] initWithFrame:CGRectMake(inset, inset, 430-2*inset, 44)];
        reasonText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        reasonText.ClearsOnBeginEditing=NO;
        reasonText.clearButtonMode = UITextFieldViewModeWhileEditing;
        reasonText.font = [UIFont fontWithName:@"ArialMT" size:18];
        reasonText.backgroundColor = [UIColor whiteColor];
        reasonText.placeholder = @"填写扣分原因";
        reasonText.tag = 1003;
        reasonText.returnKeyType = UIReturnKeyDone;
        reasonText.delegate = self;
        reasonText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [reasonText setBackgroundColor:[UIColor clearColor]];
        reasonText.text = content;
        [cell.contentView addSubview:reasonText];
        [reasonText release];
        
    }
    else {
        content = [[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row];
        cellIdentifier = @"content";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        }
        cell.selectionStyle= UITableViewCellSelectionStyleGray;
        cell.textLabel.text = content;
        cell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20.0];
        cell.textLabel.numberOfLines = 0;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSInteger section = indexPath.section;
    //    NSInteger row = indexPath.row;
    //    NSString *type = [[[tableDict objectForKey:@"section"] objectAtIndex:section] objectForKey:@"type"];
    //    NSString *flag = [[[tableDict objectForKey:@"section"] objectAtIndex:section] objectForKey:@"flag"];
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //    if ([type isEqualToString:@"table"]) {
    //        if ([flag isEqualToString:@"select"]) {
    //            if (cell.accessoryType == UITableViewCellSeparatorStyleNone) {
    //                cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //                NSMutableDictionary *dict =  [[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row];
    //                [dict setObject:[NSNumber numberWithBool:YES] forKey:@"select"];
    //                [self calculateScores:indexPath select:YES];
    //
    //            }
    //            else {
    //                cell.accessoryType = UITableViewCellSeparatorStyleNone;
    //                NSMutableDictionary *dict =  [[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row];
    //                [dict setObject:[NSNumber numberWithBool:NO] forKey:@"select"];
    //                [self calculateScores:indexPath select:NO];
    //            }
    //        }
    //    }
    //    else {
    //        if ([flag isEqualToString:@"select"]) {
    //            if(indexPath == currentIndex){
    //                return;
    //            }
    //            NSIndexPath *oldIndexPath = currentIndex;
    //            UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    //            if (newCell.accessoryType == UITableViewCellAccessoryNone) {
    //                newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    //                NSMutableDictionary *dict =  [[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row];
    //                [dict setObject:[NSNumber numberWithBool:YES] forKey:@"select"];
    //            }
    //            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    //            if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
    //                oldCell.accessoryType = UITableViewCellAccessoryNone;
    //                NSMutableDictionary *dict =  [[[tableDict objectForKey:@"cellArray"] objectAtIndex:section] objectAtIndex:row];
    //                [dict setObject:[NSNumber numberWithBool:NO] forKey:@"select"];
    //            }
    //            self.currentIndex=indexPath;
    //        }
    //
    //    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
