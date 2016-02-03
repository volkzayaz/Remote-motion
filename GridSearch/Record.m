//
//  Record.m
//  GridSearch
//
//  Created by Vlad Soroka on 12/15/15.
//  Copyright © 2015 Vlad Soroka. All rights reserved.
//

#import "Record.h"

@implementation Record

///first and last values have small variance
///difference between max and min should be considerable

///everything to the left of max should not increase
///everything to the right of max should not increase

+ (BOOL)isValidWithSmaples:(NSArray<Record*> *)records
{
    
    
    Record* maxValue = [records valueForKeyPath:@"@max.self"];
    double y1 = maxValue.value;
    
    Record* minValue = [records valueForKeyPath:@"@min.self"];
    double y2 = minValue.value;
    double x2 = [records indexOfObject:minValue];
    
    if (fabs(y1 - y2) < 0.4) return NO;
    
    ///function is not incresaing on all x smaller than x2
    for(NSInteger x = 1; x < x2; x++)
    {
        Record* rec = records[x];
        Record* prevRec = records[x-1];
        
        if(prevRec.value < rec.value) return NO;
    }
    
    ///function is not decreasing on all x bigger than x2
    for(NSInteger x = x2; x < records.count - 1; x++)
    {
        double rec = records[x].value;
        double nextRec = records[x+1].value;
        
        if(fabs(rec - nextRec) < 0.05)
        {
            continue;
        }
        
        if(rec < nextRec) return NO;
    }
    
    return YES;
}

- (NSComparisonResult) compare:(Record*)other
{
    return [@(self.value) compare:@(other.value)];
}

- (UIColor *)color
{
    return self.isDifferent ? [UIColor redColor] : [UIColor yellowColor];
}

@end
