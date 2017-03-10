//
//  EmployeeDbUtil.m
//  Test app 1
//
//  Created by Mobile Developer on 3/9/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

#import "EmployeeDbUtil.h"

@implementation EmployeeDbUtil

@synthesize databasePath;

- (void) initDatabase {
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent:@"employees.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //the file will not be there when we load the application for the first time
    //so this will create the database table
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
        {
            char *errMsg;
            NSString *sql_stmt = @"CREATE TABLE IF NOT EXISTS EMPLOYEES (";
            sql_stmt = [sql_stmt stringByAppendingString:@"id INTEGER PRIMARY KEY AUTOINCREMENT, "];
            sql_stmt = [sql_stmt stringByAppendingString:@"name TEXT, "];
            sql_stmt = [sql_stmt stringByAppendingString:@"department TEXT, "];
            sql_stmt = [sql_stmt stringByAppendingString:@"age TEXT)"];
            
            if (sqlite3_exec(mySqliteDB, [sql_stmt UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            else
            {
                NSLog(@"Employees table created successfully");
            }
            
            sqlite3_close(mySqliteDB);
            
        } else {
            NSLog(@"Failed to open/create database");
        }
    }
    
}

//save our data
- (BOOL) saveEmployee:(Employee *)employee
{
    BOOL success = false;
    sqlite3_stmt *statement = NULL;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
    {
        if (employee.employeeID > 0) {
            NSLog(@"Exitsing data, Update Please");
            NSString *updateSQL = [NSString stringWithFormat:@"UPDATE EMPLOYEES set name = '%@', department = '%@', age = '%@' WHERE id = ?",
                                   employee.name,
                                   employee.department,
                                   [NSString stringWithFormat:@"%ld", (long)employee.age]];
            
            const char *update_stmt = [updateSQL UTF8String];
            sqlite3_prepare_v2(mySqliteDB, update_stmt, -1, &statement, NULL );
            sqlite3_bind_int(statement, 1, employee.employeeID);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                success = true;
            }
            
        }
        else{
            NSLog(@"New data, Insert Please");
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO EMPLOYEES (name, department, age) VALUES (\"%@\", \"%@\", \"%@\")",
                                   employee.name,
                                   employee.department,
                                   [NSString stringWithFormat:@"%ld", (long)employee.age]];
            
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(mySqliteDB, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                success = true;
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(mySqliteDB);
        
    }
    
    return success;
}


//get a list of all our employees
- (NSMutableArray *) getEmployees
{
    NSMutableArray *employeeList = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT id, name, department, age FROM EMPLOYEES";
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(mySqliteDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Employee *employee = [[Employee alloc] init];
                employee.employeeID = sqlite3_column_int(statement, 0);
                employee.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                employee.department = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                employee.age = sqlite3_column_int(statement, 3);
                [employeeList addObject:employee];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(mySqliteDB);
    }
    
    return employeeList;
}


//get information about a specfic employee by it's id
- (Employee *) getEmployee:(NSInteger) employeeID
{
    Employee *employee = [[Employee alloc] init];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT id, name, department, age FROM EMPLOYEES WHERE id=%ld",
                              (long)employeeID];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(mySqliteDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                employee.employeeID = sqlite3_column_int(statement, 0);
                employee.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                employee.department = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                employee.age = sqlite3_column_int(statement, 3);
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(mySqliteDB);
    }
    
    return employee;
}

//delete the employee from the database
- (BOOL) deleteEmployee:(Employee *)employee
{
    BOOL success = false;
    sqlite3_stmt *statement = NULL;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
    {
        if (employee.employeeID > 0) {
            NSLog(@"Exitsing data, Delete Please");
            NSString *deleteSQL = [NSString stringWithFormat:@"DELETE from EMPLOYEES WHERE id = ?"];
            
            const char *delete_stmt = [deleteSQL UTF8String];
            sqlite3_prepare_v2(mySqliteDB, delete_stmt, -1, &statement, NULL );
            sqlite3_bind_int(statement, 1, employee.employeeID);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                success = true;
            }
            
        }
        else{
            NSLog(@"New data, Nothing to delete");
            success = true;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(mySqliteDB);
        
    }
    
    return success;
}

@end
