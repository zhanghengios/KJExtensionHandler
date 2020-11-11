//
//  UIBezierPath+KJPoints.m
//  AutoDecorate
//
//  Created by 杨科军 on 2020/7/8.
//  Copyright © 2020 songxf. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIBezierPath+KJPoints.h"

@implementation UIBezierPath (KJPoints)
- (NSArray*)points{
    NSMutableArray *temps = [NSMutableArray array];
    CGPathApply(self.CGPath, (__bridge void *)temps, kGetBezierPathPoints);
    return temps.mutableCopy;
}
static void kGetBezierPathPoints(void *info,const CGPathElement *element){
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPathElementType type = element->type;
    CGPoint *points = element->points;
    if (type != kCGPathElementCloseSubpath) {
        [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
        if ((type != kCGPathElementAddLineToPoint) && (type != kCGPathElementMoveToPoint)) {
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
        }
    }
    if (type == kCGPathElementAddCurveToPoint) {
        [bezierPoints addObject:[NSValue valueWithCGPoint:points[2]]];
    }
}

@end
