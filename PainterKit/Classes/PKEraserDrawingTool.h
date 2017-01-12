//
//  PKEraserDrawingTool.h
//  Pods
//
//  Created by Yeung Yiu Hung on 12/1/2017.
//
//

#import "PKBaseDrawingTool.h"

@interface PKEraserDrawingTool : PKBaseDrawingTool

+ (id)eraserWithSize:(CGFloat)size;

@property CGFloat eraserSize;

@end
