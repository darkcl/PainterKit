//
//  PKPainterContentView.m
//  Pods
//
//  Created by Yeung Yiu Hung on 12/1/2017.
//
//

#import "PKPainterContentView.h"

#import "PKPainterLayerView.h"

@interface PKPainterContentView() {
    UIImageView *imageView;
    
    UIImage *originalImage;
    
    PKPainterLayerView *painterLayerView;
}

@end

@implementation PKPainterContentView

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)image{
    if (self = [super initWithFrame:frame]) {
        originalImage = image;
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        imageView.image = image;
        imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:imageView];
        
        painterLayerView = [[PKPainterLayerView alloc] initWithFrame:imageView.frame];
        painterLayerView.backgroundColor = [UIColor clearColor];
        
        painterLayerView.isPainting = NO;
        
        [self addSubview:painterLayerView];
    }
    return self;
}

- (void)setCurrentDrawingTool:(PKBaseDrawingTool *)drawingTool{
    [painterLayerView setCurrentDrawingTool:drawingTool];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [painterLayerView touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [painterLayerView touchesMoved:touches withEvent:event];
}

- (void)setIsPainting:(BOOL)isPainting{
    painterLayerView.isPainting = isPainting;
    
    if (isPainting) {
        imageView.userInteractionEnabled = YES;
    }else{
        imageView.userInteractionEnabled = NO;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSUndoManager *)painterUndoManager{
    return painterLayerView.painterUndoManager;
}

- (UIImage *)resultImage{
    CGSize imageSize = originalImage.size;
    
    CGFloat scale = (imageSize.width / imageView.frame.size.width);
    
    UIGraphicsBeginImageContext(originalImage.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSUInteger i = 0; i < painterLayerView.steps.count; i++) {
        __weak NSMutableArray *pointArray = painterLayerView.steps[i][@"pointArray"];
        if (pointArray.count > 0) {
            for (NSUInteger j = 0; j < pointArray.count - 1; j++) {
                __weak NSValue *firstPointValue = pointArray[j];
                __weak NSValue *secondPointValue = pointArray[j+1];
                
                CGPoint firstPoint = [firstPointValue CGPointValue];
                CGPoint secondPoint = [secondPointValue CGPointValue];
                
                PKBaseDrawingTool *drawingTool = painterLayerView.steps[i][@"drawingTool"];
                drawingTool.drawingBlock(context, firstPoint, secondPoint, scale);
            }
        }
    }
    
    // Create layer image
    UIImage *layerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(originalImage.size);
    [originalImage drawAtPoint:CGPointMake(0,0)];
    [layerImage drawAtPoint:CGPointMake(0,0)];
    // Create new image
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    // Tidy up
    UIGraphicsEndImageContext();
    
    return result;
}

@end
