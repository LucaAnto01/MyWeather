//
//  ServiceWeather.h
//  MyWeather
//
//  Created by Luca on 28/07/22.
//
//Using API of https://openweathermap.org

#import <Foundation/Foundation.h>
#import "../../Models/MDCoordinate.h"
#import "../../Models/MDWeather.h"
#import "../../Models/MDForecast.h"

@interface ServiceWeather : NSObject
{
    /**Attributes*/
    @private
        NSString *_apiKey;
}

/**Apikey constructor*/
-(instancetype) initWithOnlyApiKey:(NSString *)apikey;

/**Method using API to obtain forecasts from latitude & longitude*/
-(MDForecast *) getForecastWith_latitude:(double)latitude
                               longitude:(double)longitude;

-(NSData *) testWeatherForCity:(NSString *)city;

@property (nonatomic, strong) NSString *apiKey;

@end
