//
//  myCollectionCell.h
//  AppStore
//
//  Created by Yu Yichen on 4/25/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellDeveloper;
@property (weak, nonatomic) IBOutlet UILabel *cellPrice;


@end
