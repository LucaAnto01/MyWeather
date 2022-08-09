//
//  DetailsViewController.m
//  MyWeather
//
//  Created by Luca on 09/08/22.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (nonatomic, strong) NSMutableArray *dailyWeather;
@property (nonatomic, strong) NSMutableArray *todayHoursWeather;

@end

@implementation DetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dailyWeather = [[NSMutableArray alloc] init];
    _todayHoursWeather = [[NSMutableArray alloc] init];
    
    [self populateDailyWeather];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}

/**Method to set daily weather array, splitting the data*/
- (void) populateDailyWeather
{
    @try
    {
        NSInteger dayIndex = 0;
        
        [_dailyWeather addObject:[_forecast.weatherArray objectAtIndex:0]]; //Adding first day
        
        NSInteger i;
        
        for(i = 0; i < _forecast.weatherArray.count; i++) //Scrool all weather of the forecast
        {
            MDWeather *current_weather = [_forecast.weatherArray objectAtIndex:i];
            NSDate *dayWeather = current_weather.date;
            
            NSUInteger componentFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
            
            //Current weather
            NSDateComponents *current_components = [[NSCalendar currentCalendar] components:componentFlags fromDate:dayWeather];
            //NSInteger current_year = [current_components year];
            //NSInteger current_month = [current_components month];
            NSInteger current_day = [current_components day];
            
            //Selected weather
            MDWeather *selected_weather = [_dailyWeather objectAtIndex:dayIndex];
            NSDateComponents *selected_components = [[NSCalendar currentCalendar] components:componentFlags fromDate:selected_weather.date];
            //NSInteger selected_year = [selected_components year];
            //NSInteger selected_month = [selected_components month];
            NSInteger selected_day = [selected_components day];
            
            if(current_day != selected_day)
            {
                dayIndex++;
                [_dailyWeather addObject:current_weather];
            }
        }
        
        [_dailyWeather removeObjectAtIndex:1];
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
}

/**Method to display a popup in case of error*/
- (void) showAlertControl_withMessage:(NSString *)message
{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Details view controller"
                               message:message
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"ERRORE: %@", message);
}

@end
