//
//  main.m
//  Collections
//
//  Created by Kanwar Zorawar Singh Rana on 4/3/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetConcepts.h"
#import "ArrayConcepts.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // Run for NSSet Concepts
        SetConcepts* setConcept = [SetConcepts new];
        [setConcept runConcepts];
        
        // Run for NSArray Concepts
        ArrayConcepts* arrayConcept = [ArrayConcepts new];
        [arrayConcept runConcepts];
        
    }
    return 0;
}
