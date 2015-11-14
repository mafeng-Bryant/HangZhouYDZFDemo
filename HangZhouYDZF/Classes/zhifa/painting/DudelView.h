//
//  DudelView.h
//  Dudel
//
//  Created by JN on 2/25/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DudelViewDelegate
- (void)drawTemporary;
@end

@interface DudelView : UIView {
    NSMutableArray *drawables;
    IBOutlet id <DudelViewDelegate> delegate;
    BOOL bDrawBgImage;

}

@property (readonly) NSMutableArray *drawables;

@property (assign)BOOL bDrawBgImage;

- (void)saveImageToFile:(NSString*)fileName ;
- (void)drawImage;
@end
