//
//  PKPainterLayerView.m
//  Pods
//
//  Created by Yeung Yiu Hung on 12/1/2017.
//
//

#import "PKPainterLayerView.h"

@interface PKPainterLayerView() {
}

@end

@implementation PKPainterLayerView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _steps = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Touches methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.isPainting && self.currentDrawingTool != nil) {
        NSMutableArray *pointArray = [NSMutableArray array];
        NSDictionary *dic = @{@"pointArray": pointArray,
                              @"drawingTool": self.currentDrawingTool};
        [self.steps addObject:dic];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.isPainting && self.currentDrawingTool != nil) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        
        __weak NSMutableArray *pointArray = [self.steps lastObject][@"pointArray"];
        NSValue *pointValue = [NSValue valueWithCGPoint:point];
        [pointArray addObject:pointValue];
        
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSUInteger i = 0; i < self.steps.count; i++) {
        __weak NSMutableArray *pointArray = self.steps[i][@"pointArray"];
        if (pointArray.count > 0) {
            for (NSUInteger j = 0; j < pointArray.count - 1; j++) {
                __weak NSValue *firstPointValue = pointArray[j];
                __weak NSValue *secondPointValue = pointArray[j+1];
                
                CGPoint firstPoint = [firstPointValue CGPointValue];
                CGPoint secondPoint = [secondPointValue CGPointValue];
                
                PKBaseDrawingTool *drawingTool = self.steps[i][@"drawingTool"];
                drawingTool.drawingBlock(context, firstPoint, secondPoint, 1.0);
            }
        }
    }
    
    UIGraphicsEndPDFContext();
}

@end
