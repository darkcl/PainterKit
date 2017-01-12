//
//  PKPainterScrollView.h
//  Pods
//
//  Created by Yeung Yiu Hung on 12/1/2017.
//
//

#import <UIKit/UIKit.h>

#import "PKBaseDrawingTool.h"

@interface PKPainterScrollView : UIScrollView

- (void)setPainterImage:(UIImage *)image;

- (void)setCurrentDrawingTool:(PKBaseDrawingTool *)drawingTool;

- (void)setIsPainting:(BOOL)isPainting;

- (UIImage *)resultImage;

@end
