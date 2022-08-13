//
//  MDWeather.m
//  MyWeather
//
//  Created by Luca on 25/07/22.
//

#import "MDWeather.h"

@implementation MDWeather

/**No precipitation constructor method*/
- (instancetype) initWithWeather:(NSString *)weather
              weatherDescription:(NSString *)weatherDescription
                            date:(NSDate *)date
                            hour:(NSDateComponents *)hour
                         sunrise:(NSDateComponents *)sunrise
                          sunset:(NSDateComponents *)sunset
                       partOfDay:(unichar)partOfDay //Day or night
                     temperature:(double)temperature
                feelsTemperature:(double)feelsTemperature
                  minTemperature:(double)minTemperature
                  maxTemperature:(double)maxTemperature
                        pressure:(int)pressure //hPa
                        humidity:(int)humidity //%
                      visibility:(int)visibility //m
                            wind:(int)wind //m/s
                   windDirection:(int)windDirection //°
                          clouds:(int)clouds
{
    self = [super init];
    if (self)
    {
        _weather = weather;
        _weatherDescription = weatherDescription;
        _date = date;
        _hour = hour;
        _sunrise = sunrise;
        _sunset = sunset;
        _partOfDay = partOfDay;
        _temperature = temperature;
        _feelsTemperature = feelsTemperature;
        _minTemperature = minTemperature;
        _maxTemperature = maxTemperature;
        _pressure = pressure;
        _humidity = humidity;
        _visibility = visibility;
        _wind = wind;
        _windDirection = windDirection;
        _clouds = clouds;
        _lvlRain = 0;
        _lvlSnow = 0;
    }
    
    return self;
}

/**Rainfall constructor method*/
- (instancetype) initWithWeather:(NSString *)weather
              weatherDescription:(NSString *)weatherDescription
                            date:(NSDate *)date
                            hour:(NSDateComponents *)hour
                         sunrise:(NSDateComponents *)sunrise
                          sunset:(NSDateComponents *)sunset
                       partOfDay:(unichar)partOfDay //Day or night
                     temperature:(double)temperature
                feelsTemperature:(double)feelsTemperature
                  minTemperature:(double)minTemperature
                  maxTemperature:(double)maxTemperature
                        pressure:(int)pressure //hPa
                        humidity:(int)humidity //%
                      visibility:(int)visibility //m
                            wind:(int)wind //m/s
                   windDirection:(int)windDirection //°
                          clouds:(int)clouds //%
        probabilityPrecipitation:(int)probabilityPrecipitation //%
                         lvlRain:(int)lvlRain //mm/3h
{
    self = [super init];
    if (self)
    {
        _weather = weather;
        _weatherDescription = weatherDescription;
        _date = date;
        _hour = hour;
        _sunrise = sunrise;
        _sunset = sunset;
        _partOfDay = partOfDay;
        _temperature = temperature;
        _feelsTemperature = feelsTemperature;
        _minTemperature = minTemperature;
        _maxTemperature = maxTemperature;
        _pressure = pressure;
        _humidity = humidity;
        _visibility = visibility;
        _wind = wind;
        _windDirection = windDirection;
        _clouds = clouds;
        _lvlRain = lvlRain;
        _lvlSnow = 0;
    }
    
    return self;
    
}

/**Snowfall constructor method*/
- (instancetype) initWithWeather:(NSString *)weather
              weatherDescription:(NSString *)weatherDescription
                            date:(NSDate *)date
                            hour:(NSDateComponents *)hour
                         sunrise:(NSDateComponents *)sunrise
                          sunset:(NSDateComponents *)sunset
                       partOfDay:(unichar)partOfDay //Day or night
                     temperature:(double)temperature
                feelsTemperature:(double)feelsTemperature
                  minTemperature:(double)minTemperature
                  maxTemperature:(double)maxTemperature
                        pressure:(int)pressure //hPa
                        humidity:(int)humidity //%
                      visibility:(int)visibility //m
                            wind:(int)wind //m/s
                   windDirection:(int)windDirection //°
                          clouds:(int)clouds //%
        probabilityPrecipitation:(int)probabilityPrecipitation //%
                         lvlSnow:(int)lvlSnow //mm/3h
{
    self = [super init];
    if (self)
    {
        _weather = weather;
        _weatherDescription = weatherDescription;
        _date = date;
        _hour = hour;
        _sunrise = sunrise;
        _sunset = sunset;
        _partOfDay = partOfDay;
        _temperature = temperature;
        _feelsTemperature = feelsTemperature;
        _minTemperature = minTemperature;
        _maxTemperature = maxTemperature;
        _pressure = pressure;
        _humidity = humidity;
        _visibility = visibility;
        _wind = wind;
        _windDirection = windDirection;
        _clouds = clouds;
        _lvlRain = 0;
        _lvlSnow = lvlSnow;
    }
    
    return self;
    
}

