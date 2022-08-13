//
//  DetailWeatherTableCell.h
//  MyWeather
//
//  Created by Luca on 13/08/22.
//

#import <UIKit/UIKit.h>
#import "../../../Models/MDCoordinate.h"
#import "../../../Models/MDWeather.h"
#import "../../../Models/MDForecast.h"

@interface DetailWeatherTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbDayHour;
@property (weak, nonatomic) IBOutlet UILabel *lbWeather;
@property (weak, nonatomic) IBOutlet UILabel *lbMaxTmp;
@property (weak, nonatomic) IBOutlet UILabel *lbMinTmp;


@property (nonatomic, strong) MDWeather *weather;

@end
