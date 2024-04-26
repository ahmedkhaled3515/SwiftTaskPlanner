//
//  Task.h
//  TaskPlanner
//
//  Created by ahmed on 21/04/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject <NSCoding>

@property NSString * name;
@property NSString * taskDescription;
@property NSString * priority;
@property NSString * status;
@property NSDate * date;

@end

NS_ASSUME_NONNULL_END
//- Add a new task to the todo list (Name, description, priority{high,med,low} and automatic date of  creation)[make a unique image for high, med and low priority tasks] [Attaching a file is a  bonus][adding a reminder is a bonus]
