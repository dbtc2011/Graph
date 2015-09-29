//
//  GraphPlot.m
//  Graph
//
//  Created by DT_Macmini_Mark Angeles on 10/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphPlot.h"

@implementation GraphPlot
@synthesize arrPoints,delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
       
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame usingPoints: (NSMutableArray*)points{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
        xLine = 0;
        arrPoints = [[NSMutableArray alloc]initWithCapacity:0];
        _arrPoints = [[NSMutableArray alloc]initWithCapacity:0];
        _arrIndicator = [[NSMutableArray alloc]initWithCapacity:0];
        [arrPoints addObjectsFromArray:points];
        [self changeSetUp];
        //self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
#pragma SetUp
- (void)changeSetUp{
    [_arrPoints removeAllObjects];
    NSLog(@"arrPoints == %@",arrPoints);
    adder = (self.frame.size.width)/([arrPoints count]+1);
    xPoint = adder;
    NSLog(@"adder===[%f]",adder);
    NSLog(@"MaxY = [%f]",[GraphSetting getMaxYValue:arrPoints]);
    for (int count  = 0; count < [arrPoints count]; count++) {
        [self points:count];
    }
    [self setNeedsDisplay];
}
- (void)points: (int)count{
    float multiplier = 0;
    float _frame = self.frame.size.height-(self.frame.size.height/3);
    multiplier = [GraphSetting getEquivalentOfOne:_frame to:[GraphSetting getMaxYValue:arrPoints]];
    [_arrPoints addObject:[NSString stringWithFormat:@"%f",_frame-[GraphSetting getEquivalentY:[[arrPoints objectAtIndex:count]floatValue] using:multiplier withMin:[GraphSetting getMinValue:arrPoints]]]];
}
- (void)drawRect:(CGRect)rect{
    // Create an oval shape to draw.
    float _pointAdder = (self.frame.size.height/3)/2;
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    // Set the starting point of the shape.
    
    [aPath moveToPoint:CGPointMake(2, self.frame.size.height)];
    for (int count = 0; count < [_arrPoints count]; count++) {
        [aPath addLineToPoint:CGPointMake(xPoint, [[_arrPoints objectAtIndex:count]floatValue]+_pointAdder)];
        xPoint = xPoint+adder;
    }
    [aPath addLineToPoint:CGPointMake(xPoint, [[_arrPoints lastObject]floatValue]+_pointAdder)];
    [aPath addLineToPoint:CGPointMake(xPoint, self.frame.size.height)];
    [aPath addLineToPoint:CGPointMake(2, self.frame.size.height)];
    [aPath setLineWidth:2];
    [aPath closePath];
    [[UIColor blackColor] setStroke];
    UIColor *color = [[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
    [color setFill];
    [aPath stroke];
    [aPath fill];
    
    UIBezierPath *lineMargin = [UIBezierPath bezierPath];
    [lineMargin moveToPoint:CGPointMake(adder, self.frame.size.height)];
    [lineMargin addLineToPoint:CGPointMake(adder, 0)];
    [lineMargin setLineWidth:1];
    [[UIColor yellowColor] setStroke];
    [lineMargin stroke];
    
    UIBezierPath *lineMargin1 = [UIBezierPath bezierPath];
    [lineMargin1 moveToPoint:CGPointMake(self.frame.size.width-adder, self.frame.size.height)];
    [lineMargin1 addLineToPoint:CGPointMake(self.frame.size.width-adder, 0)];
    //[linePath1 addLineToPoint:CGPointMake(xLine, 0)];
    [lineMargin1 setLineWidth:1];
    [[UIColor yellowColor] setStroke];
    [lineMargin1 stroke];
    xPoint = adder;
    for (int count = 0; count < [_arrPoints count]; count++) {
               
        UIBezierPath *circle;
        circle =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(xPoint-4, [[_arrPoints objectAtIndex:count]floatValue]-4+_pointAdder, 8, 8)];
        [[UIColor blueColor]setFill];
        if (LineYES && index == count) {
            [[UIColor redColor]setFill];
        }
        [circle fill];
        xPoint = xPoint+adder;
    }
    for (UILabel *lbl in _arrIndicator) {
        [lbl removeFromSuperview];
    }
    if (LineYES) {
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:CGPointMake(xLine, self.frame.size.height)];
        [linePath addLineToPoint:CGPointMake(xLine, 0)];
        [linePath setLineWidth:1];
        [[UIColor redColor] setStroke];
        [linePath stroke];
        
        UIBezierPath *linePath1 = [UIBezierPath bezierPath];
        [linePath1 moveToPoint:CGPointMake(0, [[_arrPoints objectAtIndex:index]floatValue]+_pointAdder)];
        [linePath1 addLineToPoint:CGPointMake(xLine, [[_arrPoints objectAtIndex:index]floatValue]+_pointAdder)];
        //[linePath1 addLineToPoint:CGPointMake(xLine, 0)];
        [linePath1 setLineWidth:1];
        [[UIColor redColor] setStroke];
        [linePath1 stroke];
        
        
        UILabel *lbl = [[[UILabel alloc]initWithFrame:CGRectMake(xLine-25, [[_arrPoints objectAtIndex:index]floatValue], 50, 20)]autorelease];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:UITextAlignmentCenter];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [lbl setText:[NSString stringWithFormat:@"%.3f",[[arrPoints objectAtIndex:index] floatValue]]];
        [_arrIndicator addObject:lbl];
        [self addSubview:lbl];
        
    }
    
}
#pragma mark Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   // NSLog(@"touches");
    NSLog(@"width == %f\nHeight == %f",self.frame.size.width, self.frame.size.height);
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSLog(@"point x = %@ %@",[NSString stringWithFormat:@"%f",[GraphSetting getEquivalentYLine:point.x using:self.frame.size.width/[arrPoints count] withPoints:arrPoints]],arrPoints);
    LineYES = YES;
    NSLog(@"array== %@---%f",arrPoints,[GraphSetting getEquivalentYLine:point.x using:self.frame.size.width/[arrPoints count] withPoints:arrPoints]);
    index = [arrPoints indexOfObject:[NSString stringWithFormat:@"%f",[GraphSetting getEquivalentYLine:point.x using:self.frame.size.width/[arrPoints count] withPoints:arrPoints]]];
    xLine = index*((self.frame.size.width)/([arrPoints count]+1)) + ((self.frame.size.width)/([arrPoints count]+1));
    xPoint = adder;
    
    [delegate selectedPoint:index];
    [self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    LineYES = YES;
    index = [arrPoints indexOfObject:[NSString stringWithFormat:@"%f",[GraphSetting getEquivalentYLine:point.x using:self.frame.size.width/[arrPoints count] withPoints:arrPoints]]];
    xLine = index*((self.frame.size.width)/([arrPoints count]+1)) + ((self.frame.size.width)/([arrPoints count]+1));
    xPoint = adder;
    [delegate selectedPoint:index];
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    LineYES = NO;
    xPoint = adder;
    [delegate selectedPoint:-1];
    [self setNeedsDisplay];
}
- (void)dealloc{
    [arrPoints release];
    [_arrPoints release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
