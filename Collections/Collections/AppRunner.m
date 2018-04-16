//
//  AppRunner.m
//  Collections
//
//  Created by Kanwar Zorawar Singh Rana on 4/16/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import "AppRunner.h"

static AppRunner* sharedAppRunner;
@implementation AppRunner

+ (void)runAppRunner {
    
    sharedAppRunner = [[AppRunner alloc] init];
    [sharedAppRunner startSamples];
    
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)startSamples{
    // Run for NSSet Concepts
    SetConcepts* setConcept = [SetConcepts new];
    [setConcept runConcepts];
    
    // Run for NSArray Concepts
    ArrayConcepts* arrayConcept = [ArrayConcepts new];
    [arrayConcept runConcepts];
    
    // Run for Hashing Object Concepts
    Hashing* hashingConcept = [Hashing new];
    [hashingConcept runConcepts];
    
    
    
}
@end
