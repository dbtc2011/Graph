//
//  GraphPlot.h
//  Graph
//
//  Created by DT_Macmini_Mark Angeles on 10/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphSetting.h"

@protocol GraphPlotDelegate <NSObject>

- (void)selectedPoint :(int)selected;

@end
@interface GraphPlot : UIView{
    
    UIBezierPath *path;
    float xPoint;
    float adder;
    NSMutableArray *_arrPoints;
    NSMutableArray *_arrIndicator;
    float xLine;
    int index;
    BOOL LineYES;
    
}
- (id)initWithFrame:(CGRect)frame usingPoints: (NSMutableArray*)points;
- (void)changeSetUp;
@property (nonatomic, retain)id <GraphPlotDelegate>delegate;
@property (nonatomic, retain)NSMutableArray *arrPoints;

@end
