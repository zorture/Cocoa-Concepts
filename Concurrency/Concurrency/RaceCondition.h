//
//  RaceCondition.h
//  Concurrency
//
//  Created by Kanwar Zorawar Singh Rana on 4/11/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    Sync = 0,
    Lock,
    Mux,
    NoFix
}RaceFix;

typedef enum{
    Serial = 0,
    Concurrent
}QType;

@interface RaceCondition : NSObject
-(instancetype)initWitRaceStatus:(RaceFix)status;
-(void)simulateRaceCondition;

@end
