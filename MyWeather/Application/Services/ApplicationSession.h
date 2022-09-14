//
//  ApplicationSession.h
//  MyWeather
//
//  Created by Luca on 05/09/22.
//

#import "../../Models/MDForecast.h"
#import <Foundation/Foundation.h>

@interface ApplicationSession : NSObject

/**Method to set current Forecast*/
+ (void)setCurrentForecast:(MDForecast *) newCurrentForecast;
/**Method to get current Forecast*/
+ (MDForecast *)getCurrentForecast;
/**Method to set  selected Forecast*/
+ (void)setSelectedForecast:(MDForecast *) newSelectedForecast;
/**Method to get  selected Forecast*/
+ (MDForecast *)getSelectedForecast;

@end
