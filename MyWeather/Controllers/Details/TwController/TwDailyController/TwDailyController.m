//
//  TwDailyController.m
//  MyWeather
//
//  Created by Luca on 12/08/22.
//

#import "TwDailyController.h"
#import "../../../../Application/Services/ApplicationSession.h"
#import "../../../../Library/UICustomElements/UIDetailsWeatherTableCell/DetailWeatherTableCell.h"

@interface TwDailyController ()

@property (strong, nonatomic) IBOutlet UITableView *twDaily;

@end

@implementation TwDailyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _todayHoursWeather = [[NSMutableArray alloc] init];
    _forecast = [[MDForecast alloc] init];
    
    _forecast = [ApplicationSession getSelectedForecast];
    [self populateTodayHoursWeather];
    
    _twDaily.dataSource = self;
    _twDaily.delegate = self;
}

/**Method for setting the number of Weather cell of the table*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _todayHoursWeather.count;
}

/**Method for setting the height of Weather cell*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 55; //In according with the height of the object
}

/**Method to get a table view cell*/
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        static NSString *identifier = @"DetailWeatherCell";
        
        DetailWeatherTableCell *detailWeatherCell = (DetailWeatherTableCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        if(!detailWeatherCell)
        {
            NSArray *nswth = [[NSBundle mainBundle] loadNibNamed:@"DetailWeatherTableCell" owner:self options:nil]; //Method found on stackoverflow --> create an object with certain name
            detailWeatherCell = [nswth objectAtIndex:0];
        }
        
        NSInteger i = indexPath.row;
 
        detailWeatherCell.weather = _todayHoursWeather[i];
    
        detailWeatherCell.lbWeather.text = [_todayHoursWeather[i] getWeatherImage];
        detailWeatherCell.lbMaxTmp.text = [NSString stringWithFormat:@"%.2f °C", detailWeatherCell.weather.maxTemperature];
        detailWeatherCell.lbMinTmp.text = [NSString stringWithFormat:@"%.2f °C", detailWeatherCell.weather.minTemperature];
        
        return detailWeatherCell;
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
    
    return nil;
}

/**Method to set daily weather array, splitting the data*/
- (void) populateTodayHoursWeather
{
    @try
    {
        MDWeather *current_weather = [_forecast.weatherArray objectAtIndex:0];
        //TODO: setta tutti i testi relativi ad oggi (tramonto etc)
        
        [_todayHoursWeather addObject:[_forecast.weatherArray objectAtIndex:0]]; //Add first part for hour
        NSDate *currentDate = current_weather.date;
        NSUInteger componentFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
        
        //Current weather
        NSDateComponents *current_components = [[NSCalendar currentCalendar] components:componentFlags fromDate:currentDate];
        NSInteger current_day = [current_components day];
        
        NSInteger hourIndex = 0;
        NSInteger i;
        
        for(i = 1; i < _forecast.weatherArray.count; i++) //Scrool all weather of the forecast
        {
            //Selected weather
            MDWeather *selected_weather = [_forecast.weatherArray objectAtIndex:i];
            NSDateComponents *selected_components = [[NSCalendar currentCalendar] components:componentFlags fromDate:selected_weather.date];
            //NSInteger selected_year = [selected_components year];
            //NSInteger selected_month = [selected_components month];
            NSInteger selected_day = [selected_components day];
            
            if(current_day == selected_day)
            {
                hourIndex++;
                [_todayHoursWeather addObject:selected_weather];
            }
        }
        
        
    }
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
}

/**Method to display a popup in case of error*/
- (void) showAlertControl_withMessage:(NSString *)message
{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Table view Daily controller"
                               message:message
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"ERRORE: %@", message);
}

@end
