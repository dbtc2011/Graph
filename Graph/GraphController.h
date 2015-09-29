//
//  GraphController.h
//  Graph
//
//  Created by DT_Macmini_Mark Angeles on 10/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphPlot.h"
@interface GraphController : UIViewController<GraphPlotDelegate>{
    NSMutableArray *arrPoints;
    NSMutableArray *arrLabelPoints;
    NSMutableArray *arrLabelXAxis;
    NSMutableArray *arrXAxis;
    NSMutableArray *arrYAxis;
    GraphPlot *plotGraph;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil using: (NSMutableArray*)points;
@end
