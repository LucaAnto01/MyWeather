//
//  MDForecast.h
//  MyWeather
//
//  Created by Luca on 25/07/22.
//

#import <Foundation/Foundation.h>
#import "MDCoordinate.h"
#import "MDWeather.h"

@interface MDForecast : NSObject

{
    @private
        MDCoordinate *_coordinate;
        NSMutableArray *_weatherArray;
}

/**Constructor method*/
- (instancetype) initWithCoordinate:(MDCoordinate *)coordinate
                       weatherArray:(NSMutableArray *)weatherArray;

@property (nonatomic, strong) MDCoordinate *coordinate;
@property (nonatomic, strong) NSMutableArray *weatherArray;

@end

