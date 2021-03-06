#import <UIKit/UIKit.h>
#import "IAMainTableCellDelegate.h"

@interface IAMainTableViewCell : UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (weak, nonatomic) id<IAMainTableCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *fifthLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fifthImage;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UINavigationItem *mainTitle;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImage;
@property (weak, nonatomic) IBOutlet UIImageView *fourthImage;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourthLabel;
@end
