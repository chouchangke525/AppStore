//
//  DetailViewController.m
//  AppStore
//
//  Created by Yu Yichen on 4/27/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "Application.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize appDetail;
@synthesize appLabel;
@synthesize currentApp;
@synthesize context;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Detail View";
    
	// Do any additional setup after loading the view.
    appLabel.text=self.currentApp[@"trackName"];
    appDetail.text=self.currentApp[@"description"];
    
    AppDelegate *appdelegate=[[UIApplication sharedApplication]delegate];
    context=[appdelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)buyButton:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [self.currentApp objectForKey:@"trackViewUrl"]]];
}

- (IBAction)favoriteButton:(UIButton *)sender {
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Application" inManagedObjectContext:context];
    NSManagedObject *newApplication=[[NSManagedObject alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
    [newApplication setValue:self.currentApp[@"trackName"] forKey:@"name"];
    [newApplication setValue:self.currentApp[@"sellerName"] forKey:@"developer"];
    
    NSError *error;
    [context save:&error];
}
@end
