//
//  StudentStore.m
//  ClassRoster
//
//  Created by Filiz Kurban on 11/16/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "StudentStore.h"

//class extension
@interface StudentStore ()
@property(strong, nonatomic)NSMutableArray *students;
@end

@implementation StudentStore


+(instancetype)shared {
    static StudentStore *shared = nil;

    static dispatch_once_t onceToken;
    //block(closure)starts with {
    dispatch_once(&onceToken, ^{
        shared = [[StudentStore alloc]init];
    });
    return shared;
}

-(instancetype)init{

    self = [super init];

    if (self) {
        self.students = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfURL:self.archiveURL]];

        if (!self.students) {
            self.students = [[NSMutableArray alloc]init];
        }
    }

    return self;
}

-(NSInteger)count{
    return self.students.count;
}

-(NSArray *)allStudents{
    NSMutableArray *students = [[NSMutableArray alloc]init];
    //this works as students object knows how to copy itself. So it works when we copy an object, and also works when we copy an array of objects.
    students = [self.students copy];
//    for (Student *stdnt in self.students) {
//        Student *deepCopy = [stdnt copy]; 
//        [students addObject:deepCopy];
//    }
    return students;
}


-(void)add:(Student *)student{
    if (![self.students containsObject:student]) {
        [self.students addObject:student];
        [self save];
    }
}

-(void)remove:(Student *)student{
    [self.students removeObject:student.email];
    [self save];
}

-(void)save{
    //archieveRootObject uses the data structure of self.students to determine how to archieve objects
    BOOL success = [NSKeyedArchiver archiveRootObject:self.students toFile:self.archiveURL.path];
}

-(NSURL *)archiveURL {
    NSURL *documentsDirectory = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains: NSUserDomainMask] firstObject];

    return [documentsDirectory URLByAppendingPathComponent:@"archive"]; // creates a archieve diroctory

}

@end
