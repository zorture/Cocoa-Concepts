//
//  DataModel.h
//  Concurrency
//
//  Created by Kanwar Zorawar Singh Rana on 4/10/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RaceCondition.h"

@interface DataModel : NSObject
@property(nonatomic,strong) NSNumber* xValue;
@property(nonatomic,strong) NSNumber* yValue;
@end
