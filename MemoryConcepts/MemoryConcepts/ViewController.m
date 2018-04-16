//
//  ViewController.m
//  Ref
//
//  Created by Rana, Kanwar Zorawar Singh on 4/4/18.
//  Copyright © 2018 Kanwar Zorawar Singh Rana. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"

typedef enum {
  AutoRelease,
  AutoReleasePool
}ReleaseType;

typedef enum {
    Main,
    Other
}ThreadType;

@interface ViewController ()

@property (nonatomic, retain) NSArray* dataAr;
@property (nonatomic,assign) ReleaseType releaseType;
@property (nonatomic,assign) ThreadType threadType;
@property (nonatomic,assign) NSTimeInterval timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.releaseType = AutoReleasePool;
    self.threadType = Main;
    self.timer = 5;
    
    /* ivar
    arr = [[NSMutableArray alloc] init];
    [arr addObject:@"1"];
    [arr addObject:@"10"];
    NSLog(@"%@", arr.debugDescription);
    NSUInteger a = [arr retainCount];
    NSLog(@"%lu", a);
     */
}

- (void)viewDidAppear:(BOOL)animated{
    self.threadType == Main ? [self loadDataInMainThread] : [self loadDataInSeperateThread];
}

- (void)loadData{
    
    Parse* pr = [Parse new];
    if (self.releaseType == AutoRelease)
        self.dataAr = [pr getAutoReleasedData];
    else{
        self.dataAr = [pr getAutoReleasedPoolData];
    }
    [self printMemoryFootPrint];
}

- (void)releaseManually{
    
    DataModel* dm = self.dataAr.firstObject;
    [self.dataAr release];
    NSUInteger b = [dm retainCount];
    NSLog(@"DataModel: %lu",b);

}

- (void)loadDataInMainThread{
    [self loadData];
}

- (void)loadDataInSeperateThread{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self loadData];
        });
    });
}

- (void)printMemoryFootPrint{
    
    NSUInteger a = [self.dataAr retainCount];
    DataModel* dm = self.dataAr.firstObject;
    NSUInteger b = [dm retainCount];
    NSLog(@"Array: %lu DataModel: %lu",(unsigned long)a,b);
    [self performSelector:@selector(printMemoryFootPrint) withObject:nil afterDelay:self.timer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
