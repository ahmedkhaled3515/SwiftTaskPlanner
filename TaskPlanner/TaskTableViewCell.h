//
//  TaskTableViewCell.h
//  TaskPlanner
//
//  Created by ahmed on 22/04/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *taskImage;
- (IBAction)editButton:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

@end

NS_ASSUME_NONNULL_END
