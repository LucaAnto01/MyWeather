//
//  TwWeeklyController.h
//  MyWeather
//
//  Created by Luca on 12/08/22.
//

#import "../../../../Models/MDForecast.h"
#import <UIKit/UIKit.h>

@interface TwWeeklyController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) MDForecast *forecast;
@property (nonatomic, strong) NSMutableArray *weeklyWeather;

@end
