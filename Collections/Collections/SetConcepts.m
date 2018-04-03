//
//  SetConcepts.m
//  Collections
//
//  Created by Kanwar Zorawar Singh Rana on 4/3/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import "SetConcepts.h"


@interface SetConcepts()
@property(nonatomic,strong) NSMutableSet* mSet;
@property(nonatomic,strong) NSSet* iSet;
@end

@implementation SetConcepts

- (void)runConcepts{
    [self addObjectsToMutableSet];
    [self checkObjectInMutableSet];
}

- (void)addObjectsToMutableSet {
    
    self.mSet = [NSMutableSet new];
    
    for (int i = 0 ; i<K_SampleSize ; i++){
        Car* car = [Car getRandomCar];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            self.testCar = car;
        });
        [self.mSet addObject:car];
    }
    
    //NSLog(@"%@", self.mSet.debugDescription);
}

- (void)checkObjectInMutableSet {
    
    NSDate* now = [NSDate date];
    if ([self.mSet containsObject:self.testCar]){
        NSLog(@"Set has test car and found in %f",[[NSDate date] timeIntervalSinceDate:now]);
    }else{
        NSLog(@"Test Car not found");
    }
    
}

@end
