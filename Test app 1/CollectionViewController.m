//
//  CollectionViewController.m
//  Test app 1
//
//  Created by Mobile Developer on 3/9/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellnew"];
    array = [[NSMutableArray alloc] initWithObjects:@"test1", @"test2", @"test3", nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark CollectionView Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return array.count;
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
//{
//    UICollectionReusableView *reusableview = nil;
//    
//    if (kind == UICollectionElementKindSectionHeader) {
//        CollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
//        
//        NSString *temp =[NSString stringWithFormat:@" Frequency (%@)",[array objectAtIndex:indexPath.row]];
//        headerView.label.text = temp;
//        
////        reusableview = headerView;
//    }
//    
//    return reusableview;
//}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(150, 150);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView setShowsHorizontalScrollIndicator:NO];
    [collectionView setShowsVerticalScrollIndicator:NO];
    
    
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellnew" forIndexPath:indexPath];
    
//    [cell.cellButton addTarget:self action:@selector(cellButtonTapped:)
//              forControlEvents:UIControlEventTouchUpInside];
    
    
    NSLog(@"index %ld",(long)indexPath.row);
    
    cell.lbl.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:indexPath.row]];
    cell.img.image = [UIImage imageNamed: @"test1.png"];
    NSURL *url = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png"];
    
    [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, NSData *data) {
        if (succeeded) {
            cell.img.image = [[UIImage alloc] initWithData:data];
        }
    }];
//    [cell.img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isTapped:)]];
    
    return cell;
    
}
- (void)isTapped:(UITapGestureRecognizer*)tap
{
    NSLog(@"%@", tap.view);
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, NSData *data))completionBlock
{
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:url
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    if (!error) {
                        completionBlock(YES, data);
                    } else {
                        completionBlock(NO, nil);
                    }
                }] resume];
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        if (!error) {
//            completionBlock(YES, data);
//        } else {
//            completionBlock(NO, nil);
//        }
//    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showNextPage:(id)sender {
    TableViewController *back=[[TableViewController alloc] initWithNibName:nil bundle:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:back animated:YES completion:nil];
        
    });
}
@end
