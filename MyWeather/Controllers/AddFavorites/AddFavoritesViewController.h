//
//  AddFavoritesViewController.h
//  MyWeather
//
//  Created by Luca on 03/08/22.
//

#import <UIKit/UIKit.h>
#import "../../Application/Services/ServiceWeather.h"

@interface AddFavoritesViewController : UIViewController

@property (nonatomic, strong) ServiceWeather *serviceWeather;
@property (nonatomic, strong) NSUserDefaults *favs;

@end
