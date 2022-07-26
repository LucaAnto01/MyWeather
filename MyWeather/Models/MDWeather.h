//
//  MDWeather.h
//  MyWeather
//
//  Created by Luca on 25/07/22.
//

#import <Foundation/Foundation.h>

@interface MDWeather : NSObject

/**Attributes*/
{
    @private
        NSString *_weather;
        NSString *_weatherDescription;
        NSDate *_date;
        NSDateComponents *_hour;
        NSDateComponents *_sunrise;
        NSDateComponents *_sunset;
        char *_partOfDay;
        double _temperature;
        double _feelsTemperature;
        double _minTemperature;
        double _maxTemperature;
        int _pressure;
        int _humidity;
        int _visibility;
        int _wind;
        int _windDirection;
        int _clouds;
        int _lvlRain;
        int _lvlSnow;
    
}

/**No precipitation constructor method*/
- (instancetype) initWithWeather:(NSString *)weather
              weatherDescription:(NSString *)weatherDescription
                            date:(NSDate *)date
                            hour:(NSDateComponents *)hour
                         sunrise:(NSDateComponents *)sunrise
                          sunset:(NSDateComponents *)sunset
                       partOfDay:(char *)partOfDay //Day or night
                     temperature:(double)temperature
                feelsTemperature:(double)feelsTemperature
                  minTemperature:(double)minTemperature
                  maxTemperature:(double)maxTemperature
                        pressure:(int)pressure //hPa
                        humidity:(int)humidity //%
                      visibility:(int)visibility //m
                            wind:(int)wind //m/s
                   windDirection:(int)windDirection //°
                          clouds:(int)clouds; //%

/**Rainfall constructor method*/
- (instancetype) initWithWeather:(NSString *)weather
              weatherDescription:(NSString *)weatherDescription
                            date:(NSDate *)date
                            hour:(NSDateComponents *)hour
                         sunrise:(NSDateComponents *)sunrise
                          sunset:(NSDateComponents *)sunset
                       partOfDay:(char *)partOfDay //Day or night
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
                         lvlRain:(int)lvlRain; //mm/3h

/**Snowfall constructor method*/
- (instancetype) initWithWeather:(NSString *)weather
              weatherDescription:(NSString *)weatherDescription
                            date:(NSDate *)date
                            hour:(NSDateComponents *)hour
                         sunrise:(NSDateComponents *)sunrise
                          sunset:(NSDateComponents *)sunset
                       partOfDay:(char *)partOfDay //Day or night
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
                         lvlSnow:(int)lvlSnow; //mm/3h

/**Constructor method from json*/
- (instancetype) initFromJson:(NSDictionary *)jsonWeatherData;

/**Properties*/
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDateComponents *hour;
@property (nonatomic, strong) NSDateComponents *sunrise;
@property (nonatomic, strong) NSDateComponents *sunset;
@property (nonatomic, readonly) char *partOfDay;
@property (nonatomic, readonly) double temperature;
@property (nonatomic, readonly) double feelsTemperature;
@property (nonatomic, readonly) double minTemperature;
@property (nonatomic, readonly) double maxTemperature;
@property (nonatomic, readonly) int pressure;
@property (nonatomic, readonly) int humidity;
@property (nonatomic, readonly) int visibility;
@property (nonatomic, readonly) int wind;
@property (nonatomic, readonly) int windDirection;
@property (nonatomic, readonly) int clouds;
@property (nonatomic, readonly) int probabilityPrecipitation;
@property (nonatomic, readonly) int lvlRain;
@property (nonatomic, readonly) int lvlSnow;

/**Methods*/
-(NSString *) dateToString;
-(NSString *) hourToString;
-(NSString *) sunriseToString;
-(NSString *) sunsetToString;

@end
