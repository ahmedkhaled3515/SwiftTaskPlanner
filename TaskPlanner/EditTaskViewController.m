//
//  AddTaskViewController.m
//  TaskPlanner
//
//  Created by ahmed on 21/04/2024.
//

#import "EditTaskViewController.h"
#import "ViewController.h"
@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isEditMode = NO;
    if (_passedTask != nil) {
        _nameInput.text = _passedTask.name;
        _decriptionInput.text = _passedTask.taskDescription;
        if([_passedTask.priority isEqual:@"High"])
        {
            _prioritySegment.selectedSegmentIndex=0;
        }
        else if([_passedTask.priority isEqual:@"Medium"])
        {
            _prioritySegment.selectedSegmentIndex=1;
        }
        else
        {
            _prioritySegment.selectedSegmentIndex=2;
        }
        if([_passedTask.status isEqual:@"To-do"])
        {
            _statusSegment.selectedSegmentIndex=0;
        }
        else if([_passedTask.status isEqual:@"In progress"])
        {
            _statusSegment.selectedSegmentIndex=1;
            [_statusSegment setEnabled:NO forSegmentAtIndex:0];
            
        }
        else
        {
            _statusSegment.selectedSegmentIndex=2;
            [_statusSegment setEnabled:NO forSegmentAtIndex:0];
            [_statusSegment setEnabled:NO forSegmentAtIndex:1];
        }
        _dateInput.date = _passedTask.date;
        _saveButton.titleLabel.text = @"Save Edit";
        _isEditMode = YES;
    }
    _priorityList = [NSArray arrayWithObjects:@"High",@"Medium",@"Low", nil];
    _statusList = [NSArray arrayWithObjects:@"To-do",@"In Progress",@"Done", nil];
    _dateInput.minimumDate = [NSDate date];
    _defaults = [NSUserDefaults standardUserDefaults];
}

- (IBAction)addTask:(id)sender {
    if (!_isEditMode) {
        [self showAddAlert];
    }else{
        [self editAction];
    }
    
}
- (void)editAction {
    NSData *savedData;
    NSMutableArray<Task*> *savedTasks;
    if([_passedTask.status isEqual:@"To-do"]) {
        savedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"To-Do"];
    } else if([_passedTask.status isEqual:@"In Progress"]) {
        savedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"In progress"];
    } else {
        savedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"Done"];
    }
    savedTasks = [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
        Task *task = [Task new];
    task.name = _nameInput.text;
    task.taskDescription = _decriptionInput.text;
    task.priority = _priorityList[_prioritySegment.selectedSegmentIndex];
    task.status = _statusList[_statusSegment.selectedSegmentIndex];
    task.date = _dateInput.date;
    [savedTasks replaceObjectAtIndex:_passedIndex withObject:task];
    [self saveTasks:savedTasks];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) showAddAlert{
    NSString * title = @"Are you sure you want to add this task?";
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"confirm" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        NSData * savedData;
        NSMutableArray<Task*> * tasks;
        switch (_statusSegment.selectedSegmentIndex) {
            case 0:
                //to-do
                savedData =[[NSUserDefaults standardUserDefaults] objectForKey:@"To-Do"];
                break;
            case 1:
                //in progress
                savedData =[[NSUserDefaults standardUserDefaults] objectForKey:@"In progress"];
                break;
            case 2:
                //done
                savedData =[[NSUserDefaults standardUserDefaults] objectForKey:@"Done"];
            default:
                break;
        }
        tasks = [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
        if (!tasks) {
            tasks = [NSMutableArray array];
        }
        Task * task = [Task new];
        task.name = self->_nameInput.text;
        task.taskDescription = self->_decriptionInput.text;
        task.priority = self->_priorityList[self->_prioritySegment.selectedSegmentIndex];
        task.status = self->_statusList[self->_statusSegment.selectedSegmentIndex];
        task.date = self->_dateInput.date;
        [tasks addObject:task];
        [self saveTasks:tasks];
        ViewController * tableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tableVC"];
        [self.navigationController popViewControllerAnimated:YES];
//        [self.navigationController pushViewController:tableVC animated:YES];
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)saveTasks:(NSArray<Task *> *)tasks {
    NSData *encodedTasks = [NSKeyedArchiver archivedDataWithRootObject:tasks];
    switch (_statusSegment.selectedSegmentIndex) {
        case 0:
            //to-do
            [[NSUserDefaults standardUserDefaults] setObject:encodedTasks forKey:@"To-Do"];
            break;
        case 1:
            //in progress
            [[NSUserDefaults standardUserDefaults] setObject:encodedTasks forKey:@"In progress"];
            break;
        case 2:
            //done
            [[NSUserDefaults standardUserDefaults] setObject:encodedTasks forKey:@"Done"];
        default:
            break;
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
