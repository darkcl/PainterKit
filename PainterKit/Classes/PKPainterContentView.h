//
//  PKPainterContentView.h
//  Pods
//
//  Created by Yeung Yiu Hung on 12/1/2017.
//
//

#import <UIKit/UIKit.h>

#import "PKBaseDrawingTool.h"

@interface PKPainterContentView : UIView

- (id)initWithFrame:(CGRect)frame
           andImage:(UIImage *)image;

- (void)setCurrentDrawingTool:(PKBaseDrawingTool *)drawingTool;
- (void)setIsPainting:(BOOL)isPainting;

- (UIImage *)resultImage;

- (NSUndoManager *)painterUndoManager;

@end
