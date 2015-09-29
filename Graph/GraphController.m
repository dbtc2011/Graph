//
//  GraphController.m
//  Graph
//
//  Created by DT_Macmini_Mark Angeles on 10/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphController.h"

@interface GraphController ()

@end

@implementation GraphController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}
#pragma mark Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil using: (NSMutableArray*)points{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor whiteColor]];
        arrPoints = [[NSMutableArray alloc]initWithCapacity:0];
        arrXAxis  = [[NSMutableArray alloc]initWithCapacity:0];
        arrYAxis = [[NSMutableArray alloc]initWithCapacity:0];
        arrLabelXAxis = [[NSMutableArray alloc]initWithCapacity:0];
        [arrPoints addObjectsFromArray:points];
        arrLabelPoints = [[NSMutableArray alloc]initWithCapacity:0];
        [arrLabelPoints addObjectsFromArray:[GraphSetting getDisplayPointsUsingMax:[GraphSetting getMaxValue:arrPoints] usingMin:[GraphSetting getMinValue:arrPoints] withTotalYContent:3]];
        
        //UIImageView *imgView = [[[UIImageView alloc]initWithFrame:CGRectMake(60, 20, 400, 230)]autorelease];
        //imgView.layer.borderColor = [UIColor redColor].CGColor;
        //plotGraph.layer.cornerRadius = 8;
        //imgView.layer.borderWidth = 2;
        //[self.view addSubview:imgView];
        UIButton *btnDaily = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnDaily setTitle:@"Daily" forState:UIControlStateNormal];
        [btnDaily setFrame:CGRectMake(60, 5, 70, 30)];
        [btnDaily addTarget:self action:@selector(daily) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnDaily];
        
        UIButton *btnWeekly = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnWeekly setTitle:@"Weekly" forState:UIControlStateNormal];
        [btnWeekly setFrame:CGRectMake(CGRectGetMaxX(btnDaily.frame)+5, 5, 70, 30)];
        [btnWeekly addTarget:self action:@selector(weekly) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnWeekly];
        
        UIButton *btnMonthly = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnMonthly setTitle:@"Monthly" forState:UIControlStateNormal];
        [btnMonthly addTarget:self action:@selector(monthly) forControlEvents:UIControlEventTouchUpInside];
        [btnMonthly setFrame:CGRectMake(CGRectGetMaxX(btnWeekly.frame)+5, 5, 70, 30)];
        [self.view addSubview:btnMonthly];
        
        UIButton *btnYearly = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnYearly setTitle:@"Yearly" forState:UIControlStateNormal];
        [btnYearly addTarget:self action:@selector(yearly) forControlEvents:UIControlEventTouchUpInside];
        [btnYearly setFrame:CGRectMake(CGRectGetMaxX(btnMonthly.frame)+5, 5, 70, 30)];
        [self.view addSubview:btnYearly];
