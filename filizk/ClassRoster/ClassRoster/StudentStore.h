//
//  StudentStore.h
//  ClassRoster
//
//  Created by Filiz Kurban on 11/16/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface StudentStore : NSObject

+(instancetype)shared;

//-(instancetype)init;
-(NSInteger)count;
-(NSArray *)allStudents;
-(void)add:(Student *)stuent;
-(void)remove:(Student *)student;
-(void)save;

@end
