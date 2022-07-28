//
//  HomeViewController.m
//  MyWeather
//
//  Created by Luca on 25/07/22.
//

#import "HomeViewController.h"
#import "../../Library/UICustomElements/UIViewGradientColor/UIViewGradientColor.h"
#import "../../Application/Services/ServiceWeather.h"
#import "../../Models/MDCoordinate.h"
#import "../../Models/MDWeather.h"
#import "../../Models/MDForecast.h"
#import <CoreLocation/CoreLocation.h>

/**Created for home view*/
@interface HomeViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) ServiceWeather *serviceWeather;
@property (nonatomic, strong) UIViewGradientColor *uiViewGradientColor;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MDForecast *forecast;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    _uiViewGradientColor = [[UIViewGradientColor alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:_uiViewGradientColor];
    
    _uiViewGradientColor.translatesAutoresizingMaskIntoConstraints = false;
    [_uiViewGradientColor.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = true;
    [_uiViewGradientColor.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;
    [_uiViewGradientColor.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
    [_uiViewGradientColor.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
}

- (CLLocationManager *)locationManager
{
    if(!_locationManager)
        _locationManager = [[CLLocationManager alloc] init];

    return _locationManager;
}

//Call when position is change and update
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    if(currentLocation != nil)
    {
        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
        
        [_serviceWeather updateLatitude:coords.latitude
                              longitude:coords.longitude]; //Update location to get date of the new location
        
        @try
        {
            [_serviceWeather updateData]; //Update data about new location
        }
        
        @catch (NSException *exception)
        {
            NSString *error = exception.reason;
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Home view controller"
                                       message:error
                                       preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {}];

            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            NSLog(@"ERRORE: %@", exception.reason);
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
