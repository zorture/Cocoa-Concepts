//
//  Car.h
//  Collections
//
//  Created by Kanwar Zorawar Singh Rana on 4/3/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    RED,
    BLACK,
    WHITE,
    BLUE,
    YELLOW
} CarColor;

@interface Car : NSObject
@property(nonatomic,strong) NSString* make;
@property(nonatomic,strong) NSString* model;
@property(nonatomic,assign) CarColor color;

+ (Car*)getRandomCar;
@end
