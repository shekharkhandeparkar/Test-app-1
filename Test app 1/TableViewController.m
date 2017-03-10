//
//  TableViewController.m
//  Test app 1
//
//  Created by Mobile Developer on 3/9/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

#import "TableViewController.h"
#import "Employee.h"
#import "EmployeeDbUtil.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [_tableview registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellnew"];
//    [_tableview2 registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellnew"];
    
    tableData = [[NSMutableArray alloc] initWithObjects:@"test1",@"test2",@"test3", nil];
    tableData2 = [[NSMutableArray alloc] initWithObjects:@"test21",@"test22",@"test23", nil];
    self.tableview.allowsMultipleSelectionDuringEditing = NO;
    // Do any additional setup after loading the view from its nib.
    
    Employee *employee = [[Employee alloc] init];
    employee.employeeID = 0;
    employee.name = @"Shekhar";
    employee.department = @"DCST";
    employee.age = 18;
    
    EmployeeDbUtil *employeeDbUtil = [[EmployeeDbUtil alloc] init];
    [employeeDbUtil initDatabase];
    [employeeDbUtil saveEmployee:employee];
    
    NSMutableArray * temp = [employeeDbUtil getEmployees];
    
    NSLog(@"%@ temp", temp);
    
    for (Employee* key in temp) {
        NSLog(@"%@ key", key.name);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger retCount = 0;
    if(tableView == self.tableview) {
        retCount = [tableData count];
    } else if(tableView == self.tableview2) {
        retCount = [tableData2 count];
    }
    return retCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"tblcell";
    
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if(tableView == self.tableview) {
        cell.lblel.text = [tableData objectAtIndex:indexPath.row];
        cell.image.image = [UIImage imageNamed: @"test1.png"];
    } else if(tableView == self.tableview2) {
        cell.lblel.text = [tableData2 objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png"];
        
        [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, NSData *data) {
            if (succeeded) {
                cell.image.image = [[UIImage alloc] initWithData:data];
            }
        }];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(tableView == self.tableview) {
        [tableData2 addObject:[tableData objectAtIndex:indexPath.row]];
        [tableData removeObjectAtIndex:indexPath.row];
    } else if(tableView == self.tableview2) {
        [tableData addObject:[tableData2 objectAtIndex:indexPath.row]];
        [tableData2 removeObjectAtIndex:indexPath.row];
    }
    
    [self.tableview reloadData];
    [self.tableview2 reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    BOOL isDeletable = NO;
    if(tableView == self.tableview) {
        isDeletable = YES;
    }
    return isDeletable;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == self.tableview) {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        [tableData removeObjectAtIndex:indexPath.row];
        [self.tableview reloadData];
    }
    }
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

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
