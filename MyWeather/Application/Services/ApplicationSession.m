//
//  ApplicationSession.m
//  MyWeather
//
//  Created by Luca on 05/09/22.
//

#import "ApplicationSession.h"

/**Attributes*/
static MDForecast *_currentForecast = nil; //Default value is nil
static MDForecast *_selectedForecast = nil; //Default value is nil
 
@implementation ApplicationSession

/**Method to set current Forecast*/
+ (void)setCurrentForecast:(MDForecast *) newCurrentForecast
{
    _currentForecast = newCurrentForecast;
}

/**Method to get current Forecast*/
+ (MDForecast *)getCurrentForecast
{
    return _currentForecast;
}

/**Method to set  selected Forecast*/
+ (void)setSelectedForecast:(MDForecast *) newSelectedForecast
{
    _selectedForecast = newSelectedForecast;
}

/**Method to get  selected Forecast*/
+ (MDForecast *)getSelectedForecast
{
    return _selectedForecast;
}

@end
