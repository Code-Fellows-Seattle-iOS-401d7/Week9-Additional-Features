//
//  Student.h
//  ClassRoster
//
//  Created by Filiz Kurban on 11/16/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject<NSCopying, NSCoding> //Student is conforming to NSCopying and NSCoding protocols

@property(strong, nonatomic)NSString *firstName;
//nonatomic, at high, atamic properties are considered thread safe. They'll have mutax and will not allow the them to be manipulated by multiple threads.


@property(strong, nonatomic)NSString *lastName;
@property(strong, nonatomic)NSString *email;

-(instancetype)initWithFirstName:(NSString *) firstName lastName:(NSString *)lastName email:(NSString *)email;


@end
