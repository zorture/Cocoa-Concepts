//
//  RaceCondition.m
//  Concurrency
//
//  Created by Kanwar Zorawar Singh Rana on 4/11/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import "RaceCondition.h"
#import "DataModel.h"
#import <pthread.h>

#define Sample_Size_Large 100000

pthread_mutex_t mutex;
int counter = 0;

@interface RaceCondition()
@property (nonatomic,strong) NSMutableSet* dmSet;
@property (nonatomic,assign) RaceFix raceFix;
@property (nonatomic,strong) NSLock* dataLock;
@property (nonatomic,strong) NSDate* startDate;
@end

@implementation RaceCondition

-(instancetype)initWitRaceStatus:(RaceFix)status{
    self = [super init];
    if (self) {
        self.dmSet = [NSMutableSet set];
        self.raceFix = status;
        self.dataLock = [NSLock new];
        pthread_mutex_init(&mutex, NULL);
    }
    return self;
}

-(void)simulateRaceCondition{
    
    [self createDataModel];
    //[self createRaceCondition:NoFix WithQ:Concurrent];
    //[self runAllFixes];
    for (int i = Sync; i<= NoFix; i++){
        [self readData:i];
    }
    
//    dispatch_queue_t concQ = dispatch_queue_create("com.conc.read", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(concQ, ^{
//        for (int i = Sync; i<= NoFix; i++){
//            [self readData:i];
//        }
//    });
}

-(void)readData:(RaceFix)raceFix{
    
    NSDate* now = [NSDate date];
    NSString* fix;
    for (DataModel* dataModel in self.dmSet){
        
        switch (raceFix) {
            case Sync:
                fix = @"Sync";
                @synchronized(dataModel){
                    [self updateDataModel:dataModel];
                }
                break;
            case Lock:
                fix = @"Lock";
                [self.dataLock lock];
                [self updateDataModel:dataModel];
                [self.dataLock unlock];
                break;
            case Mux:
                fix = @"Mux";
                pthread_mutex_lock(&mutex);
                [self updateDataModel:dataModel];
                pthread_mutex_unlock(&mutex);
                break;
            default:
                fix = @"No Fix";
                [self updateDataModel:dataModel];
                break;
        }
        
    }
    
    NSLog(@"Read Time Taken:: %f For Fix %@",[[NSDate date] timeIntervalSinceDate:now],fix);

}

- (void)runAllFixes{
    /*
    dispatch_queue_t concQ = dispatch_queue_create("com.conc.runAllFix", DISPATCH_QUEUE_SERIAL);

    __weak typeof(self) weakSelf = self;
    for (int i = Mux; i<= NoFix; i++){
        dispatch_sync(concQ, ^{
            [weakSelf createRaceCondition:NoFix WithQ:i];
            [weakSelf.dmSet removeAllObjects];
            [weakSelf createDataModel];
        });
    }
     */
    /*
    if (counter <= NoFix){
        [self createRaceCondition:counter WithQ:Concurrent];
    }
     */
}

-(void)createDataModel{
    dispatch_queue_t concQ = dispatch_queue_create("com.conc.createDataModel", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(concQ, ^{
        for (int i = 0; i<Sample_Size_Large; i++){
            DataModel* data = [DataModel new];
            data.xValue = [NSNumber numberWithInt:i+1];
            data.yValue = [NSNumber numberWithInt:100];
            [self.dmSet addObject:data];
        }
    });
}

-(void)createRaceCondition:(RaceFix)raceFix WithQ:(QType)qType{
     
    self.startDate = [NSDate date];
    dispatch_queue_t concQ;
    switch (qType) {
        case Serial:
             concQ = dispatch_queue_create("com.conc.reaceThread", DISPATCH_QUEUE_SERIAL);
            break;
        case Concurrent:
            concQ = dispatch_queue_create("com.conc.reaceThread", DISPATCH_QUEUE_CONCURRENT);
            break;
        default:
            break;
    }
    
    // Create the dispatch group
    dispatch_group_t serviceGroup = dispatch_group_create();
    
    __weak typeof(self) weakSelf = self;
    void (^updateDataModel)(void) = ^{
        for (DataModel* dataModel in weakSelf.dmSet){
            
            switch (raceFix) {
                case Sync:
                    @synchronized(dataModel){
                        [weakSelf updateDataModel:dataModel];
                    }
                    break;
                case Lock:
                    [self.dataLock lock];
                    [weakSelf updateDataModel:dataModel];
                    [self.dataLock unlock];
                    break;
                case Mux:
                    pthread_mutex_lock(&mutex);
                    [weakSelf updateDataModel:dataModel];
                    pthread_mutex_unlock(&mutex);
                    break;
                default:
                    [weakSelf updateDataModel:dataModel];
                    break;
            }
            
        }
        dispatch_group_leave(serviceGroup);
    };
    
    // Start the first service
    dispatch_group_enter(serviceGroup);
    dispatch_async(concQ, updateDataModel);
    
    // Start the Second service
    dispatch_group_enter(serviceGroup);
    dispatch_async(concQ, updateDataModel);
    
    // Start the Third service
    dispatch_group_enter(serviceGroup);
    dispatch_async(concQ, updateDataModel);
    
    // Start the Fourth service
    dispatch_group_enter(serviceGroup);
    dispatch_async(concQ, updateDataModel);
    
    dispatch_group_notify(serviceGroup,concQ,^{
        [self checkDataModel:raceFix];
    });
    
}

- (void)updateDataModel:(DataModel*)dataModel{
    NSNumber* newNumber = [NSNumber numberWithInt:dataModel.yValue.intValue + 100];
    dataModel.yValue = newNumber;
}

- (void)checkDataModel:(RaceFix)raceFix{
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"yValue != 500"];
    NSSet*filterSet = [self.dmSet filteredSetUsingPredicate:filter];
    if (filterSet.count>0){
        NSLog(@"Race Condition with %lu incorrect data", (unsigned long)filterSet.count);
    }else {
        NSLog(@"No Race Condition");
    }
    
    
    switch (raceFix) {
        case Sync:
            NSLog(@"Sync");
            break;
        case Lock:
            NSLog(@"Lock");
            break;
        case Mux:
            NSLog(@"Mux");
            break;
        default:
            NSLog(@"NoFix");
            break;
    }
    
    NSLog(@"Time Taken:: %f \n\n",[[NSDate date] timeIntervalSinceDate:self.startDate]);
    //counter++;
    /*
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.dmSet removeAllObjects];
        [weakSelf createDataModel];
        [weakSelf runAllFixes];
    });
     */
}


@end
