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
#import "../Current/CurrentViewController.h"
#import "../Map/MapViewController.h"
#import "../Favorites/FavoritesViewController.h"
#import <CoreLocation/CoreLocation.h>

/**Created for home view*/
@interface HomeViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) ServiceWeather *serviceWeather;
@property (nonatomic, strong) UIViewGradientColor *uiViewGradientColor;
//@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MDForecast *forecast;
@property (nonatomic, strong) NSUserDefaults *favs;
@property (weak, nonatomic) IBOutlet UITabBar *tbHome;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setSelectedIndex:1];
    //[_tbHome setSelectedItem: [_tbHome.items objectAtIndex:1]];
    
    //[_tbHome selectedItem: [_tbHome.items objectAtIndex:0]];
    //self.tbHome.selectedItem = [_tbHome.items objectAtIndex:1];
    
    
    //NSString *textToLoad = [favs stringForKey:@"Weather_ParmaIT"];
    
    @try
    {
        self.delegate = self;
        
        /**Get favorites*/
        /*_favs = [NSUserDefaults standardUserDefaults];
        //Data using to store some favorite location
        [_favs setObject:@"Parma;IT;44.8036;10.33" forKey:@"Weather_ParmaIT"];
        [_favs setObject:@"Zurigo;CH;47.366670;8.55" forKey:@"Weather_ZurigoCH"];
        [_favs setObject:@"Sydney;AUS;-33.86785;151.20732" forKey:@"Weather_SydneyAU"];*/
        
        /**Location manager initialisation*/
        /*_locationManager = [[CLLocationManager alloc]init]; //Alloc
        _locationManager.delegate = (id)self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; //Set precision
        
        if([_locationManager respondsToSelector:@selector((requestWhenInUseAuthorization))])
        {
            [_locationManager requestWhenInUseAuthorization];
        }
        
        [_locationManager startUpdatingLocation]; //Update position*/
        
        
        /**Service weather initialisation*/
        _serviceWeather = [[ServiceWeather alloc] initWithOnlyApiKey:@"54aff794f6a91b91263ea8c5362fe6f0"];
    }
    
    @catch (NSException *exception)
    {
        NSString *error = exception.reason;
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Current view controller"
                                   message:error
                                   preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {}];

        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        NSLog(@"ERRORE: %@", exception.reason);
    }
    
    //_uiViewGradientColor = [[UIViewGradientColor alloc] initWithFrame:CGRectZero];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}

/*- (CLLocationManager *)locationManager
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
        
        @try
        {
            _forecast = [_serviceWeather getForecastWith_latitude:coords.latitude
                                                        longitude:coords.longitude]; //Get forecast
            
            if(!_forecast)
            {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Home view controller"
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
            NSString *error = exception.reason;
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Current view controller"
                                       message:error
                                       preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {}];

            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            NSLog(@"ERRORE: %@", exception.reason);
        }
    }
}*/

/**Method called when ther's a click event on tabbar*/
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    @try
    {
        //If select CurrentViewController
        if([viewController isKindOfClass: [CurrentViewController class]])
        {
            CurrentViewController *cvc = (CurrentViewController *) viewController;
            cvc.serviceWeather = _serviceWeather;
            //cvc.locationManager = _locationManager;
            //cvc.forecast = _forecast;
            [cvc updateView];
        }
        
        //If select MapViewController
        else if([viewController isKindOfClass: [MapViewController class]])
        {
            MapViewController *mvc = (MapViewController *) viewController;
            //hash.userArray = feed.userArray;
        }
        
        //If select FavoritesViewController
        else if([viewController isKindOfClass: [FavoritesViewController class]])
        {
            FavoritesViewController *fvc = (FavoritesViewController *) viewController;
            fvc.serviceWeather = _serviceWeather;
            [fvc refreshTableView];
            //hash.userArray = feed.userArray;
        }
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
}

/**Method to display a popup in case of error*/
- (void) showAlertControl_withMessage:(NSString *)message
{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Home view controller"
                               message:message
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"ERRORE: %@", message);
}

/**Method called up when switching to current view controller*/
/*- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"currentNav"])
    {
        if([segue.destinationViewController isKindOfClass:[CurrentViewController class]])
        {
            CurrentViewController *cvc = (CurrentViewController *) segue.destinationViewController;
            //cvc.serviceWeather = _serviceWeather;
            //cvc.forecast = _forecast;
            
        }
    }
    
    if([segue.identifier isEqualToString:@"mapNav"])
    {
        if([segue.destinationViewController isKindOfClass:[MapViewController class]])
        {
            MapViewController *cvc = (MapViewController *) segue.destinationViewController;
            //cvc.serviceWeather = _serviceWeather;
            //cvc.forecast = _forecast;
            
        }
    }
    
    if([segue.identifier isEqualToString:@"favoritesNav"])
    {
        if([segue.destinationViewController isKindOfClass:[FavoritesViewController class]])
        {
            FavoritesViewController *fvc = (FavoritesViewController *) segue.destinationViewController;
            //cvc.serviceWeather = _serviceWeather;
            //cvc.forecast = _forecast;
            
        }
    }
}*/

@end
