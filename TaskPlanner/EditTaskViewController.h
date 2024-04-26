//
//  AddTaskViewController.h
//  TaskPlanner
//
//  Created by ahmed on 21/04/2024.
//

#import <UIKit/UIKit.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditTaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *decriptionInput;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegment;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateInput;
@property Task * currTask;
@property NSArray * priorityList;
@property NSArray * statusList;
@property NSUserDefaults * defaults;
@property Task * passedTask;
@property int  passedIndex;
@property BOOL isEditMode;
- (IBAction)addTask:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


@end

NS_ASSUME_NONNULL_END
