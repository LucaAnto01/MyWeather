//
//  DetailsViewController.h
//  MyWeather
//
//  Created by Luca on 09/08/22.
//

#import <UIKit/UIKit.h>
#import "../../Application/Services/ServiceWeather.h"
#import "../../Models/MDCoordinate.h"
#import "../../Models/MDWeather.h"
#import "../../Models/MDForecast.h"

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) ServiceWeather *serviceWeather;
@property (nonatomic, strong) MDForecast *forecast;

@end
