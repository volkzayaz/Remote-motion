//
//  FirstViewController.m
//  GridSearch
//
//  Created by Vlad Soroka on 10/1/15.
//  Copyright © 2015 Vlad Soroka. All rights reserved.
//

#import "FirstViewController.h"

@import GameController;

@interface FirstViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) GCController* controller;

@property (nonatomic, strong) NSMutableArray* xPoints;
@property (nonatomic, strong) NSMutableArray* xViews;

@property (nonatomic, strong) NSMutableArray* yPoints;
@property (nonatomic, strong) NSMutableArray* yViews;

@property (nonatomic, strong) NSMutableArray* zPoints;
@property (nonatomic, strong) NSMutableArray* zViews;

@property (nonatomic, strong) UIView* baseView;

@property (nonatomic, strong) UITapGestureRecognizer* gr;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGSize size = self.view.frame.size;
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, size.height / 2, size.width, 5)];
    view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:view];
    self.baseView = view;
    
    self.xPoints = @[].mutableCopy;
    self.xViews = @[].mutableCopy;
    
    self.yPoints = @[].mutableCopy;
    self.yViews = @[].mutableCopy;

    self.zPoints = @[].mutableCopy;
    self.zViews = @[].mutableCopy;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserverForName:GCControllerDidConnectNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull note) {
        self.controller = note.object;
        self.controller.microGamepad.reportsAbsoluteDpadValues = YES;
//        self.controller.microGamepad.dpad.valueChangedHandler =
//        ^(GCControllerDirectionPad *dpad, float xValue, float yValue) {
//            
//            NSLog(@"%f",xValue);
//            
//            if(xValue > 0.9)
//            {
//                ////user currently has finger near right side of remote
//            }
//            
//            if(xValue < -0.9)
//            {
//                ////user currently has finger near left side of remote
//            }
//            
//            if(xValue == 0 && yValue == 0)
//            {
//                ////user released finger from touch surface
//            }
//        };
                                                      self.controller.microGamepad.buttonA.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed){
                                                          NSLog(@"%i",pressed);
                                                      };
//        GCMotion* m = self.controller.motion;
//        m.valueChangedHandler = ^ (GCMotion *motion) {
//            if (motion) {
//                
//        
//                
////                static double v = 0;
////                if(v < motion.userAcceleration.x)
////                {
////                    v = motion.userAcceleration.x;
////                    NSLog(@"%f",v);
////                }
//                
//                //[self reportXValue:motion.gravity.x];
//                if(fabs(motion.userAcceleration.y) > 0.8)
//                {
//                    [self reportYValue:motion.gravity.y];
//                }
//                //[self reportZValue:motion.gravity.z];
//            }
//        };
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.xPoints enumerateObjectsUsingBlock:^(NSNumber*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        double value = obj.doubleValue;
        UIView* view = self.xViews[idx];
        
        CGFloat size = 5;
        CGFloat spacing = size;
        CGFloat yScalingFactor = self.view.frame.size.height / 2;
        CGFloat zeroYLevel = self.view.frame.size.height / 2;
        
        view.frame = CGRectMake(idx * spacing, zeroYLevel + -1 * (value * yScalingFactor), size, size);
    }];
    
    [self.yPoints enumerateObjectsUsingBlock:^(NSNumber*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        double value = obj.doubleValue;
        UIView* view = self.yViews[idx];
        
        CGFloat size = 5;
        CGFloat spacing = size;
        CGFloat yScalingFactor = self.view.frame.size.height / 2;
        CGFloat zeroYLevel = self.view.frame.size.height / 2;
        
        view.frame = CGRectMake(idx * spacing, zeroYLevel + -1 * (value * yScalingFactor), size, size);
    }];
    
    [self.zPoints enumerateObjectsUsingBlock:^(NSNumber*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        double value = obj.doubleValue;
        UIView* view = self.zViews[idx];
        
        CGFloat size = 5;
        CGFloat spacing = size;
        CGFloat yScalingFactor = self.view.frame.size.height / 2;
        CGFloat zeroYLevel = self.view.frame.size.height / 2;
        
        view.frame = CGRectMake(idx * spacing, zeroYLevel + -1 * (value * yScalingFactor), size, size);
    }];
}

- (void) reportXValue:(double) var
{
    if(self.xPoints.count > 200)
    {
        [self.xPoints removeObjectAtIndex:0];
        
        [self.xViews.firstObject removeFromSuperview];
        [self.xViews removeObjectAtIndex:0];
    }
    
    [self.xPoints addObject:@(var)];
    
    UIView* view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [self.xViews addObject:view];
}

- (void) reportYValue:(double) var
{
    NSLog(@"%f",var);
    
    if(self.yPoints.count > 50)//200)
    {
        [self.yPoints removeObjectAtIndex:0];
        
        [self.yViews.firstObject removeFromSuperview];
        [self.yViews removeObjectAtIndex:0];
    }
    
    [self.yPoints addObject:@(var)];
    
    UIView* view = [UIView new];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    [self.yViews addObject:view];
}

- (void) reportZValue:(double) var
{
    if(self.zPoints.count > 50)
    {
        [self.zPoints removeObjectAtIndex:0];
        
        [self.zViews.firstObject removeFromSuperview];
        [self.zViews removeObjectAtIndex:0];
    }
    
    [self.zPoints addObject:@(var)];
    
    UIView* view = [UIView new];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    [self.zViews addObject:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
