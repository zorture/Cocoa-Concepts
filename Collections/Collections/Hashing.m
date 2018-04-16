//
//  Hashing.m
//  Collections
//
//  Created by Kanwar Zorawar Singh Rana on 4/16/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import "Hashing.h"

@implementation Hashing

- (void)runConcepts{
    [self checkMirrorObjectHash];
}

- (void)checkMirrorObjectHash{
    Car* car1 = [Car new];
    car1.make = @"Toyota";
    car1.model = @"Corola";
    car1.color = YELLOW;
    
    NSInteger hash1 = [car1 hash];
    
    Car* car2 = [Car new];
    car2.make = @"Toyota";
    car2.model = @"Corola";
    car2.color = YELLOW;
    
    NSInteger hash2 = [car2 hash];
    
    NSLog(@"%ld %ld",hash1,hash2);
}

@end
