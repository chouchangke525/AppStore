//
//  TableCell.h
//  AppStore
//
//  Created by Yu Yichen on 4/28/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *developerName;

@end
