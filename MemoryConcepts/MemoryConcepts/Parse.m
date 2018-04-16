//
//  Parse.m
//  Ref
//
//  Created by Rana, Kanwar Zorawar Singh on 4/4/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import "Parse.h"
#import "DataModel.h"


@implementation Parse

- (DataModel*)getRandomDataModel{
    int random = arc4random_uniform(3);
    DataModel* dm = [DataModel new];
    switch (random) {
            case 0:
                dm.name = @"Mike";
                dm.age = @"22";
            break;
            case 1:
            dm.name = @"Yemn";
            dm.age = @"21";
            break;
            case 2:
            dm.name = @"Done";
            dm.age = @"25";
            break;
        default:
            break;
    }

    return [dm autorelease];
}

- (NSArray*)getAutoReleasedData {
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for (int i = 0; i< 10; i++) {
        DataModel* dm = [self getRandomDataModel];
        [arr addObject:dm];
    }
    return [arr autorelease];
}

- (NSArray*)getAutoReleasedPoolData{
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    for (int i = 0; i< 10; i++) {
        DataModel* dm = [self getRandomDataModel];
        [arr addObject:dm];
    }
    [pool drain];
    
    return [arr autorelease];
}

@end









