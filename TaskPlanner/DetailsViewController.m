//
//  DetailsViewController.m
//  TaskPlanner
//
//  Created by ahmed on 22/04/2024.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameLabel.text = _currTask.name;
    _descriptionLabel.text = _currTask.taskDescription;
    _priorityLabel.text = _currTask.priority;
    _statusLabel.text = _currTask.status;
    NSDate *date = _currTask.date; // Replace this with your NSDate object
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // Set the date format as per your requirement
    NSString *dateString = [dateFormatter stringFromDate:date];
    _dateLabel.text = dateString;
}


@end
