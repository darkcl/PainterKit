//
//  PKPainterLayerView.h
//  Pods
//
//  Created by Yeung Yiu Hung on 12/1/2017.
//
//

#import <UIKit/UIKit.h>
#import "PKBaseDrawingTool.h"

@interface PKPainterLayerView : UIView

@property (nonatomic, strong) PKBaseDrawingTool *currentDrawingTool;

@property BOOL isPainting;

@property (nonatomic, strong) NSMutableArray *steps;

@end
