//
//  HomeViewController.m
//  MyWeather
//
//  Created by Luca on 25/07/22.
//

#import "HomeViewController.h"
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
@property (nonatomic, strong) MDForecast *forecast;
@property (nonatomic, strong) NSUserDefaults *favs;
@property (weak, nonatomic) IBOutlet UITabBar *tbHome;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @try
    {
        [self setSelectedIndex:1];
        
        self.delegate = self;
        
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

#pragma mark - Tab bar managing

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
            mvc.serviceWeather = _serviceWeather;
            [mvc updateFavoritesPlaces];
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

#pragma mark - Show error

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

@end
