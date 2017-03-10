//
//  Employee.h
//  Test app 1
//
//  Created by Mobile Developer on 3/9/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject

@property (nonatomic) NSInteger employeeID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *department;
@property (nonatomic) NSInteger age;


@end
