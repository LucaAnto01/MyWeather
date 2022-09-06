//
//  DetailsViewController.m
//  MyWeather
//
//  Created by Luca on 09/08/22.
//

#import "DetailsViewController.h"
#import "TwController/TwWeeklyController/TwWeeklyController.h"
#import "TwController/TwDailyController/TwDailyController.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lbCity;

@property (weak, nonatomic) IBOutlet UIView *containerTwDaily;
@property (weak, nonatomic) IBOutlet UIView *containerTwWeekly;


@property (nonatomic, strong) NSMutableArray *weeklyWeather;
@property (nonatomic, strong) TwWeeklyController *twWeeklyController;
@property (nonatomic, strong) NSMutableArray *todayHoursWeather;
@property (nonatomic, strong) TwDailyController *twDailyController;

@end

@implementation DetailsViewController

- (void)viewDidLoad
{
    @try
    {
        [super viewDidLoad];
        
        _weeklyWeather = [[NSMutableArray alloc] init];
        _twWeeklyController = [[TwWeeklyController alloc] init];
        _todayHoursWeather = [[NSMutableArray alloc] init];
        //_twDailyController = [[TwDailyController alloc] init];
        self.twWeeklyController.view = self.twWeeklyController.tableView;
        
        [self populateWeeklyWeather];
        //[_twWeekly setDataSource:_twWeeklyController];
        //[_twWeekly setDelegate:_twWeeklyController];
        
        //_twWeeklyController.weeklyWeather = _weeklyWeather;
        //self.twWeekly.delegate = _twWeeklyController; //Set delegate
        //self.twWeekly.dataSource = _twWeeklyController; //Set deta source
        
        
        // self.twDaily.delegate = _twDailyController; //Set delegate
        // self.twDaily.dataSource = _twDailyController; //Set deta source
        
        
        //[self populateTodayHoursWeather];
        
        //_twDailyController.todayHoursWeather = _todayHoursWeather;
        
        _lbCity.text = _forecast.coordinate.city;
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}



/**Method to set weekly weather array, splitting the data*/
- (void) populateWeeklyWeather
{
    @try
    {
        NSInteger dayIndex = 0;
        
        [_weeklyWeather addObject:[_forecast.weatherArray objectAtIndex:0]]; //Adding first day
        
        NSInteger i;
        
        for(i = 1; i < _forecast.weatherArray.count; i++) //Scrool all weather of the forecast
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
            MDWeather *selected_weather = [_weeklyWeather objectAtIndex:dayIndex];
            NSDateComponents *selected_components = [[NSCalendar currentCalendar] components:componentFlags fromDate:selected_weather.date];
            //NSInteger selected_year = [selected_components year];
            //NSInteger selected_month = [selected_components month];
            NSInteger selected_day = [selected_components day];
            
            if(current_day != selected_day)
            {
                dayIndex++;
                [_weeklyWeather addObject:current_weather];
            }
        }
        
        [_weeklyWeather removeObjectAtIndex:1];
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
