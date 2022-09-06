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
#import <CoreLocation/CoreLocation.h>

@interface MapViewController () <MKMapViewDelegate/*, CLLocationManagerDelegate*/>

@property (strong, nonatomic) IBOutlet MKMapView *mkMapView;

@property (nonatomic,strong) CLLocationManager *locationManager;

- (void) centerMapToLocation:(CLLocationCoordinate2D)location
                        zoom:(double)zoom;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @try
    {
        /**Location manager initialisation*/
        _locationManager = [[CLLocationManager alloc]init]; //Alloc
        _locationManager.delegate = (id)self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; //Set precision
        
        if([_locationManager respondsToSelector:@selector((requestWhenInUseAuthorization))])
        {
            [_locationManager requestWhenInUseAuthorization];
        }
        
        [_locationManager startUpdatingLocation]; //Update position
        
        
        self.mkMapView.delegate = self;
        
        [self centerMapToLocation:CLLocationCoordinate2DMake(44.801700,10.328012)
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
