//
//  PKCustomDrawingTool.m
//  PainterKit
//
//  Created by Yeung Yiu Hung on 12/1/2017.
//  Copyright © 2017 Yeung Yiu Hung. All rights reserved.
//

#import "PKCustomDrawingTool.h"

@implementation PKCustomDrawingTool

- (id)init{
    if (self = [super init]) {
        randomSize = 1.0f * (arc4random_uniform(3) + 1);
    }
    return self;
}

- (PKDrawingBlock)drawingBlock{
    return^(CGContextRef context, CGPoint firstPoint, CGPoint secondPoint, CGFloat scale){
        CGContextSetLineWidth(context, self->randomSize * scale);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        
        CGContextMoveToPoint(context, firstPoint.x * scale, firstPoint.y * scale);
        CGContextAddLineToPoint(context, secondPoint.x * scale, secondPoint.y * scale);
        
        CGContextStrokePath(context);
    };
}

@end
