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
    [self iteratingObjectInMutableSet];
    [self blockEnumeration];
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
    
    // NSStrig class has compiler optimization. both str1 & str2 are same object
    NSString* str1 = @"Cocoa Collection";
    [self.mSet addObject:str1];
    NSString* str2 = @"Cocoa Collection";
    [self.mSet addObject:str2];
    
    
    NSLog(@"%lu", (unsigned long)self.mSet.count);
}

- (void)checkObjectInMutableSet {
    
    NSDate* now = [NSDate date];
    if ([self.mSet containsObject:self.testCar]){
        NSLog(@"Set has test car and found in %f",[[NSDate date] timeIntervalSinceDate:now]);
    }else{
        NSLog(@"Test Car not found");
    }
    
}

- (void)iteratingObjectInMutableSet {
    
    NSDate* now = [NSDate date];
    for (Car* car in self.mSet) {
        if([car isKindOfClass:[Car class]])
            car.color = BLACK;
    }
    NSLog(@"Set iterate finished in %f",[[NSDate date] timeIntervalSinceDate:now]);

}

- (void)blockEnumeration {
    
    NSDate* now = [NSDate date];
    
    __weak typeof(self) weakself = self;
    [self.mSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop){
        if ([obj isEqual:weakself.testCar]) {
            *stop = YES;
            NSLog(@"Set Block enumeration Found in %f",[[NSDate date] timeIntervalSinceDate:now]);
        }
    } ];
}

@end
