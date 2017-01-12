//
//  PKBaseDrawingTool.h
//  Pods
//
//  Created by Yeung Yiu Hung on 12/1/2017.
//
//

#import <Foundation/Foundation.h>

typedef void(^PKDrawingBlock)(CGContextRef context, CGPoint firstPoint, CGPoint secondPoint, CGFloat scale);

@interface PKBaseDrawingTool : NSObject

@property (nonatomic, strong) PKDrawingBlock drawingBlock;

@end
