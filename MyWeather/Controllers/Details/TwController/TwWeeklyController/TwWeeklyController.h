//
//  TwWeeklyController.h
//  MyWeather
//
//  Created by Luca on 12/08/22.
//

#import <UIKit/UIKit.h>

@interface TwWeeklyController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *weeklyWeather;

@end
