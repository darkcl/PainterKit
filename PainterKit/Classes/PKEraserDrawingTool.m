//
//  PKEraserDrawingTool.m
//  Pods
//
//  Created by Yeung Yiu Hung on 12/1/2017.
//
//

#import "PKEraserDrawingTool.h"

@implementation PKEraserDrawingTool

+ (id)eraserWithSize:(CGFloat)size{
    PKEraserDrawingTool *result = [[PKEraserDrawingTool alloc] init];
    result.eraserSize = size;
    
    return result;
}

- (id)init{
    if (self = [super init]) {
        _eraserSize = 1.0f;
    }
    return self;
}

- (PKDrawingBlock)drawingBlock{
    return ^(CGContextRef context, CGPoint firstPoint, CGPoint secondPoint, CGFloat scale){
        CGContextSetLineWidth(context, self.eraserSize * scale);
        CGContextSetBlendMode(context, kCGBlendModeClear);
        
        CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        
        CGContextMoveToPoint(context, firstPoint.x * scale, firstPoint.y * scale);
        CGContextAddLineToPoint(context, secondPoint.x * scale, secondPoint.y * scale);
        
        CGContextStrokePath(context);
    };
}

@end
