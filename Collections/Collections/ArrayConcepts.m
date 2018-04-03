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
    [self iteratingObjectInMutableArray];
    [self blockEnumeration];
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
    
    NSString* str1 = @"Cocoa Collection";
    [self.mArray addObject:str1];
    NSString* str2 = @"Cocoa Collection";
    [self.mArray addObject:str2];
    
    NSLog(@"%lu", (unsigned long)self.mArray.count);
}

- (void)checkObjectInMutableArray {
    
    NSDate* now = [NSDate date];
    if ([self.mArray containsObject:self.testCar]){
        NSLog(@"Array has test car and found in %f",[[NSDate date] timeIntervalSinceDate:now]);
    }else{
        NSLog(@"Test Car not found");
    }
}

- (void)iteratingObjectInMutableArray {
    
    NSDate* now = [NSDate date];
    for (Car* car in self.mArray) {
        if([car isKindOfClass:[Car class]])
            car.color = BLACK;
    }
    NSLog(@"Array iterate finished in %f",[[NSDate date] timeIntervalSinceDate:now]);
    
}

- (void)blockEnumeration {
    
    NSDate* now = [NSDate date];
    
    __weak typeof(self) weakself = self;
    [self.mArray enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop){
        if ([obj isEqual:weakself.testCar]) {
            *stop = YES;
            NSLog(@"Array Block enumeration Found in %f",[[NSDate date] timeIntervalSinceDate:now]);
        }
    } ];
}

@end
