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
        double _latitude;
        double _longitude;
        NSData *_data;
}

/**Apikey constructor*/
-(instancetype) initWithOnlyApiKey:(NSString *)apikey;

/**Complete constructor*/
-(instancetype) initWithApiKey:(NSString *)apikey
                      latitude:(double)latitude
                     longitude:(double)longitude;

/**Method for update coordinate*/
-(void) updateLatitude:(double)latitude
             longitude:(double)longitude;

/**Method for making a new query*/
-(void) updateData;

/**Method using API to obtain forecasts*/
-(MDForecast *) getForecast;

@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
@property (nonatomic, strong) NSData *data;

@end
