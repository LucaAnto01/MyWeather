//
//  TwWeeklyController.m
//  MyWeather
//
//  Created by Luca on 12/08/22.
//

#import "TwWeeklyController.h"
#import "../../../../Application/Services/ApplicationSession.h"
#import "../../../../Library/UICustomElements/UIDetailsWeatherTableCell/DetailWeatherTableCell.h"

@interface TwWeeklyController ()

@property (strong, nonatomic) IBOutlet UITableView *twWeekly;

@end

@implementation TwWeeklyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _weeklyWeather = [[NSMutableArray alloc] init];
    _forecast = [[MDForecast alloc] init];
    
    _forecast = [ApplicationSession getSelectedForecast];
    [self populateWeeklyWeather];
    
    _twWeekly.dataSource = self;
    _twWeekly.delegate = self;
}

/**Method for setting the number of Weather cell of the table*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _weeklyWeather.count;
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
 
        detailWeatherCell.weather = _weeklyWeather[i];
    
        detailWeatherCell.lbWeather.text = [_weeklyWeather[i] getWeatherImage];
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
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Table view Weekly controller"
                               message:message
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"ERRORE: %@", message);
}

@end
