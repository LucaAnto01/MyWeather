//
//  MDCoordinate.m
//  MyWeather
//
//  Created by Luca on 25/07/22.
//

#import "MDCoordinate.h"

@implementation MDCoordinate

/**Complete constructor*/
- (instancetype) initWithCity:(NSString *)city
                      country:(NSString *)country
                     latitude:(double)latitude
                    longitude:(double)longitude
{
    self = [super init];
    if (self)
    {
        _city = city;
        _country = country;
        _latitude = latitude;
        _longitude = longitude;
    }
    
    return self;
}

@end
