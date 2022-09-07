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
        
        [self centerMapToLocation:CLLocationCoordinate2DMake(_userLocation.latitude,_userLocation.longitude)
                             zoom:0.1];
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
                                                                                            longitude:newForecast.coordinate.longitude];
                //weatherCoordinate.coordinate = newForecast.coordinate;
                //weatherCoordinate.weather = newForecast.weatherArray[0];
                [self.mkMapView addAnnotation:weatherCoordinate];
                
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
        //Customize annotationView

        /*UILabel *lbWeather =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
        lbWeather.text = @"";
        annotationView.leftCalloutAccessoryView = lbWeather;*/
        
        return annotationView;
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
    
    return nil;
}

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
