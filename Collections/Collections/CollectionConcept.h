//
//  CollectionConcept.h
//  Collections
//
//  Created by Kanwar Zorawar Singh Rana on 4/3/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

#define K_SampleSize 100

@interface CollectionConcept : NSObject
@property (nonatomic, weak) Car* testCar;

- (void)runConcepts;
@end
