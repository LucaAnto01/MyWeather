//
//  MapViewController.m
//  MyWeather
//
//  Created by Luca on 29/07/22.
//

#import "MapViewController.h"
#import "../../Library/UICustomElements/UIViewGradientColor/UIViewGradientColor.h"
#import "../../Application/Services/ServiceWeather.h"
#import "../../Models/MDCoordinate.h"
#import "../../Models/MDWeather.h"
#import "../../Models/MDForecast.h"
#import "../../Models/MDWeaCoord+MapAnnotation.h"
#import "../DetailScrool/DetailScrollViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mkMapView;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @try
    {
        /**Variables initialisation*/
        _favs = [NSUserDefaults standardUserDefaults];
        _favPlaces = [[NSMutableArray alloc] init];
        
        /**Location manager initialisation*/
        _locationManager = [[CLLocationManager alloc]init]; //Alloc
        _locationManager.delegate = (id)self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; //Set precision
        
        if([_locationManager respondsToSelector:@selector((requestWhenInUseAuthorization))])
        {
            [_locationManager requestWhenInUseAuthorization];
        }
        
        [_locationManager startUpdatingLocation]; //Update position
        
        
        //Setting map
        self.mkMapView.delegate = self;
        
        
        self.mkMapView.showsUserLocation = YES;
        
        [_mkMapView setCenterCoordinate:_mkMapView.userLocation.coordinate animated:YES];
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}

/**Method to center the map*/
- (void) centerMapToLocation:(CLLocationCoordinate2D)location
                        zoom:(double)zoom
{
    @try
    {
        MKCoordinateRegion mapRegion;
        mapRegion.center = location;
        mapRegion.span.latitudeDelta = zoom;
        mapRegion.span.longitudeDelta = zoom;
        [self.mkMapView setRegion:mapRegion animated:YES];
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
}

//Call when position is change and update
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    @try
    {
        CLLocation *currentLocation = [locations lastObject];
        
        if(currentLocation != nil)
            _userLocation = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
        
        [self centerMapToLocation:CLLocationCoordinate2DMake(_userLocation.latitude,_userLocation.longitude)
                             zoom:0.1]; //Center map where's the user
        
        //Getting the meteo info for the current position and generate the map annotation
        MDForecast *newForecast = [_serviceWeather getForecastWith_latitude:currentLocation.coordinate.latitude
                                                                  longitude:currentLocation.coordinate.longitude];
        
        MDWeather *currentWeather = newForecast.weatherArray[0];
        
        MDWeatherCoordinate *weatherCoordinate = [[MDWeatherCoordinate alloc] initWithWeather:currentWeather.weather
                                                                           weatherDescription:currentWeather.weatherDescription
                                                                                 weatherImage:currentWeather.getWeatherImage
                                                                                     latitude:newForecast.coordinate.latitude
                                                                                    longitude:newForecast.coordinate.longitude
                                                                                     forecast:newForecast];

        [self.mkMapView addAnnotation:weatherCoordinate]; //Add map annotation to map

    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
}

/**Function call for update favorites*/
- (void) updateFavoritesPlaces
{
    @try
    {
        [_favPlaces removeAllObjects]; //Clean array
        [self removeMapAnnotations];   //Clean map from annotation
        
        for (NSString* currentKey in _favs.dictionaryRepresentation.allKeys)
        {
            NSArray *arrayResultKey= [currentKey componentsSeparatedByString:@"_"];
            if([[arrayResultKey objectAtIndex:0] isEqual:@"Weather"]) //If is a key, so an element,  of interest
            {
                NSString *resultToSPlit = [_favs stringForKey:currentKey];
                //Example of syntax --> Zurigo;CH;47.366670;8.55
                NSArray *arrayOfComponents = [resultToSPlit componentsSeparatedByString:@";"];
                
                /*NSString *lat = [arrayOfComponents objectAtIndex:2];
                NSString *lon = [arrayOfComponents objectAtIndex:3];*/
                
                MDForecast *newForecast = [_serviceWeather getForecastWith_latitude:[[arrayOfComponents objectAtIndex:2] doubleValue]
                                                                          longitude:[[arrayOfComponents objectAtIndex:3] doubleValue]];
                
                [_favPlaces addObject:newForecast]; //Forecast in the i-pleace
                
                MDWeather *currentWeather = newForecast.weatherArray[0];
                
                MDWeatherCoordinate *weatherCoordinate = [[MDWeatherCoordinate alloc] initWithWeather:currentWeather.weather
                                                                                   weatherDescription:currentWeather.weatherDescription
                                                                                         weatherImage:currentWeather.getWeatherImage
                                                                                             latitude:newForecast.coordinate.latitude
                                                                                            longitude:newForecast.coordinate.longitude
                                                                                             forecast:newForecast];

                [self.mkMapView addAnnotation:weatherCoordinate]; //Add map annotation to map
                
            }
        }
        
        NSInteger numberOfFavCities = _favPlaces.count;
        
        if(numberOfFavCities == 0)
            [self showAlertControl_withMessage:@"You have not entered any favorite locations yet"];
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
    
}

/**Method to delete all the Annotations*/
- (void)removeMapAnnotations
{
    id userLocation = [_mkMapView userLocation];
    [_mkMapView removeAnnotations:[_mkMapView annotations]];

    if ( userLocation != nil )
        [_mkMapView addAnnotation:userLocation]; // restore the user location pin
    
}

/**Method to add an MKAnnotation to view*/
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    @try
    {
        static NSString* PinReuseIdentifier = @"MDWeatherAnnotation";
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: PinReuseIdentifier];
        
        if (!annotationView)
        {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: PinReuseIdentifier];
            annotationView.canShowCallout = YES;
        }
        
        annotationView.annotation = annotation;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
        
        return annotationView;
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if([control isEqual:view.rightCalloutAccessoryView])
        [self performSegueWithIdentifier:@"navAddFav" sender:view];
}

