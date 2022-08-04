//
//  ServiceWeather.m
//  MyWeather
//
//  Created by Luca on 28/07/22.
//

#import "ServiceWeather.h"

@implementation ServiceWeather

/**Apikey constructor*/
-(instancetype) initWithOnlyApiKey:(NSString *)apikey
{
    self = [super init];
    if (self)
    {
        _apiKey = apikey;
    }
    
    return self;
}

/**Method using API to obtain forecasts*/
-(MDForecast *) getForecastWith_latitude:(double)latitude
                               longitude:(double)longitude
{
    NSError *error;
    NSURLResponse *response;
    
    @try
    {
        NSString *urlRequest = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?lat=%f&lon=%f&appid=%@&units=metric", latitude, longitude, _apiKey]; //5 days
        //&lang=it for italian response

        NSLog(@"%@", urlRequest);
        
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlRequest]] returningResponse:&response error:&error];
        
        NSDictionary *datiJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]; //Get data format json to work with
        
        //Create coordinate object
        NSString *cityblock = [datiJson valueForKey:@"city"];
        NSString *city = [cityblock valueForKey:@"name"];
        NSString *country = [cityblock valueForKey:@"country"];
        
        MDCoordinate *coordinate = [[MDCoordinate alloc] initWithCity:city
                                                              country:country
                                                             latitude:latitude
                                                            longitude:longitude];
    
        
        //NSString *listblock = [datiJson valueForKey:@"list"];
        NSArray *listBlock = [datiJson objectForKey:@"list"]; //Get block of data named 'list'
        int listBlockElements = (int)listBlock.count;
        
        NSMutableArray *weatherArray = [[NSMutableArray alloc] initWithCapacity:listBlockElements];
        
        for(int i = 0; i < listBlockElements; i++)
        {
            NSDictionary *iListBlock = [listBlock objectAtIndex:i]; //Get kei-value for i-list block
            
            
            MDWeather *weather = [[MDWeather alloc] initFromJson:iListBlock];
            
            //Set sunrise and sunset
            NSDate *date = weather.date;
            NSCalendar *calendar = [NSCalendar currentCalendar];
            
            //sunrise
            weather.sunrise = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
            int sunriseSeconds =[[cityblock valueForKey:@"sunrise"] intValue];
            int hour = ((sunriseSeconds % (24 * 3600)) / 3600);
            sunriseSeconds = sunriseSeconds % (24 * 3600);
            sunriseSeconds = sunriseSeconds % 3600;
            int minutes = sunriseSeconds / 60;
            [weather.sunrise setHour: hour];
            [weather.sunrise setMinute: minutes];
            //sunset
            weather.sunset = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
            int sunsetSeconds =[[cityblock valueForKey:@"sunset"] intValue];
            hour = ((sunsetSeconds % (24 * 3600)) / 3600);
            sunsetSeconds = sunsetSeconds % (24 * 3600);
            sunsetSeconds = sunsetSeconds % 3600;
            minutes = ((sunsetSeconds % (24 * 3600 * 3600)) / 60);
            [weather.sunset setHour: hour];
            [weather.sunset setMinute: minutes];
            
            [weatherArray addObject:weather];
        }
        
        MDForecast *forecast = [[MDForecast alloc] initWithCoordinate:coordinate
                                                         weatherArray:weatherArray];
        
        return forecast;
    }
    
    @catch (NSException *exception)
    {
        NSLog(@"ERRORE: %@", exception.reason);
    }
}

-(NSData *) testWeatherForCity:(NSString *)city
{
    NSError *error;
    NSURLResponse *response;
    
    @try
    {
        NSString *urlRequest = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?q=%@&appid=%@&units=metric", city, _apiKey]; //5 days
        //&lang=it for italian response

        NSLog(@"%@", urlRequest);
        
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlRequest]] returningResponse:&response error:&error];
        NSDictionary *datiJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]; //Get data format json to work with
        NSString *esitCode = [datiJson valueForKey:@"cod"];
        
        if(data) //There's a response
        {
            if([esitCode isEqualToString:@"404"]) //Error
                return nil;
            
            else
                return data;
        }
    }
    
    @catch (NSException *exception)
    {
        NSLog(@"ERRORE: %@", exception.reason);
    }
    
    return nil;
}

@end