//        Graph Size : Width = 400, Height = 230
        plotGraph = [[GraphPlot alloc]initWithFrame:CGRectMake(60, 40, 400, 230) usingPoints:arrPoints];
        plotGraph.layer.borderColor = [UIColor redColor].CGColor;
        //plotGraph.layer.cornerRadius = 8;
        [plotGraph setDelegate:self];
        plotGraph.layer.borderWidth = 2;
        [self.view addSubview:plotGraph];
        [self setUpYAxis];
        [self setUpXAxis:@"yearly"];
    }
    return self;
}
#pragma mark View Selection
- (void)daily{
    [arrLabelPoints removeAllObjects];
    NSMutableArray *arrayHolder = [NSMutableArray array];
    for (int count = 0; count < 5; count++) {
        [arrayHolder addObject:[arrPoints objectAtIndex:count]];
    }
    [arrLabelPoints addObjectsFromArray:[GraphSetting getDisplayPointsUsingMax:[GraphSetting getMaxValue:arrayHolder] usingMin:[GraphSetting getMinValue:arrayHolder] withTotalYContent:3]];
    [plotGraph.arrPoints removeAllObjects];
    [plotGraph.arrPoints addObjectsFromArray:arrayHolder];
    [self setUpYAxis];
    [self setUpXAxis:@"daily"];
    [plotGraph changeSetUp];
}
- (void)weekly{
    [arrLabelPoints removeAllObjects];
    NSMutableArray *arrayHolder = [NSMutableArray array];
    for (int count = 0; count < 4; count++) {
        [arrayHolder addObject:[arrPoints objectAtIndex:count]];
    }
    [arrLabelPoints addObjectsFromArray:[GraphSetting getDisplayPointsUsingMax:[GraphSetting getMaxValue:arrayHolder] usingMin:[GraphSetting getMinValue:arrayHolder] withTotalYContent:3]];
    [plotGraph.arrPoints removeAllObjects];
    [plotGraph.arrPoints addObjectsFromArray:arrayHolder];
    [self setUpYAxis];
    [self setUpXAxis:@"weekly"];
    [plotGraph changeSetUp];
}
- (void)monthly{
    [arrLabelPoints removeAllObjects];
    NSMutableArray *arrayHolder = [NSMutableArray array];
    for (int count = 0; count < 3; count++) {
        [arrayHolder addObject:[arrPoints objectAtIndex:count]];
    }
    [arrLabelPoints addObjectsFromArray:[GraphSetting getDisplayPointsUsingMax:[GraphSetting getMaxValue:arrayHolder] usingMin:[GraphSetting getMinValue:arrayHolder] withTotalYContent:3]];
    [plotGraph.arrPoints removeAllObjects];
    [plotGraph.arrPoints addObjectsFromArray:arrayHolder];
    [self setUpYAxis];
    [self setUpXAxis:@"monthly"];
    [plotGraph changeSetUp];
}
- (void)yearly{
    [arrLabelPoints removeAllObjects];
    NSMutableArray *arrayHolder = [NSMutableArray array];
    for (int count = 0; count < 7; count++) {
        [arrayHolder addObject:[arrPoints objectAtIndex:count]];
    }
    [arrLabelPoints addObjectsFromArray:[GraphSetting getDisplayPointsUsingMax:[GraphSetting getMaxValue:arrayHolder] usingMin:[GraphSetting getMinValue:arrayHolder] withTotalYContent:3]];
    [plotGraph.arrPoints removeAllObjects];
    [plotGraph.arrPoints addObjectsFromArray:arrayHolder];
    [self setUpYAxis];
    [self setUpXAxis:@"yearly"];
    [plotGraph changeSetUp];
}
- (void)setUpYAxis{
    for (UILabel *lbl in arrYAxis) {
        [lbl removeFromSuperview];
    }
    float yLocation = CGRectGetMinY(plotGraph.frame);
    for (int count = [arrLabelPoints count]-1; count >=0; count--) {
        UILabel *lbl = [[[UILabel alloc]initWithFrame:CGRectMake(5, yLocation, 50, 230/3)]autorelease];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setText:[NSString stringWithFormat:@"%.3f",[[arrLabelPoints objectAtIndex:count]floatValue]]];
        [lbl setTextAlignment:UITextAlignmentRight];
        [lbl setTextColor:[UIColor blueColor]];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [arrYAxis addObject:lbl];
        [self.view addSubview:lbl];
        yLocation = yLocation + CGRectGetHeight(lbl.frame); 
    }
    
}
- (void)setUpXAxis: (NSString*)setup{
    for (UILabel *lbl in arrXAxis) {
        [lbl removeFromSuperview];
    }
    [arrLabelXAxis removeAllObjects];
    [arrLabelXAxis addObjectsFromArray:[GraphSetting getLabelPointsOf:setup]];
    NSLog(@"XWIDTH == %f",self.view.frame.size.width);
    float xLocation = CGRectGetMinX(plotGraph.frame) + ((CGRectGetWidth(plotGraph.frame)/[arrLabelXAxis count])/2);
    for (int count = [arrLabelXAxis count]-1; count >=0; count--) {
        UILabel *lbl = [[[UILabel alloc]initWithFrame:CGRectMake(xLocation, CGRectGetMaxY(plotGraph.frame)+5, CGRectGetWidth(plotGraph.frame)/([arrLabelXAxis count]+1), 30)]autorelease];
        [lbl setText:[arrLabelXAxis objectAtIndex:count]];
        [lbl setTag:[arrLabelXAxis count]-count];
        [lbl setNumberOfLines:0];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextColor:[UIColor blueColor]];
        //[lbl setText:[NSString stringWithFormat:@"%.3f",[[arrPoints objectAtIndex:count]floatValue]]];
        [lbl setTextAlignment:UITextAlignmentCenter];
        [lbl setTextColor:[UIColor blueColor]];
        [lbl setFont:[UIFont systemFontOfSize:10]];
        [arrXAxis addObject:lbl];
        [self.view addSubview:lbl];
        xLocation = xLocation + CGRectGetWidth(lbl.frame); 
    }
}

#pragma mark Plot Delegate
- (void)selectedPoint:(int)selected{
    NSLog(@"SELECTED ---- [%d]",selected);
    for (UILabel *lbl in arrXAxis) {
        if (selected + 1 == [lbl tag]) {
            [lbl setTextColor:[UIColor redColor]];
            [lbl setFont:[UIFont systemFontOfSize:12]];
        }else{
            [lbl setTextColor:[UIColor blueColor]];
            [lbl setFont:[UIFont systemFontOfSize:10]];
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
