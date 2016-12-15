//
//  Student.m
//  ClassRoster
//
//  Created by Filiz Kurban on 11/16/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "Student.h"

@implementation Student

-(instancetype)initWithFirstName:(NSString *) firstName lastName:(NSString *)lastName email:(NSString *)email {
    self = [super init];

    if (self) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.email = email;
    }

    return self;
}

//MARK: NSCopying Protocol
-(id)copyWithZone:(NSZone *)zone {
    Student *student = [[Student alloc]init];
    
    student.firstName = self.firstName;
    student.lastName = self.lastName;
    student.email = self.email;

    return student;
}

//MARK: NSCoding Protocol
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    if (self) {
        self.firstName = [aDecoder decodeObjectForKey:@"firstName"];
        self.lastName = [aDecoder decodeObjectForKey:@"lastName"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
    }
    return self;
}

-(BOOL) isEqual: (id) theStudent {
    BOOL x  = self == theStudent;
    return x;
//    if (theStudent.firstName == self.firstName && theStudent.lastName == self.lastName && theStudent.email == self.email)
//        return true;
//    return false;

}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.firstName forKey:@"firstName"];
    [aCoder encodeObject:self.lastName forKey:@"lastName"];
    [aCoder encodeObject:self.email forKey:@"email"];
}

@end
