//
//  ViewController.h
//  AppStore
//
//  Created by Yu Yichen on 4/25/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myCollectionCell.h"
#import "headerView.h"
#import "DetailViewController.h"
#import "GAITrackedViewController.h"

@interface ViewController : GAITrackedViewController<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate,NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
- (IBAction)tapToHideKeyboard:(UILongPressGestureRecognizer *)sender;
@property NSCache *cacheImage;
@property NSCache *cacheSearch;
@property NSMutableArray *totalData;
@property NSMutableArray *totalData5;
@property NSMutableArray *totalData4;
@property NSMutableArray *totalData3;
@property NSMutableArray *totalData2;
@property NSMutableArray *totalData1;
@property NSMutableArray *filteredData;
@property NSMutableArray *filteredData5;
@property NSMutableArray *filteredData4;
@property NSMutableArray *filteredData3;
@property NSMutableArray *filteredData2;
@property NSMutableArray *filteredData1;
@property Boolean isFiltered;
@property NSString *searchString;
@property NSString *searchWord;

@end
