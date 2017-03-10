//
//  TableViewController.h
//  Test app 1
//
//  Created by Mobile Developer on 3/9/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"

@interface TableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *tableData, *tableData2;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITableView *tableview2;


@end
