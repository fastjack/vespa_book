//
//  Employee.h
//  Departments
//
//  Created by Martin Maciaszek on 01.02.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Employee :  NSManagedObject  
{
}

@property (retain) NSString * firstName;
@property (retain) NSString * lastName;
@property (retain) NSManagedObject * department;
@property (readonly) NSString *fullName;
@end


