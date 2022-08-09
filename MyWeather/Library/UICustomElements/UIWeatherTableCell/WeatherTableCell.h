//
//  WeatherTableCell.h
//  MyWeather
//
//  Created by Luca on 30/07/22.
//

#import <UIKit/UIKit.h>
#import "../../../Models/MDCoordinate.h"
#import "../../../Models/MDWeather.h"
#import "../../../Controllers/Favorites/FavoritesViewController.h"

@interface WeatherTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UILabel *lbWeather;
@property (weak, nonatomic) IBOutlet UILabel *lbMaxTemperature;
@property (weak, nonatomic) IBOutlet UILabel *lbMinTemperature;

@property (nonatomic, strong) MDWeather *weather;
@property (nonatomic, strong) MDCoordinate *coordinate;
@property (nonatomic, strong) NSUserDefaults *favs;
@property (nonatomic, strong) FavoritesViewController *fvcRef;

@end
