//
//  PKBrushDrawingTool.h
//  Pods
//
//  Created by Yeung Yiu Hung on 12/1/2017.
//
//

#import "PKBaseDrawingTool.h"

@interface PKBrushDrawingTool : PKBaseDrawingTool

+ (id)brushWithSize:(CGFloat)size color:(UIColor *)color;

@property CGFloat brushSize;

@property (nonatomic, strong) UIColor *brushColor;

@end
