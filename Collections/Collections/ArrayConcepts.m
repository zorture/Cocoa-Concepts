//
//  ArrayConcepts.m
//  Collections
//
//  Created by Kanwar Zorawar Singh Rana on 4/3/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import "ArrayConcepts.h"
#import "Car.h"

@interface ArrayConcepts()
@property(nonatomic,strong) NSMutableArray* mArray;
@property(nonatomic,strong) NSArray* iArray;
@end

@implementation ArrayConcepts

- (void)runConcepts{
    [self addObjectsToMutableArray];
    [self checkObjectInMutableArray];
}

- (void)addObjectsToMutableArray {
    
    self.mArray = [NSMutableArray new];
    
    for (int i = 0 ; i<K_SampleSize ; i++){
        Car* car = [Car getRandomCar];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            self.testCar = car;
        });
        [self.mArray addObject:car];
    }
    
    //NSLog(@"%@", self.mArray.debugDescription);
}

- (void)checkObjectInMutableArray {
    
    NSDate* now = [NSDate date];
    if ([self.mArray containsObject:self.testCar]){
        NSLog(@"Array has test car and found in %f",[[NSDate date] timeIntervalSinceDate:now]);
    }else{
        NSLog(@"Test Car not found");
    }
}

@end
