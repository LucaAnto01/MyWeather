//
//  MDCoordinate.h
//  MyWeather
//
//  Created by Luca on 25/07/22.
//

#import <Foundation/Foundation.h>

@interface MDCoordinate : NSObject
{
    /**Attributes*/
    @private
        NSString *_city;
        NSString *_country;
        double _latitude;
        double _longitude;
}

/**Complete constructor*/
- (instancetype) initWithCity:(NSString *)city
                      country:(NSString *)country
                     latitude:(double)latitude
                    longitude:(double)longitude;

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;

@end
