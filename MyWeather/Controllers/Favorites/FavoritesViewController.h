//
//  FavoritesViewController.h
//  MyWeather
//
//  Created by Luca on 30/07/22.
//

#import <UIKit/UIKit.h>
#import "../../Application/Services/ServiceWeather.h"
#import "../../Models/MDCoordinate.h"
#import "../../Models/MDWeather.h"
#import "../../Models/MDForecast.h"

@interface FavoritesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ServiceWeather *serviceWeather;
@property (nonatomic, strong) NSMutableArray *favForecast;
@property (nonatomic, strong) NSUserDefaults *favs;

/**Function call for update data of table view*/
- (void)refreshTableView;

/**Function call for update favorites*/
- (void) updateFavoritesWeather;

/**Method to display a popup in case of error*/
- (void) showAlertControl_withMessage:(NSString *)message;

@end
