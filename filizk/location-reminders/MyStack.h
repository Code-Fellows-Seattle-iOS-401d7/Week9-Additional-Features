//
//  MyStack.h
//  location-reminders
//
//  Created by Filiz Kurban on 12/5/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyStack : NSObject

-(void)push:(id)anObject;
-(id)pop;
-(id)peek;
@end
