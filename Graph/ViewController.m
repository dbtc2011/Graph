//
//  ViewController.m
//  Graph
//
//  Created by DT_Macmini_Mark Angeles on 10/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(callGraph) withObject:nil afterDelay:1];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)callGraph{
    //GraphDisplay *graph = [[GraphDisplay alloc]initWithFrame:CGRectMake(0, 0, 320, 480)usingPoints:nil];
    //GraphDisplay *_graph = [[GraphDisplay alloc]initWithFrame:CGRectMake((480/2)-(320/2), (320/2)-(300/2), 320, 300) usingPoints:nil];
    NSMutableArray *arrUS  = [NSMutableArray array];
    NSMutableArray *arrPH = [NSMutableArray array];
                                                    
    [arrUS addObjectsFromArray:[NSArray arrayWithObjects:@"0.649349", @"0.649152",@"0.649587", @"0.649099", @"0.647565", @"0.649701", @"0.65094", @"0.649901", @"0.648872", @"0.649261", @"0.648267", @"0.646022",@"0.646636",@"0.648087",@"0.648284",nil]];
    //													
    //[arrPH addObjectsFromArray:[NSArray arrayWithObjects:@"0.836167",@"0.839354",@"0.838227",@"0.840648",@"0.841964",@"0.841558",@"0.838997",@"0.839542",@"0.841587",@"0.842156",@"0.845729",@"0.847581",@"0.848257",@"0.844781",@"0.846853",nil]];
    [arrPH addObjectsFromArray:[NSArray arrayWithObjects:@"0.0155574",@"0.0155233",@"0.0155997",@"0.0155842",@"0.0155923",@"0.0156596",@"0.0157202",@"0.0156433",@"0.0155949",@"0.0156539",@"0.0156224",@"0.0156127",@"0.0156912",@"0.0157036",@"0.0156609",nil]];
    
    GraphController *_graph = [[GraphController alloc]initWithNibName:nil bundle:nil using:[GraphSetting getConvertedValueOf:arrUS to:arrPH]];
    [_graph setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:_graph animated:YES];
}
- (void)dealloc{
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
