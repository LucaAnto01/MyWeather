//
//  MDForecast.m
//  MyWeather
//
//  Created by Luca on 25/07/22.
//

#import "MDForecast.h"

@implementation MDForecast

/**Constructor method*/
- (instancetype) initWithCoordinate:(MDCoordinate *)coordinate
                       weatherArray:(NSMutableArray *)weatherArray
{
    self = [super init];
    if (self)
    {
        _coordinate = coordinate;
        _weatherArray = weatherArray;
    }
    
    return self;
    
}

- (NSString *) getWeatherImage_fromIndex:(int)index
{
    NSString *weatherImage = @"";
    if(_weatherArray)
    {
        MDWeather *serachedWeather = _weatherArray[index];
        
        NSString *shortDescription = [NSString stringWithFormat:@"%@", serachedWeather.weather];
        //Clean string
        shortDescription = [shortDescription stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        shortDescription = [shortDescription stringByReplacingOccurrencesOfString:@"(" withString:@""];
        shortDescription = [shortDescription stringByReplacingOccurrencesOfString:@")" withString:@""];
        shortDescription = [shortDescription stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        char *partOfDay = serachedWeather.partOfDay;
        
        //Setting image
        //In according with https://openweathermap.org/weather-conditions
        if([shortDescription isEqualToString:@"Clear"])
        {
            if(partOfDay == ((char *)'d'))
                weatherImage = @"☀️";
            else
                weatherImage = @"🌙";
        }
        
        else if([shortDescription isEqualToString:@"Clouds"])
        {
            weatherImage = @"☁️";
        }
        
        else if(([shortDescription isEqualToString:@"Mist"]) || ([shortDescription isEqualToString:@"Smoke"]) || ([shortDescription isEqualToString:@"Haze"]) || ([shortDescription isEqualToString:@"Dust"]) || ([shortDescription isEqualToString:@"Fog"]) || ([shortDescription isEqualToString:@"Sand"]) || ([shortDescription isEqualToString:@"Ash"]) || ([shortDescription isEqualToString:@"Squall"]) || ([shortDescription isEqualToString:@"Tornado"]))
        {
            weatherImage = @"🌫";
        }
        
        else if([shortDescription isEqualToString:@"Snow"])
        {
            weatherImage = @"❄️";
        }
        
        else if([shortDescription isEqualToString:@"Drizzle"])
        {
            weatherImage = @"☔️";
        }
        
        else if([shortDescription isEqualToString:@"Rain"])
        {
            weatherImage = @"🌧";
        }
        
        else if([shortDescription isEqualToString:@"Thunderstorm"])
        {
            weatherImage = @"⛈";
        }
        
        else
        {
            weatherImage = @"❌"; //In case of error
        }
    }
    
    return weatherImage;
}

@end
