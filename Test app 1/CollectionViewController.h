//
//  CollectionViewController.h
//  Test app 1
//
//  Created by Mobile Developer on 3/9/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionReusableView.h"
#import "CollectionViewCell.h"
#import "TableViewController.h"

@interface CollectionViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate> {
    
    NSMutableArray * array;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)showNextPage:(id)sender;

@end
