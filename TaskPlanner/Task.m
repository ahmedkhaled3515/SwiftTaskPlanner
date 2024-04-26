//
//  Task.m
//  TaskPlanner
//
//  Created by ahmed on 21/04/2024.
//

#import "Task.h"
@implementation Task

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.taskDescription forKey:@"description"];
    [coder encodeObject:self.priority forKey:@"priority"];
    [coder encodeObject:self.status forKey:@"status"];
    [coder encodeObject:self.date forKey:@"date"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder { 
    self = [super init];
        if (self) {
            _name = [coder decodeObjectForKey:@"name"];
            _taskDescription = [coder decodeObjectForKey:@"description"];
            _priority = [coder decodeObjectForKey:@"priority"];
            _status = [coder decodeObjectForKey:@"status"];
            _date = [coder decodeObjectForKey:@"date"];
        }
        return self;
}

@end
