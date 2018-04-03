//
//  Car.m
//  Collections
//
//  Created by Kanwar Zorawar Singh Rana on 4/3/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import "Car.h"

@implementation Car

+ (Car*)getRandomCar {
    int random = arc4random_uniform(5);
    Car* car = [Car new];
    switch (random) {
        case 0:
            car.make = @"Toyota";
            car.model = @"Corola";
            car.color = YELLOW;
            break;
        case 1:
            car.make = @"Jeep";
            car.model = @"Grand Charokee";
            car.color = BLACK;
            break;
        case 2:
            car.make = @"Honda";
            car.model = @"CRV";
            car.color = WHITE;
            break;
        case 3:
            car.make = @"BMW";
            car.model = @"S700";
            car.color = BLUE;
            break;
        case 4:
            car.make = @"AUDI";
            car.model = @"TT";
            car.color = BLACK;
            break;
            
        default:
            break;
    }
    
    return car;
}

@end
