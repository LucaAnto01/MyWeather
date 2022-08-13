//
//  TwDailyController.h
//  MyWeather
//
//  Created by Luca on 12/08/22.
//

#import <UIKit/UIKit.h>

@interface TwDailyController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *todayHoursWeather;

@end
