//
//  EmployeeDbUtil.h
//  Test app 1
//
//  Created by Mobile Developer on 3/9/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Employee.h"

@interface EmployeeDbUtil : NSObject {
    sqlite3 *mySqliteDB;
}

@property (nonatomic, strong) NSString *databasePath;

- (void) initDatabase;
- (BOOL) saveEmployee:(Employee *)employee;
- (BOOL) deleteEmployee:(Employee *)employee;
- (NSMutableArray *) getEmployees;
- (Employee *) getEmployee:(NSInteger) employeeID;

@end