- (instancetype) initFromJson:(NSDictionary *)jsonWeatherData
{
    self = [super init];
    if (self)
    {
        //NSDictionary *mainBlock = [listBlock valueForKey:@"main"];
        NSArray *mainBlock = [jsonWeatherData objectForKey:@"main"]; //Get main block of list block
        _temperature = [[mainBlock valueForKey:@"temp"] doubleValue];
        _feelsTemperature = [[mainBlock valueForKey:@"feels_like"] doubleValue];
        _minTemperature = [[mainBlock valueForKey:@"temp_min"] doubleValue];
        _maxTemperature = [[mainBlock valueForKey:@"temp_max"] doubleValue];
        _pressure = [[mainBlock valueForKey:@"pressure"] intValue];
        _humidity = [[mainBlock valueForKey:@"humidity"] intValue];
        
        //Use [0][@"element"] syntax for this reason: https://stackoverflow.com/questions/46939729/what-means-nssingleobjectarrayi-in-objective-c-when-i-try-to-read-a-json
        NSArray *weatherBlock = [jsonWeatherData objectForKey:@"weather"]; //Get weather block of list block
        _weather = weatherBlock[0][@"main"];
        _weatherDescription = weatherBlock[0][@"description"];
        
        NSArray *cloudBlock = [jsonWeatherData objectForKey:@"cloud"]; //Get cloud block of list block
        _clouds = [[cloudBlock valueForKey:@"all"] intValue];
        
        NSArray *windBlock = [jsonWeatherData objectForKey:@"wind"]; //Get wind block of list block
        _wind = [[windBlock valueForKey:@"speed"] intValue];
        _windDirection = [[windBlock valueForKey:@"deg"] intValue];
        
        _visibility = [[jsonWeatherData valueForKey:@"visibility"] intValue];
        _probabilityPrecipitation = [[jsonWeatherData valueForKey:@"pop"] intValue];
        
        if(_probabilityPrecipitation > 0)
        {
            NSArray *rainBlock = [jsonWeatherData objectForKey:@"rain"]; //Get rain Block block of list block
            if(rainBlock)
            {
                _lvlRain = [[rainBlock valueForKey:@"3h"] doubleValue];
            }
            
            else
            {
                _lvlRain = 0;
            }
            
            NSArray *snowBlock = [jsonWeatherData objectForKey:@"snow"]; //Get snow Block block of list block
            if(snowBlock)
            {
                _lvlSnow = [[snowBlock valueForKey:@"3h"] doubleValue];
            }
            
            else
            {
                _lvlSnow = 0;
            }
        }
        
        NSArray *partOfDayBlock = [jsonWeatherData objectForKey:@"sys"]; //Get part of day block of list block
        _partOfDay = /*(unichar)*/[[partOfDayBlock valueForKey:@"pod"] characterAtIndex:0];
        
        NSString *dateTmp = [jsonWeatherData valueForKey:@"dt_txt"]; //Get date block of list block
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _date = [dateFormatter dateFromString:dateTmp]; //Set date
        
        
        NSDate *dateTmpIn = [dateFormatter dateFromString:dateTmp];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        _hour = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dateTmpIn]; //Set hour
        //NSLog(@"%ld %ld", [_hour hour], [_hour minute]);
    }
    
    return self;
}

/**Get date as a string*/
-(NSString *) dateToString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *finalDate = [dateFormat stringFromDate:_date];
    
    return finalDate;
}

/**Get hour as string*/
-(NSString *) hourToString
{
    NSInteger hour = [_hour hour];
    NSInteger minute = [_hour minute];
    
    NSString *hourString = [NSString stringWithFormat: @"%d:%d", (int)hour, (int)minute];
    
    return hourString;
}

/**Get sunrise hour as string*/
-(NSString *) sunriseToString
{
    NSInteger hour = [_sunrise hour];
    NSInteger minute = [_sunrise minute];
    
    NSString *hourString = [NSString stringWithFormat: @"%d:%d", (int)hour, (int)minute];
    
    return hourString;
}

/**Get sunset hour as string*/
-(NSString *) sunsetToString
{
    NSInteger hour = [_sunset hour];
    NSInteger minute = [_sunset minute];
    
    NSString *hourString = [NSString stringWithFormat: @"%d:%d", (int)hour, (int)minute];
    
    return hourString;
}

- (NSString *) getWeatherImage
{
    NSString *weatherImage = @"";
    //Setting image
    //In according with https://openweathermap.org/weather-conditions
    if([_weather isEqualToString:@"Clear"])
    {
        if(_partOfDay == 'd')
            weatherImage = @"☀️";
        else
            weatherImage = @"🌙";
    }
    
    else if([_weather isEqualToString:@"Clouds"])
    {
        weatherImage = @"☁️";
    }
    
    else if(([_weather isEqualToString:@"Mist"]) || ([_weather isEqualToString:@"Smoke"]) || ([_weather isEqualToString:@"Haze"]) || ([_weather isEqualToString:@"Dust"]) || ([_weather isEqualToString:@"Fog"]) || ([_weather isEqualToString:@"Sand"]) || ([_weather isEqualToString:@"Ash"]) || ([_weather isEqualToString:@"Squall"]) || ([_weather isEqualToString:@"Tornado"]))
    {
        weatherImage = @"🌫";
    }
    
    else if([_weather isEqualToString:@"Snow"])
    {
        weatherImage = @"❄️";
    }
    
    else if([_weather isEqualToString:@"Drizzle"])
    {
        weatherImage = @"☔️";
    }
    
    else if([_weather isEqualToString:@"Rain"])
    {
        weatherImage = @"🌧";
    }
    
    else if([_weather isEqualToString:@"Thunderstorm"])
    {
        weatherImage = @"⛈";
    }
    
    else
    {
        weatherImage = @"❌"; //In case of error
    }
    
    return weatherImage;
}
@end
