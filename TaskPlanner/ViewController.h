//
//  ViewController.h
//  TaskPlanner
//
//  Created by ahmed on 21/04/2024.
//

#import <UIKit/UIKit.h>
#import "Task.h"
@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,UISearchBarDelegate>
@property Task * clickedTask;
@property (weak, nonatomic) IBOutlet UITabBar *bottomBar;
@property BOOL  isFiltered;
@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property NSMutableArray<Task*> * searchedTasks;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property NSMutableArray<Task*> * allTasks;
@property NSMutableArray<Task*> * highT;
@property NSMutableArray<Task*> * mediumT;
@property NSMutableArray<Task*> * lowT;
@property NSString * selectedCategory;
- (IBAction)filterAction:(id)sender;



@end

