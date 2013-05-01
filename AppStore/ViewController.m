//
//  ViewController.m
//  AppStore
//
//  Created by Yu Yichen on 4/25/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize totalData;
@synthesize totalData5;
@synthesize totalData4;
@synthesize totalData3;
@synthesize totalData2;
@synthesize totalData1;

@synthesize filteredData;
@synthesize filteredData5;
@synthesize filteredData4;
@synthesize filteredData3;
@synthesize filteredData2;
@synthesize filteredData1;
@synthesize isFiltered;
@synthesize cacheImage;
@synthesize cacheSearch;
@synthesize searchString;
@synthesize searchWord;
@synthesize mySearchBar;
@synthesize myCollectionView;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Application View";
	// Do any additional setup after loading the view, typically from a nib.
    
    self.mySearchBar.delegate=self;
    self.myCollectionView.delegate=self;
    self.myCollectionView.dataSource=self;
    
    
    cacheImage=[[NSCache alloc]init];
    cacheSearch=[[NSCache alloc]init];
    [self downloadFeed];
   
    
}

- (void) downloadFeed
{
    

    // The search query term in "apple"
    NSURL *url=[NSURL URLWithString:@"https://itunes.apple.com/search?term=apple&country=us&entity=software"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        
        // Request the data from URL on new thread
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // Get back on the main thread to update the UI
        dispatch_async(dispatch_get_main_queue(),^{
            
            // Parse the returned JSON into NSDictionary
            NSError *error = nil;
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            // Log out the dictionary for debugging purposes
            NSLog(@"Json as NSDictionary: %@",results);
                        
            self.totalData=[NSMutableArray arrayWithArray:[results objectForKey:@"results"]];
            self.totalData5=[[NSMutableArray alloc]init];
            self.totalData4=[[NSMutableArray alloc]init];
            self.totalData3=[[NSMutableArray alloc]init];
            self.totalData2=[[NSMutableArray alloc]init];
            self.totalData1=[[NSMutableArray alloc]init];
            
            for (int i=0;i<totalData.count;i++)
            {
                if( [[NSString stringWithFormat:@"%@",[totalData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"4.5"] ||[[NSString stringWithFormat:@"%@",[totalData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"5"])
                   [totalData5 addObject:[totalData objectAtIndex:i]];
                else if( [[NSString stringWithFormat:@"%@",[totalData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"3.5"] ||[[NSString stringWithFormat:@"%@",[totalData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"4"])
                   [totalData4 addObject:[totalData objectAtIndex:i]];
                else if( [[NSString stringWithFormat:@"%@",[totalData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"2.5"] ||[[NSString stringWithFormat:@"%@",[totalData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"3"])
                    [totalData3 addObject:[totalData objectAtIndex:i]];
                else if( [[NSString stringWithFormat:@"%@",[totalData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"1.5"] ||[[NSString stringWithFormat:@"%@",[totalData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"2"])
                    [totalData2 addObject:[totalData objectAtIndex:i]];
                else 
                    [totalData1 addObject:[totalData objectAtIndex:i]];
            }
            [self.myCollectionView reloadData];
        });
    });
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{  
   if (searchText.length==0)
       {isFiltered=NO;
       [self.myCollectionView reloadData];}
    else
    { isFiltered=YES;
        self.searchString=[NSString stringWithFormat:@"%@%@%@",@"https://itunes.apple.com/search?term=",searchText,@"&country=us&entity=software"];
        self.searchWord=searchText;
        
        
        if( [cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->five"]]!=nil&& [cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->four"]]!=nil&&
           [cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->three"]]!=nil&&
           [cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->two"]]!=nil&&
           [cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->one"]]!=nil)
        {self.filteredData5=[[NSMutableArray alloc]init];
        self.filteredData4=[[NSMutableArray alloc]init];
        self.filteredData3=[[NSMutableArray alloc]init];
        self.filteredData2=[[NSMutableArray alloc]init];
        self.filteredData1=[[NSMutableArray alloc]init];
        filteredData5=[cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->five"]];
        filteredData4=[cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->four"]];
        filteredData3=[cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->three"]];
        filteredData2=[cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->two"]];
        filteredData1=[cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->one"]];
            [self.myCollectionView reloadData];}
    }
    
    
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if( [cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->five"]]==nil|| [cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->four"]]==nil||
        [cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->three"]]==nil||
        [cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->two"]]==nil||
        [cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->one"]]==nil)
    {
    
        [cacheSearch removeObjectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->five"]];
        [cacheSearch removeObjectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->four"]];
        [cacheSearch removeObjectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->three"]];
        [cacheSearch removeObjectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->two"]];
        [cacheSearch removeObjectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->one"]];
        
        
        
        filteredData=[[NSMutableArray alloc]init];
    
        
        NSURL *url=[NSURL URLWithString:self.searchString];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            // Request the data from URL on new thread
            NSData *data = [NSData dataWithContentsOfURL:url];
            
            // Get back on the main thread to update the UI
            dispatch_async(dispatch_get_main_queue(),^{
                
                // Parse the returned JSON into NSDictionary
                NSError *error = nil;
                NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                
                // Log out the dictionary for debugging purposes
                NSLog(@"Json as NSDictionary: %@",results);
                
                
                
                self.filteredData=[NSMutableArray arrayWithArray:[results objectForKey:@"results"]];
                self.filteredData5=[[NSMutableArray alloc]init];
                self.filteredData4=[[NSMutableArray alloc]init];
                self.filteredData3=[[NSMutableArray alloc]init];
                self.filteredData2=[[NSMutableArray alloc]init];
                self.filteredData1=[[NSMutableArray alloc]init];
                
                for (int i=0;i<filteredData.count;i++)
                {
                    if( [[NSString stringWithFormat:@"%@",[filteredData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"4.5"] ||[[NSString stringWithFormat:@"%@",[filteredData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"5"])
                        [filteredData5 addObject:[filteredData objectAtIndex:i]];
                    else if( [[NSString stringWithFormat:@"%@",[filteredData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"3.5"] ||[[NSString stringWithFormat:@"%@",[filteredData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"4"])
                        [filteredData4 addObject:[filteredData objectAtIndex:i]];
                    else if( [[NSString stringWithFormat:@"%@",[filteredData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"2.5"] ||[[NSString stringWithFormat:@"%@",[filteredData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"3"])
                        [filteredData3 addObject:[filteredData objectAtIndex:i]];
                    else if( [[NSString stringWithFormat:@"%@",[filteredData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"1.5"] ||[[NSString stringWithFormat:@"%@",[filteredData objectAtIndex:i][@"averageUserRating"]] isEqualToString:@"2"])
                        [filteredData2 addObject:[filteredData objectAtIndex:i]];
                    else
                        [filteredData1 addObject:[filteredData objectAtIndex:i]];
                }
                [cacheSearch setObject:filteredData5 forKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->five"]];
                 [cacheSearch setObject:filteredData4 forKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->four"]];
                 [cacheSearch setObject:filteredData3 forKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->three"]];
                 [cacheSearch setObject:filteredData2 forKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->two"]];
                 [cacheSearch setObject:filteredData1 forKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->one"]];
                
                [self.myCollectionView reloadData];
            });
        });
    }
    else
    {
        self.filteredData5=[[NSMutableArray alloc]init];
        self.filteredData4=[[NSMutableArray alloc]init];
        self.filteredData3=[[NSMutableArray alloc]init];
        self.filteredData2=[[NSMutableArray alloc]init];
        self.filteredData1=[[NSMutableArray alloc]init];
        filteredData5=[cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->five"]];
        filteredData4=[cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->four"]];
        filteredData3=[cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->three"]];
        filteredData2=[cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->two"]];
        filteredData1=[cacheSearch objectForKey:[NSString stringWithFormat:@"%@%@",self.searchWord,@"->one"]];
        [self.myCollectionView reloadData];
    }
    
    [self.mySearchBar resignFirstResponder];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(!self.isFiltered)
    {
    if (section==0&&self.totalData5.count<3)
        return self.totalData5.count;
    else if (section==1&&self.totalData4.count<3)
        return self.totalData4.count;
    else if (section==2&&self.totalData3.count<3)
        return self.totalData3.count;
    else if (section==3&&self.totalData2.count<3)
        return self.totalData2.count;
    else if (section==4&&self.totalData1.count<3)
        return self.totalData1.count;
    else
        return 3;
    }
    else
    {
        if (section==0&&self.filteredData5.count<9)
            return self.filteredData5.count;
        else if (section==1&&self.filteredData4.count<9)
            return self.filteredData4.count;
        else if (section==2&&self.filteredData3.count<9)
            return self.filteredData3.count;
        else if (section==3&&self.filteredData2.count<9)
            return self.filteredData2.count;
        else if (section==4&&self.filteredData1.count<9)
            return self.filteredData1.count;
        else
            return 9;
    }
}

-(myCollectionCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    myCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if(isFiltered)
    {    NSMutableArray *dataChosen=[[NSMutableArray alloc]init];
        if(indexPath.section==0)
            dataChosen=filteredData5;
        else if(indexPath.section==1)
            dataChosen=filteredData4;
        else if(indexPath.section==2)
            dataChosen=filteredData3;
        else if(indexPath.section==3)
            dataChosen=filteredData2;
        else if(indexPath.section==4)
            dataChosen=filteredData1;
        
          cell.cellLabel.text=[dataChosen objectAtIndex:indexPath.row][@"trackName"];
          
          
          if ([cacheImage objectForKey:[dataChosen objectAtIndex:indexPath.row][@"trackId"]]==nil)
          { NSURL *imageURL=[NSURL URLWithString:[dataChosen objectAtIndex:indexPath.row][@"artworkUrl60"]];
                NSData *imageData=[[NSData alloc]initWithContentsOfURL:imageURL];
              UIImage *image=[[UIImage alloc]initWithData:imageData];
                [cacheImage setObject:image forKey:[dataChosen objectAtIndex:indexPath.row][@"trackId"]];
          }
               
            
          
        cell.cellImageView.image=[cacheImage objectForKey:[dataChosen objectAtIndex:indexPath.row][@"trackId"]];
               
        cell.cellDeveloper.text=[dataChosen objectAtIndex:indexPath.row][@"sellerName"];
        cell.cellPrice.text=[dataChosen objectAtIndex:indexPath.row][@"formattedPrice"];
      }
    else
    {  NSMutableArray *dataChosen=[[NSMutableArray alloc]init];
    if(indexPath.section==0)
        dataChosen=totalData5;
    else if(indexPath.section==1)
        dataChosen=totalData4;
    else if(indexPath.section==2)
        dataChosen=totalData3;
    else if(indexPath.section==3)
        dataChosen=totalData2;
    else if(indexPath.section==4)
        dataChosen=totalData1;
    
    cell.cellLabel.text=[dataChosen objectAtIndex:indexPath.row][@"trackName"];
    
    
    if ([cacheImage objectForKey:[dataChosen objectAtIndex:indexPath.row][@"trackId"]]==nil)
    { NSURL *imageURL=[NSURL URLWithString:[dataChosen objectAtIndex:indexPath.row][@"artworkUrl60"]];
        NSData *imageData=[[NSData alloc]initWithContentsOfURL:imageURL];
        UIImage *image=[[UIImage alloc]initWithData:imageData];
        [cacheImage setObject:image forKey:[dataChosen objectAtIndex:indexPath.row][@"trackId"]];
    }
    
    
    
    cell.cellImageView.image=[cacheImage objectForKey:[dataChosen objectAtIndex:indexPath.row][@"trackId"]];
    
    cell.cellDeveloper.text=[dataChosen objectAtIndex:indexPath.row][@"sellerName"];
    cell.cellPrice.text=[dataChosen objectAtIndex:indexPath.row][@"formattedPrice"];
    }
    return cell;
    
}

-(headerView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    headerView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    if (indexPath.section==0)
        header.headerLabel.text=@"Five Stars";
    else if(indexPath.section==1)
        header.headerLabel.text=@"Four Stars";
    else if(indexPath.section==2)
        header.headerLabel.text=@"Three Stars";
    else if(indexPath.section==3)
        header.headerLabel.text=@"Two Stars";
    else if(indexPath.section==4)
        header.headerLabel.text=@"Terrible Applications";
    
    return header;
    ;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueToShowApp"]){
        
        NSIndexPath *indexPath=[self.myCollectionView indexPathForCell:sender];
        NSDictionary *selectApp=[[NSDictionary alloc]init];
       if(self.isFiltered)
       {
        if (indexPath.section==0)
        selectApp=[self.filteredData5 objectAtIndex:indexPath.row];
        else if (indexPath.section==1)
        selectApp=[self.filteredData4 objectAtIndex:indexPath.row];
        else if (indexPath.section==2)
        selectApp=[self.filteredData3 objectAtIndex:indexPath.row];
        else if (indexPath.section==3)
        selectApp=[self.filteredData2 objectAtIndex:indexPath.row];
        else
        selectApp=[self.filteredData1 objectAtIndex:indexPath.row];
       }
        else
        {
            if (indexPath.section==0)
                selectApp=[self.totalData5 objectAtIndex:indexPath.row];
            else if (indexPath.section==1)
                selectApp=[self.totalData4 objectAtIndex:indexPath.row];
            else if (indexPath.section==2)
                selectApp=[self.totalData3 objectAtIndex:indexPath.row];
            else if (indexPath.section==3)
                selectApp=[self.totalData2 objectAtIndex:indexPath.row];
            else
                selectApp=[self.totalData1 objectAtIndex:indexPath.row];
        }
        [segue.destinationViewController setCurrentApp:selectApp];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tapToHideKeyboard:(UILongPressGestureRecognizer *)sender {
    
    [self.mySearchBar resignFirstResponder];
}
@end
