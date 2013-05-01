//
//  DetailViewController.h
//  AppStore
//
//  Created by Yu Yichen on 4/27/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "GAITrackedViewController.h"

@interface DetailViewController : GAITrackedViewController

@property NSDictionary *currentApp;
@property (weak, nonatomic) IBOutlet UILabel *appLabel;
@property (weak, nonatomic) IBOutlet UITextView *appDetail;
@property  NSManagedObjectContext *context;
- (IBAction)buyButton:(UIButton *)sender;
- (IBAction)favoriteButton:(UIButton *)sender;

@end
