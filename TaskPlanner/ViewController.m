//
//  ViewController.m
//  TaskPlanner
//
//  Created by ahmed on 21/04/2024.
//

#import "ViewController.h"
#import "Task.h"
#import "TaskTableViewCell.h"
#import "EditTaskViewController.h"
#import "DetailsViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"To-Do"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"In progress"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Done"];
    _selectedCategory = @"To-Do";
    _table.delegate = self;
    _table.dataSource = self;
    _bottomBar.delegate = self;
    _search.delegate = self;
    _isFiltered = YES;
}
- (IBAction)filterAction:(id)sender {
    _isFiltered = !_isFiltered;
    [self updateTasks];
//    [_table reloadData];
}
- (void) updateTasks{
    _highT = [NSMutableArray array];
    _mediumT = [NSMutableArray array];
    _lowT = [NSMutableArray array];
    NSData * taskData = [[NSUserDefaults standardUserDefaults] objectForKey:_selectedCategory];
    _allTasks = [NSKeyedUnarchiver unarchiveObjectWithData:taskData];
    _searchedTasks = _allTasks;
    for(int i =0; i<_searchedTasks.count;i++)
    {
        Task * curr = _searchedTasks[i];
        if([curr.priority isEqual:@"High"])
        {
            [_highT addObject:curr];
        }
        else if([curr.priority isEqual:@"Medium"])
        {
            [_mediumT addObject:curr];
        }
        else if([curr.priority isEqual:@"Low"]) {
            [_lowT addObject:curr];
        }
    }
    [_table reloadData];
}
- (void)viewDidAppear:(BOOL)animated{
    [self updateTasks];
    [_table reloadData];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_isFiltered)
    {
        return 3;
    }
    else return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            if(_isFiltered)
            {
                return @"High";
            }
            else return @"";
            break;
        case 1:
            return @"Medium";
            break;
        case 2:
            return @"Low";
            break;
    }
    return @"";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = 0;
    switch (section) {
        case 0:
            if(_isFiltered)
            {
                count = _highT.count;
            }
            else count = _searchedTasks.count;
            break;
        case 1:
            count = _mediumT.count;
            break;
        case 2:
            count = _lowT.count;
            break;
        default:
            break;
    }
    return count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Task *task;
    if(_isFiltered)
    {
        if (indexPath.section == 0) {
            task = _highT[indexPath.row];
        } else if (indexPath.section == 1) {
            task = _mediumT[indexPath.row];
        } else {
            task = _lowT[indexPath.row];
        }
    }
    else{
        task = _searchedTasks[indexPath.row];
    }

    cell.cellTitle.text = task.name;
    if([task.priority isEqual:@"High"])
    {
        cell.taskImage.image = [UIImage imageNamed:@"images-5.png"];
    }
    else if([task.priority isEqual:@"Medium"])
    {
        cell.taskImage.image = [UIImage imageNamed:@"images-4.png"];
    }
    else{
        cell.taskImage.image =[UIImage imageNamed:@"images-3.png"];
    }
   return cell;
}
-(void) editAction :(NSIndexPath *) indexPath{
    if (self->_isFiltered) {
        if (indexPath.section == 0) {
            self->_clickedTask = self->_highT[indexPath.row];
        } else if (indexPath.section == 1) {
            self->_clickedTask = self->_mediumT[indexPath.row];
        } else {
            self->_clickedTask = self->_lowT[indexPath.row];
        }
    } else {
        self->_clickedTask = self->_allTasks[indexPath.row];
    }
    EditTaskViewController * destination = [self.storyboard instantiateViewControllerWithIdentifier:@"taskVC"];
    destination.passedTask = self->_clickedTask;
    destination.passedIndex = indexPath.row;
    [self.navigationController pushViewController:destination animated:YES];
    [_table reloadData];
    printf("hello edit");
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction * editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction * action,NSIndexPath * indexPath){
        [self editAction:indexPath];
    }];
    UITableViewRowAction * deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Remove" handler:^(UITableViewRowAction * action,NSIndexPath * indexPath){
        [self removeAction:indexPath];
    }];
    
    return @[deleteAction,editAction];
}
- (void) removeAction : (NSIndexPath*)indexPath{
    NSMutableArray<Task*> * newArray = [NSMutableArray array];
    
    if(self->_isFiltered)
        {
            if (indexPath.section == 0) {
                [self->_highT removeObjectAtIndex:indexPath.row];
            }
            else if(indexPath.section == 1)
            {
                [self->_mediumT removeObjectAtIndex:indexPath.row];
            }
            else{
                [self->_lowT removeObjectAtIndex:indexPath.row];
            }
            [newArray addObjectsFromArray:self->_highT];
            [newArray addObjectsFromArray:self->_mediumT];
            [newArray addObjectsFromArray:self->_lowT];
            
        }
        else{
            [self->_allTasks removeObjectAtIndex:indexPath.row];
        }
        NSData *encodedTasks = [NSKeyedArchiver archivedDataWithRootObject:newArray];
    [[NSUserDefaults standardUserDefaults] setObject:encodedTasks forKey:self->_selectedCategory];
        [[NSUserDefaults standardUserDefaults] synchronize];
            [_table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [_table reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self->_isFiltered) {
        if (indexPath.section == 0) {
            self->_clickedTask = self->_highT[indexPath.row];
        } else if (indexPath.section == 1) {
            self->_clickedTask = self->_mediumT[indexPath.row];
        } else {
            self->_clickedTask = self->_lowT[indexPath.row];
        }
    } else {
        self->_clickedTask = self->_allTasks[indexPath.row];
    }
    DetailsViewController * destination = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsVC"];
    destination.currTask = self->_clickedTask;
    [self.navigationController pushViewController:destination animated:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _isFiltered = NO;
    if (searchText.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", searchText];
        self.searchedTasks = [NSMutableArray arrayWithArray:[_allTasks filteredArrayUsingPredicate:predicate]];
    } else {
        self.searchedTasks = [NSMutableArray arrayWithArray:_allTasks];
    }
    [self.table reloadData];
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSString *selectedTitle = item.title;
    _selectedCategory = item.title;
    [self updateTasks];
}

@end
