//
//  TwDailyController.h
//  MyWeather
//
//  Created by Luca on 12/08/22.
//

#import "../../../../Models/MDForecast.h"
#import <UIKit/UIKit.h>

@interface TwDailyController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) MDForecast *forecast;
@property (nonatomic, strong) NSMutableArray *todayHoursWeather;

/**Method to display a popup in case of error*/
- (void) showAlertControl_withMessage:(NSString *)message;

@end
