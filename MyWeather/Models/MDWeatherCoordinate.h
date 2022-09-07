//
//  MDWeatherCoordinate.h
//  MyWeather
//
//  Created by Luca on 07/09/22.
//

#import <Foundation/Foundation.h>
#import "MDWeather.h"
#import "MDCoordinate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDWeatherCoordinate : NSObject

{
    @private
        NSString *_weather;
        NSString *_weatherDescription;
        NSString *_weatherImage;
        double _latitude;
        double _longitude;
}

@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSString *weatherImage;
@property (nonatomic, readwrite) double latitude;
@property (nonatomic, readwrite) double longitude;

/**Constructor method*/
-(instancetype) initWithWeather:(NSString *)weather
             weatherDescription:(NSString *)weatherDescription
                   weatherImage:(NSString *)weatherImage
                       latitude:(double)latitude
                      longitude:(double)longitude;

@end

NS_ASSUME_NONNULL_END
