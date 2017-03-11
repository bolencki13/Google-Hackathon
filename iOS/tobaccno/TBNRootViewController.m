//
//  ViewController.m
//  tobaccno
//
//  Created by Brian Olencki on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import "TBNRootViewController.h"
#import "AFNetworking.h"


@interface TBNRootViewController ()

@end

@implementation TBNRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    
    [manager GET:@"hackathon.bolencki13.com/api/patients/info/58c442f9e1d53e766a93c97f" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)operation.response;
        }
    ];

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
