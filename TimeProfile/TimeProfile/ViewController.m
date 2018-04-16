//
//  ViewController.m
//  TimeProfile
//
//  Created by Kanwar Zorawar Singh Rana on 4/9/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import "ViewController.h"

typedef enum {
    Main,
    Background
}ThreadType;

#define SampleSize 10000

@interface ViewController ()

@property(nonatomic,assign) ThreadType threadType;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.threadType = Main;
    self.threadType == Main ? [self loopInMainThread] : [self loopInBackgroundThread];
}

-(void)loopInMainThread{
    dispatch_queue_t main = dispatch_get_main_queue();
    [self loopOnQueue:main];
}

-(void)loopInBackgroundThread{
    dispatch_queue_t backgroundQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    [self loopOnQueue:backgroundQ];
}

- (void)loopOnQueue:(dispatch_queue_t)queue{
    dispatch_async(queue, ^{
        for (int i=0;i<SampleSize;i++){
            for (int j=0;j<SampleSize;j++){
                for (int k=0;k<SampleSize;k++){
                    Logger* logger = [Logger new];
                    [logger printOutput:[NSString stringWithFormat:@"%d %d %d",i,j,k]];
                }
            }
        }
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation Logger
- (void)printOutput:(NSString*)output {
    NSLog(@"%@", output);
}
@end