/**Segue method*/
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    @try
    {
        if([segue.identifier isEqualToString:@"navAddFav"])
        {
            if([segue.destinationViewController isKindOfClass:[DetailScrollViewController class]])
            {
                DetailScrollViewController *sdvc = (DetailScrollViewController *) segue.destinationViewController;
                sdvc.serviceWeather = self.serviceWeather; //Set serviceWeather
                
                MKAnnotationView *view= (MKAnnotationView *)sender;
                id<MKAnnotation> annotation = view.annotation;
                if([annotation isKindOfClass:[MDWeatherCoordinate class]])
                {
                    MDWeatherCoordinate *weatherCoordinate = (MDWeatherCoordinate *)annotation;
                    sdvc.forecast = weatherCoordinate.forecast;
                }
                                
                [sdvc populateTodayHoursWeather];
                [sdvc populateWeeklyWeather];
            }
        }
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
}

/*- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if([view.leftCalloutAccessoryView isKindOfClass:[UIImageView class]]){
        __block UIImageView *imageView = (UIImageView *)view.leftCalloutAccessoryView;
        id<MKAnnotation> annotation = view.annotation;
        if([annotation isKindOfClass:[City class]]) {
            City *city = (City *)annotation;
            dispatch_queue_t queue = dispatch_queue_create("get_meteo_information", NULL);
            // get meteo informations to update callout view's image
            dispatch_async(queue, ^{
                NSString *urlString = [NSString stringWithFormat: @"https://api.open-meteo.com/v1/forecast?latitude=%f&longitude=%f&current_weather=true", city.latitude, city.longitude];
                NSURL *url = [NSURL URLWithString:urlString];
                NSData *data = [NSData dataWithContentsOfURL:url];
                id value = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSDictionary *weather = (NSDictionary *)value;
                // get current weather informations
                NSDictionary *current_weather = [weather valueForKey:@"current_weather"];
                NSNumber *weathercode = [current_weather valueForKey:@"weathercode"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = [self imageForWeatherCode:weathercode.intValue];
                });
            });
        }
    }
}*/

#pragma mark - Show error

/**Method to display a popup in case of error*/
- (void) showAlertControl_withMessage:(NSString *)message
{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Map view controller"
                               message:message
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"ERRORE: %@", message);
}

@end
