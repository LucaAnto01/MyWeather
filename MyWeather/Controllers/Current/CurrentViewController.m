//
//  CurrentViewController.m
//  MyWeather
//
//  Created by Luca on 29/07/22.
//

#import "CurrentViewController.h"
#import "../../Library/UICustomElements/UIViewGradientColor/UIViewGradientColor.h"
#import "../../Application/Services/ApplicationSession.h"
#import "../../Application/Services/ServiceWeather.h"
#import "../../Models/MDCoordinate.h"
#import "../../Models/MDWeather.h"
#import "../../Models/MDForecast.h"
#import "../DetailScrool/DetailScrollViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface CurrentViewController () <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UILabel *lbTemperature;
@property (weak, nonatomic) IBOutlet UILabel *lbShortDescription;
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
@property (weak, nonatomic) IBOutlet UILabel *lbWeather;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MDForecast *forecast;
@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;

@end

@implementation CurrentViewController

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
        
        
        /**Service weather initialisation*/
        _serviceWeather = [[ServiceWeather alloc] initWithOnlyApiKey:@"54aff794f6a91b91263ea8c5362fe6f0"];
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

/**Click on button update*/
- (IBAction)btUpdateClick:(UIButton *)sender
{
    @try
    {
        [self updateView]; //Update view
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
    
}


/**Method for update the view*/
- (void) updateView
{
    @try
    {
        _forecast = [_serviceWeather getForecastWith_latitude:_latitude
                                                    longitude:_longitude]; //Get forecast
        
        //Update the current forecast in session
        [ApplicationSession setCurrentForecast:_forecast];
        
        if(_forecast)
        {
            _lbCity.text = [NSString stringWithFormat:@"%@, %@", _forecast.coordinate.city, _forecast.coordinate.country];
            MDWeather *actualWeather = _forecast.weatherArray[0];
            _lbTemperature.text = [NSString stringWithFormat:@"%.2f°C", actualWeather.temperature];
            
            NSString *shortDescription = [NSString stringWithFormat:@"%@", actualWeather.weather];
            NSString *description = [NSString stringWithFormat:@"%@", actualWeather.weatherDescription];

            //Set value of lables
            _lbShortDescription.text = shortDescription;
            _lbDescription.text = description;
            
            NSString *weatherImage = [actualWeather getWeatherImage];
            _lbWeather.text = weatherImage;
        }
        
        else
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Current view controller"
                                       message:@"Check your connection"
                                       preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {}];

            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
    
}

- (CLLocationManager *)locationManager
{
    @try
    {
        if(!_locationManager)
            _locationManager = [[CLLocationManager alloc] init];
    }
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
    @finally
    {
        return _locationManager;
    }
}

//Call when position is change and update
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    @try
    {
        CLLocation *currentLocation = [locations lastObject];
        
        if(currentLocation != nil)
        {
            CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
            _latitude = coords.latitude;
            _longitude = coords.longitude;
            
            [self updateView]; //Update location to get data of the new location
        }
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
}

/**Segue method*/
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    @try
    {
        if([segue.identifier isEqualToString:@"navInfo"])
        {
            if([segue.destinationViewController isKindOfClass:[DetailScrollViewController class]])
            {
                DetailScrollViewController *sdvc = (DetailScrollViewController *) segue.destinationViewController;
                sdvc.serviceWeather = self.serviceWeather; //Set serviceWeather
                sdvc.forecast = _forecast;
                                
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

#pragma mark - Show error

/**Method to display a popup in case of error*/
- (void) showAlertControl_withMessage:(NSString *)message
{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Current view controller"
                               message:message
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"ERRORE: %@", message);
}

@end
