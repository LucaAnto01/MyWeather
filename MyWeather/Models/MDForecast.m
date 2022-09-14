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

@end
