//
//  PKViewController.m
//  PainterKit
//
//  Created by Yeung Yiu Hung on 01/11/2017.
//  Copyright (c) 2017 Yeung Yiu Hung. All rights reserved.
//

#import "PKViewController.h"

#import <PainterKit/PainterKit.h>

@interface PKViewController ()
@property (strong, nonatomic) IBOutlet PKPainterScrollView *painterScrollView;

@end

@implementation PKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.painterScrollView setPainterImage:[UIImage imageNamed:@"testImg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)brushButtonPressed:(id)sender {
    [self.painterScrollView setIsPainting:YES];
    [self.painterScrollView setCurrentDrawingTool:[PKBrushDrawingTool brushWithSize:3.0 color:[UIColor blueColor]]];
}
- (IBAction)eraserButtonPressed:(id)sender {
    [self.painterScrollView setIsPainting:YES];
    [self.painterScrollView setCurrentDrawingTool:[PKEraserDrawingTool eraserWithSize:3.0]];
}
- (IBAction)scrollButtonPressed:(id)sender {
    [self.painterScrollView setIsPainting:NO];
}
- (IBAction)saveButtonPressed:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:@"example.jpg"];
    if (![UIImageJPEGRepresentation([self.painterScrollView resultImage], 0.8) writeToFile:imagePath atomically:NO])
    {
        NSLog(@"Failed to cache image data to disk");
    }
    else
    {
        NSLog(@"the cachedImagedPath is %@",imagePath);
    }
}

@end
