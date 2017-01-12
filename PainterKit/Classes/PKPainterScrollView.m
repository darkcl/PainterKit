//
//  PKPainterScrollView.m
//  Pods
//
//  Created by Yeung Yiu Hung on 12/1/2017.
//
//

#import "PKPainterScrollView.h"

#import "PKPainterContentView.h"

@interface PKPainterScrollView() {
    PKPainterContentView *contentView;
}

@end

@implementation PKPainterScrollView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)setPainterImage:(UIImage *)image{
    [contentView removeFromSuperview];
    
    CGSize imageSize = image.size;
    
    if (imageSize.width/imageSize.height > self.frame.size.width/self.frame.size.height) {
        contentView = [[PKPainterContentView alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2 - (self.frame.size.width * imageSize.height/imageSize.width)/2, self.frame.size.width, self.frame.size.width * imageSize.height/imageSize.width) andImage:image];
    }else{
        contentView = [[PKPainterContentView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - (self.frame.size.height * imageSize.width/imageSize.height)/2, 0, self.frame.size.height * imageSize.width/imageSize.height, self.frame.size.height) andImage:image];
    }
    
    [self addSubview:contentView];
    [self setIsPainting:NO];
}

- (void)setIsPainting:(BOOL)isPainting{
    [contentView setIsPainting:isPainting];
    
    self.scrollEnabled = !isPainting;
    self.minimumZoomScale = 1.0;
    self.maximumZoomScale = 4.0;
    
    self.delegate = isPainting ? nil: self;
}

- (void)setCurrentDrawingTool:(PKBaseDrawingTool *)drawingTool{
    [contentView setCurrentDrawingTool:drawingTool];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIImage *)resultImage{
    return contentView.resultImage;
}


#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return contentView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    contentView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    view.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                              scrollView.contentSize.height * 0.5 + offsetY);
}

@end
