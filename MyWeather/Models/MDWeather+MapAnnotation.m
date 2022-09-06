//
//  MDWeather+MapAnnotation.m
//  MyWeather
//
//  Created by Luca on 06/09/22.
//

#import "MDWeather+MapAnnotation.h"

@implementation MDWeather(MapAnnotation)

/**Get the coordinate of the MapAnnotation*/
-(CLLocationCoordinate2D) coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.coordinate.latitude;
    coordinate.longitude = self.coordinate.longitude;
    return coordinate;
}

/**Get the short description of the MapAnnotation*/
- (NSString *)getShortDescription
{
    return [NSString stringWithFormat:@"%@", self.weather]; //Is the short descriptoin
}

/**Get the description of the MapAnnotation*/
- (NSString *)getDescription
{
    return [NSString stringWithFormat:@"%@", self.weatherDescription]; //Is the descriptoin
}

/**Get the image  of the MapAnnotation*/
- (NSString *)getImage
{
    return [NSString stringWithFormat:@"%@", self.getWeatherImage]; //Is the "image" --> emoji
}

@end
