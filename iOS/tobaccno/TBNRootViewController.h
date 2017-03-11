//
//  ViewController.h
//  tobaccno
//
//  Created by Brian Olencki on 3/10/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import "TBH-Prefix.pch"

@interface TBNRootViewController : UIViewController

/// Label which shows amount of battery remaining
@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;

/// Label which shows amount of liquid left
@property (weak, nonatomic) IBOutlet UILabel *liquidLabel;

/// Label which shows amount of time pulled
@property (weak, nonatomic) IBOutlet UILabel *pullTimeLabel;

/// Label which shows connection
@property (weak, nonatomic) IBOutlet UILabel *connectionLabel;

/// Pair button with device
@property (weak, nonatomic) IBOutlet UIButton *pairButton;

/// Pair action
- (IBAction)pairAction:(id)sender;

@end

