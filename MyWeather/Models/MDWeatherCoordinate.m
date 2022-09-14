//
//  MDWeatherCoordinate.m
//  MyWeather
//
//  Created by Luca on 07/09/22.
//

#import "MDWeatherCoordinate.h"

@implementation MDWeatherCoordinate

/**Constructor method*/
-(instancetype) initWithWeather:(NSString *)weather
             weatherDescription:(NSString *)weatherDescription
                   weatherImage:(NSString *)weatherImage
                       latitude:(double)latitude
                      longitude:(double)longitude
                       forecast:(MDForecast*)forecast
{
    if(self = [super init])
    {
        _weather = weather;
        _weatherDescription = weatherDescription;
        _weatherImage = weatherImage;
        _latitude = latitude;
        _longitude = longitude;
        _forecast = forecast;
    }
    
    return self;
}

@end
