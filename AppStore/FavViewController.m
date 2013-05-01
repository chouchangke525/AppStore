//
//  FavViewController.m
//  AppStore
//
//  Created by Yu Yichen on 4/28/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import "FavViewController.h"
#import "AppDelegate.h"
#import "Application.h"
#import "TableCell.h"




@interface FavViewController ()

@end

@implementation FavViewController

@synthesize data;
@synthesize favView;
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
	// Do any additional setup after loading the view.
    self.trackedViewName = @"Favorite View";
    
    self.favView.delegate=self;
    self.favView.dataSource=self;
    
    AppDelegate *appdelegate=[[UIApplication sharedApplication]delegate];
    context=[appdelegate managedObjectContext];
    
    
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Application" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entity];
    

    
    NSError *error;
    self.data=[context executeFetchRequest:request error:&error];
    [self.favView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (TableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    NSLog(@"Asking for cell: %d",indexPath.row);
    cell.appName.text=[[self.data objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.developerName.text=[[self.data objectAtIndex:indexPath.row] valueForKey:@"developer"];

    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
