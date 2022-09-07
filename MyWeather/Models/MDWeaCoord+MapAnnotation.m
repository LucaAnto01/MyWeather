//
//  MDWeaCoord+MapAnnotation.m
//  MyWeather
//
//  Created by Luca on 07/09/22.
//

#import "MDWeaCoord+MapAnnotation.h"

@implementation MDWeatherCoordinate(MapAnnotation)

/**Get the coordinate of the MapAnnotation*/
-(CLLocationCoordinate2D) coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}

/**Get the title --> wwather image*/
- (NSString *)title
{
    return [NSString stringWithFormat:@"%@", self.weatherImage];;
}

/**Get the title --> wwather image*/
- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"%@", self.weatherDescription];;
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
    return [NSString stringWithFormat:@"%@", self.weatherImage]; //Is the "image" --> emoji
}

@end
