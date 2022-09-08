//
//  DetailScrollViewController.m
//  MyWeather
//
//  Created by Luca on 07/09/22.
//

#import "DetailScrollViewController.h"

@interface DetailScrollViewController ()

@property (nonatomic, strong) IBOutlet UIScrollView *swScroll;

@end

@implementation DetailScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createInterface];
}

/**Method to create the interface*/
- (void) createInterface
{
    int j = 0;
    int i = 1; //Set the position from top
    float displayWidth = self.view.bounds.size.width;
    
    //Adding city label
    UILabel *lbCity = [[UILabel alloc]initWithFrame:CGRectMake(_swScroll.contentOffset.x, (i * 50), displayWidth, 40)];
    [lbCity setTextColor:[UIColor whiteColor]];
    [lbCity setText:_forecast.coordinate.city];
    [lbCity setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
    [lbCity setTextAlignment: NSTextAlignmentCenter];
    [_swScroll addSubview:lbCity];
    i++;
    
    //Adding daily label
    UILabel *lbDaily = [[UILabel alloc]initWithFrame:CGRectMake(_swScroll.contentOffset.x, (i * 50), displayWidth, 40)];
    [lbDaily setTextColor:[UIColor whiteColor]];
    [lbDaily setText:@"Daily Weather"];
    [lbDaily setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [lbDaily setTextAlignment: NSTextAlignmentCenter];
    [_swScroll addSubview:lbDaily];
    i++;
    
    /**Create daily info*/
    for (j = 0; j < _todayHoursWeather.count; j++)
    {
        MDWeather *current = _todayHoursWeather[j];
        
        NSString *hour = current.hourToString;
        NSString *weather = current.getWeatherImage;
        float maxTmp = current.maxTemperature;
        float minTmp = current.minTemperature;
        NSString *labelText = [NSString stringWithFormat:@"%@ \t%@ \t MAX: %.2f °C \n \t\t\t MIN: %.2f °C", hour, weather, maxTmp, minTmp];
        
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, (i * 50), displayWidth, 80)];
        [myLabel setBackgroundColor:[UIColor clearColor]];
        [myLabel setTextColor:[UIColor blackColor]];
        myLabel.lineBreakMode = NSLineBreakByWordWrapping;
        myLabel.numberOfLines = 0;
        [myLabel setText:labelText];
        [_swScroll addSubview:myLabel];
        i++;
    }

    //Adding daily info label
    UILabel *lbDailyInfo = [[UILabel alloc]initWithFrame:CGRectMake(10, (i * 50), displayWidth, 80)];
    [lbDailyInfo setTextColor:[UIColor whiteColor]];
    [lbDailyInfo setText:@"Daily info"];
    [lbDailyInfo setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [lbDailyInfo setTextAlignment: NSTextAlignmentCenter];
    [_swScroll addSubview:lbDailyInfo];
    i++;
    
    MDWeather *current = _todayHoursWeather[0];
    //humidity
    int humidity = current.humidity;
    NSString *humitidyToString = [NSString stringWithFormat:@"Humidity: %d%%",humidity];
    UILabel *lbhumidity = [[UILabel alloc]initWithFrame:CGRectMake(10, (i * 50), displayWidth, 40)];
    [lbhumidity setTextColor:[UIColor blackColor]];
    [lbhumidity setText: humitidyToString];
    [_swScroll addSubview:lbhumidity];
    i++;
    
    //probability of precipitation
    if(current.probabilityPrecipitation != 0)
    {
        int pop = current.probabilityPrecipitation; //%
        NSString *popToString = [NSString stringWithFormat:@"Probability of precipitation: %d%%", pop * 100];
        UILabel *lbpop = [[UILabel alloc]initWithFrame:CGRectMake(10, (i * 50), displayWidth, 40)];
        [lbpop setTextColor:[UIColor blackColor]];
        [lbpop setText: popToString];
        [_swScroll addSubview:lbpop];
        i++;
        
        if(current.lvlRain != 0)
        {
            int lvlRain = current.lvlRain;
            NSString *lvlRainToString = [NSString stringWithFormat:@"Level of rain: %d mm/3h", lvlRain];
            UILabel *lbLvlRain = [[UILabel alloc]initWithFrame:CGRectMake(10, (i * 50), displayWidth, 40)];
            [lbLvlRain setTextColor:[UIColor blackColor]];
            [lbLvlRain setText: lvlRainToString];
            [_swScroll addSubview:lbLvlRain];
            i++;
        }
        
        else if(current.lvlSnow != 0)
        {
            int lvlSnow = current.lvlSnow;
            NSString *lvlSnowToString = [NSString stringWithFormat:@"Level of snow: %d mm/3h", lvlSnow];
            UILabel *lbLvlSnow = [[UILabel alloc]initWithFrame:CGRectMake(10, (i * 50), displayWidth, 40)];
            [lbLvlSnow setTextColor:[UIColor blackColor]];
            [lbLvlSnow setText: lvlSnowToString];
            [_swScroll addSubview:lbLvlSnow];
            i++;
        }
    }
    
    //sunrise
    NSString *sunrisetFormatted = [NSString stringWithFormat:@"Sunrise🌞: %@", current.sunriseToString];
    UILabel *lbSunrise = [[UILabel alloc]initWithFrame:CGRectMake(10, (i * 50), displayWidth, 40)];
    [lbSunrise setTextColor:[UIColor blackColor]];
    [lbSunrise setText: sunrisetFormatted];
    [_swScroll addSubview:lbSunrise];
    i++;
    
    //sunset
    NSString *sunsetFormatted = [NSString stringWithFormat:@"Sunset🌝: %@", current.sunsetToString];
    UILabel *lbSunset = [[UILabel alloc]initWithFrame:CGRectMake(10, (i * 50), displayWidth, 40)];
    [lbSunset setTextColor:[UIColor blackColor]];
    [lbSunset setText: sunsetFormatted];
    [_swScroll addSubview:lbSunset];
    i++;

    //Adding weekly label
    UILabel *lbWeekly = [[UILabel alloc]initWithFrame:CGRectMake(_swScroll.contentOffset.x, (i * 50), displayWidth, 80)];
    [lbWeekly setTextColor:[UIColor whiteColor]];
    [lbWeekly setText:@"Weekly Weather"];
    [lbWeekly setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [lbWeekly setTextAlignment: NSTextAlignmentCenter];
    [_swScroll addSubview:lbWeekly];
    i++;
    
    /**Create weekly info*/
    for (j = 0; j < _weeklyWeather.count; j++)
    {
        MDWeather *current = _weeklyWeather[j];
        
        NSString *date = current.dateToString;
        NSString *weather = current.getWeatherImage;
        float maxTmp = current.maxTemperature;
        float minTmp = current.minTemperature;
        NSString *labelText = [NSString stringWithFormat:@"%@ \t%@ \t MAX: %.2f °C \n \t\t\t\t\t MIN: %.2f °C", date, weather, maxTmp, minTmp];
        
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, (i * 50), displayWidth, 80)];
        [myLabel setBackgroundColor:[UIColor clearColor]];
        [myLabel setTextColor:[UIColor blackColor]];
        myLabel.lineBreakMode = NSLineBreakByWordWrapping;
        myLabel.numberOfLines = 0;
        [myLabel setText:labelText];
        [_swScroll addSubview:myLabel];
        i++;
    }

    CGSize newContentSize=_swScroll.contentSize;
    newContentSize.height += (i * 50) + 30;
    newContentSize.width = displayWidth;
    [_swScroll setContentSize:newContentSize];
}

#pragma mark - Setting data

/**Method to set daily weather array, splitting the data*/
- (void) populateTodayHoursWeather
{
    @try
    {
        if(_todayHoursWeather == nil)
            _todayHoursWeather = [[NSMutableArray alloc] init];
            
        [_todayHoursWeather removeAllObjects]; //Clean array
        
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

/**Method to set weekly weather array, splitting the data*/
- (void) populateWeeklyWeather
{
    @try
    {
        if(_weeklyWeather == nil)
            _weeklyWeather = [[NSMutableArray alloc] init];
            
        [_weeklyWeather removeAllObjects]; //Clean array
        
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
        
        //[_weeklyWeather removeObjectAtIndex:1];
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
}

#pragma mark - Show error

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
