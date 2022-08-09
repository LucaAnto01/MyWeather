//
//  DetailsViewController.m
//  MyWeather
//
//  Created by Luca on 09/08/22.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (nonatomic, strong) NSMutableArray *dailyWeather;
@property (nonatomic, strong) NSMutableArray *todayHoursWeather;

@end

@implementation DetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}

/**Method to set daily weather array, splitting the data*/
- (void) setDailyWeather
{
    @try
    {
        //
    }
    @catch (NSException *exception)
    {
        
        [self showAlertControl_withMessage:exception.reason];
    }
}

/**Method to display a popup in case of error*/
- (void) showAlertControl_withMessage:(NSString *)message
{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Details view controller"
                               message:message
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"ERRORE: %@", message);
}

@end
