//
//  Department.h
//  Departments
//
//  Created by Martin Maciaszek on 01.02.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Employee;

@interface Department :  NSManagedObject  
{
}

@property (retain) NSString * deptName;
@property (retain) Employee * manager;
@property (retain) NSSet* employees;

@end

@interface Department (CoreDataGeneratedAccessors)
- (void)addEmployeesObject:(Employee *)value;
- (void)removeEmployeesObject:(Employee *)value;
- (void)addEmployees:(NSSet *)value;
- (void)removeEmployees:(NSSet *)value;

@end

@interface Department (CoreDataGeneratedAccessors)
- (void)addEmployeesObject:(Employee *)value;
- (void)removeEmployeesObject:(Employee *)value;
@end
