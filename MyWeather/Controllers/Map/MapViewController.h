//
//  MapViewController.h
//  MyWeather
//
//  Created by Luca on 29/07/22.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "../../Application/Services/ServiceWeather.h"
#import "../../Models/MDCoordinate.h"
#import "../../Models/MDWeather.h"
#import "../../Models/MDForecast.h"

@interface MapViewController : UIViewController

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,readwrite) CLLocationCoordinate2D userLocation;
@property (nonatomic, strong) NSMutableArray *favPlaces;
@property (nonatomic, strong) NSUserDefaults *favs;
@property (nonatomic, strong) ServiceWeather *serviceWeather;

/**Method to center the map*/
- (void) centerMapToLocation:(CLLocationCoordinate2D)location
                        zoom:(double)zoom;

/**Function call for update favorites*/
- (void) updateFavoritesPlaces;

/**Method to delete all the Annotations*/
- (void)removeMapAnnotations;

/**Method to display a popup in case of error*/
- (void) showAlertControl_withMessage:(NSString *)message;

@end
