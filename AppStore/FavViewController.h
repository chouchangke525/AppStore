//
//  FavViewController.h
//  AppStore
//
//  Created by Yu Yichen on 4/28/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface FavViewController : GAITrackedViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *favView;
@property  NSManagedObjectContext *context;
@property NSArray *data;

@end
