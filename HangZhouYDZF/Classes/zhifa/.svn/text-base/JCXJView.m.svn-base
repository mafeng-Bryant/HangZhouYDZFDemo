//
//  JCXJView.m
//  GMEPS_HZ
//
//  Created by zhang on 13-4-7.
//
//

#import "JCXJView.h"

@interface JCXJView()

@end

@implementation JCXJView


-(id)init{
    self = [[[[NSBundle mainBundle] loadNibNamed:@"JCXJView" owner:self options:nil] objectAtIndex:0] retain];
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
    [dicValues setValue:xjView.text forKey:@"JCXJ"];
    [dicValues setValue:bzView.text forKey:@"BZ"];
    [dicValues setValue:zsqkTxtView.text forKey:@"ZSQK"];
    return dicValues;
}

-(void)loadData:(NSDictionary*)values{
    xjView.text = [values objectForKey:@"JCXJ"];
    bzView.text = [values objectForKey:@"BZ"];
    zsqkTxtView.text = [values objectForKey:@"ZSQK"];
}
@end
