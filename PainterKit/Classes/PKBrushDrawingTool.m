//
//  PKBrushDrawingTool.m
//  Pods
//
//  Created by Yeung Yiu Hung on 12/1/2017.
//
//

#import "PKBrushDrawingTool.h"

@implementation PKBrushDrawingTool

+ (id)brushWithSize:(CGFloat)size color:(UIColor *)color{
    PKBrushDrawingTool *result = [[PKBrushDrawingTool alloc] init];
    result.brushSize = size;
    result.brushColor = color;
    
    return result;
}

- (id)init{
    if (self = [super init]) {
        _brushSize = 1.0;
        _brushColor = [UIColor blackColor];
    }
    return self;
}

- (PKDrawingBlock)drawingBlock{
    return ^(CGContextRef context, CGPoint firstPoint, CGPoint secondPoint, CGFloat scale){
        CGContextSetLineWidth(context, self.brushSize * scale);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        
        CGContextSetStrokeColorWithColor(context, self.brushColor.CGColor);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        
        CGContextMoveToPoint(context, firstPoint.x * scale, firstPoint.y * scale);
        CGContextAddLineToPoint(context, secondPoint.x * scale, secondPoint.y * scale);
        
        CGContextStrokePath(context);
    };
}

@end
