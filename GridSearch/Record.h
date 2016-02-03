//
//  Record.h
//  GridSearch
//
//  Created by Vlad Soroka on 12/15/15.
//  Copyright © 2015 Vlad Soroka. All rights reserved.
//

@import UIKit;

@interface Record : NSObject

+ (BOOL) isValidWithSmaples:(NSArray*)records;

@property (nonatomic, assign) double value;
@property (nonatomic, assign) BOOL isDifferent;

@property (nonatomic, strong) UIColor* color;

@end
