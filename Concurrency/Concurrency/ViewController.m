//
//  ViewController.m
//  Concurrency
//
//  Created by Kanwar Zorawar Singh Rana on 4/10/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"
#import "RaceCondition.h"

#define Sample_Size_Large 10000
#define Sample_Size_Small 5
#define Sample_Size_Medium 100

@interface ViewController ()
@property (nonatomic,strong) NSString* loopName;
@property (nonatomic,strong) NSMutableSet* dmSet;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dmSet = [NSMutableSet new];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    //[self mainQ];
    //[self concurrentQ];
    //[self raceCondition];
    //[self newThread];
    
    
    RaceCondition* raceCondition = [[RaceCondition alloc] initWitRaceStatus:Lock];
    [raceCondition simulateRaceCondition];

}

-(void)mainQ{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i<Sample_Size_Small; i++){
            NSLog(@"1 loop %d", i);
            sleep(1);
        }
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i<Sample_Size_Small; i++){
            NSLog(@"2 loop %d", i);
            sleep(1);
        }
    });
}


-(void)concurrentQ{
    dispatch_queue_t bg = dispatch_queue_create("com.th.ab", DISPATCH_QUEUE_CONCURRENT);
    
    __weak typeof(self) weakSelf = self;
    void (^runPrintLoop)(void) = ^{
        for (int i = 0; i<Sample_Size_Large; i++){
            NSLog(@"%@ loop %d",weakSelf.loopName, i);
            //sleep(1);
        }
    };
    
    dispatch_async(bg, ^{
        for (int i = 0; i<Sample_Size_Large; i++){
            NSLog(@"First loop %d", i);
            //sleep(1);
        }
        
    });
    
    dispatch_async(bg, ^{
        for (int i = 0; i<Sample_Size_Large; i++){
            NSLog(@"Second loop %d", i);
            //sleep(1);
        }
        
    });
    
    
    self.loopName = @"Third";
    dispatch_async(bg, runPrintLoop);
    
}

void (^runPrintLoop)(void) = ^{
    for (int i = 0; i<Sample_Size_Large; i++){
        NSLog(@" loop %d", i);
    }
};



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)newThread{
    [NSThread detachNewThreadWithBlock:runPrintLoop];
    [NSThread detachNewThreadWithBlock:runPrintLoop];
    [NSThread detachNewThreadWithBlock:runPrintLoop];
}


@end
