//
//  ViewController.m
//  tobaccno
//
//  Created by Brian Olencki on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import "TBNRootViewController.h"
#import "AFNetworking.h"
#import "TBNAchieveViewController.h"


@interface TBNRootViewController ()

@end

@implementation TBNRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 150, 150)];
    [btn setTitle: @"K L I K" forState:UIControlStateNormal];
    btn.tintColor = [UIColor blackColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    


}
-(void)click{
    
    TBNAchieveViewController *Controller  = [[TBNAchieveViewController alloc]init];
    [self presentViewController:Controller animated:YES completion:nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
