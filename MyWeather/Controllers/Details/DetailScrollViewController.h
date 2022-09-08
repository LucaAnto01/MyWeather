//
//  DetailScrollViewController.h
//  MyWeather
//
//  Created by Luca on 07/09/22.
//

#import <UIKit/UIKit.h>
#import "../../Application/Services/ServiceWeather.h"
#import "../../Models/MDCoordinate.h"
#import "../../Models/MDWeather.h"
#import "../../Models/MDForecast.h"

@interface DetailScrollViewController : UIViewController

@property (nonatomic, strong) ServiceWeather *serviceWeather;
@property (nonatomic, strong) MDForecast *forecast;
@property (nonatomic, strong) NSMutableArray *todayHoursWeather;
@property (nonatomic, strong) NSMutableArray *weeklyWeather;

/**Method to set daily weather array, splitting the data*/
- (void) populateTodayHoursWeather;
/**Method to set weekly weather array, splitting the data*/
- (void) populateWeeklyWeather;
/**Method to display a popup in case of error*/
- (void) showAlertControl_withMessage:(NSString *)message;

@end
