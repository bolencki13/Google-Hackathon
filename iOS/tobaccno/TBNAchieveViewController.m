//
//  TBNAchieveViewController.m
//  tobaccno
//
//  Created by Preston Perriott on 3/11/17.
//  Copyright © 2017 Brian Olencki. All rights reserved.
//

#import "TBNAchieveViewController.h"

@interface TBNAchieveViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    UILabel *AchievementCellLabel;
    UICollectionView *CollectionView;
    UIImage *AchievementImage;
    UIImageView *AchieveImageView;
    NSMutableArray *DayArray;
}

@end

@implementation TBNAchieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    static dispatch_once_t p = 0;
    
    dispatch_once(&p, ^{
        
        DayArray = [[NSMutableArray alloc]init];
        
        for (int i = 1; i < 31; i++) {
            [DayArray addObject:[NSString stringWithFormat:@"Day %d", i]];
        }
    });

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // CollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    CollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    CollectionView.translatesAutoresizingMaskIntoConstraints = false;
    CollectionView.backgroundColor = [[UIColor blueColor]initWithHue:.56 saturation:.60 brightness:1 alpha:.85];
    //CollectionView.backgroundView = _StrainsImageView;
    //CollectionView.collectionViewLayout = layout;
    
    
    [CollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    CollectionView.delegate = self;
    CollectionView.dataSource = self;
    
    [self.view addSubview:CollectionView];
    
    [CollectionView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active =TRUE;
    [CollectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = TRUE;
    //[CollectionView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:50].active = TRUE;
    [CollectionView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:10].active = TRUE;
    [CollectionView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = TRUE;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //something count
    return [DayArray count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed: 116.0/ 255.0 green:182.0/255.0 blue:161/255.0 alpha:.72];
    cell.layer.cornerRadius = 10;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = .55;
    
    
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height * .87)];
    bgView.layer.cornerRadius = 5;
    bgView.layer.borderColor = [UIColor blackColor].CGColor;
    bgView.layer.borderWidth = 1.5;
    bgView.alpha = .75;
    bgView.layer.masksToBounds = TRUE;
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    
    AchievementCellLabel = [[UILabel alloc]init];
    AchievementCellLabel.textColor = [UIColor yellowColor];
    AchievementCellLabel.translatesAutoresizingMaskIntoConstraints = false;
    AchievementCellLabel.layer.masksToBounds = YES;
    AchievementCellLabel.text = [NSString stringWithFormat:@"%@",[DayArray objectAtIndex:indexPath.row]];
    
    
    
    AchievementCellLabel.font = [UIFont fontWithName:@"Helvetica" size:[UIFont systemFontSize]];
    AchievementCellLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    AchievementCellLabel.textAlignment = NSTextAlignmentLeft;
    AchievementCellLabel.numberOfLines = 0;
    
    
    [cell.contentView addSubview:AchievementCellLabel];
    
    
    [AchievementCellLabel.bottomAnchor constraintEqualToAnchor:cell.bottomAnchor constant:-2].active = TRUE;
    [AchievementCellLabel.widthAnchor constraintEqualToAnchor:cell.widthAnchor].active =TRUE;
    [AchievementCellLabel.heightAnchor constraintEqualToConstant:12].active = TRUE;
    [AchievementCellLabel.leftAnchor constraintEqualToAnchor:cell.leftAnchor constant:10].active = true;
    
    
    UIImage *centerImage = [UIImage imageNamed:@"logo_circle.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:centerImage];
    //imageView.frame = CGRectMake(CGRectGetWidth(cell.frame)/2, CGRectGetHeight(cell.frame)/2, 50, 50);
    imageView.frame = cell.bounds;
    imageView.bounds = CGRectInset(cell.frame, 30, 30);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MoreInfo)];
    
    [singleTap setNumberOfTapsRequired:1];
    [imageView addGestureRecognizer:singleTap];
    
    [cell.contentView addSubview:imageView];

    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   // return CGSizeMake(CGRectGetWidth(self.view.frame) * .90, 90);
    return CGSizeMake(CGRectGetWidth(self.view.frame)* .45, CGRectGetWidth(self.view.frame) * .45);
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(self.navigationController.navigationBar.frame.origin.x + 70, 20, 5, 20);

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    _Floating = [[VLAFloatingViewController alloc]initWithIndex:indexPath];
    [self presentViewController:_Floating animated:YES completion:nil];
}
-(void)MoreInfo{
    
}
@end
