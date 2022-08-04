//
//  CurrentViewController.h
//  MyWeather
//
//  Created by Luca on 29/07/22.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "../../Application/Services/ServiceWeather.h"
#import "../../Models/MDCoordinate.h"
#import "../../Models/MDWeather.h"
#import "../../Models/MDForecast.h"

@interface CurrentViewController : UIViewController

@property (nonatomic, strong) ServiceWeather *serviceWeather;
//@property (nonatomic, strong) UIViewGradientColor *uiViewGradientColor;


/**Method for update the view*/
-(void) updateView;

@end
