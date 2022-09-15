//
//  AddFavoritesViewController.m
//  MyWeather
//
//  Created by Luca on 03/08/22.
//

#import "AddFavoritesViewController.h"

@interface AddFavoritesViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfNewFavorite;

@end

@implementation AddFavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tfNewFavorite.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}

/**Click on button for adding a new favorite location*/
- (IBAction)btAddClick:(id)sender
{
    @try
    {
        if((![self.tfNewFavorite.text isEqualToString:@"City of interest"]) && (![self.tfNewFavorite.text isEqualToString:@""])) //If the user wrote something
        {
            NSData *data = [_serviceWeather testWeatherForCity:self.tfNewFavorite.text]; //Try to do a request
            
            if(data)
            {
                NSError *error;
                NSDictionary *datiJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]; //Get data format json to work with
                NSString *cityblock = [datiJson valueForKey:@"city"];
                NSString *city = [cityblock valueForKey:@"name"];
                NSString *country = [cityblock valueForKey:@"country"];
                
                NSArray *coordinateBlock = [cityblock valueForKey:@"coord"];
                double latitude = [[coordinateBlock valueForKey:@"lat"] doubleValue] ;
                double longitude = [[coordinateBlock valueForKey:@"lon"] doubleValue];
                //Parma;IT;44.8036;10.33" forKey:@"Weather_ParmaIT"
                NSString *newFavCity = [NSString stringWithFormat:@"%@;%@;%.3f;%.3f", city, country, latitude, longitude];
                NSString *newFavKey = [NSString stringWithFormat:@"Weather_%@%@", city, country];
                
                if((newFavCity) && (newFavKey))
                {
                    [_favs setObject:newFavCity forKey:newFavKey];
                    [self showAlertControl_withMessage:@"New favorite city successfully added"];
                }
                    
                
            }
            
            else
                [self showAlertControl_withMessage:@"Invalid city"];
        }
        
        else
        {
            [self showAlertControl_withMessage:@"Insert city"];
            self.tfNewFavorite.textColor = [UIColor redColor]; //Set color to red
        }
    }
    
    @catch (NSException *exception)
    {
        [self showAlertControl_withMessage:exception.reason];
    }
}

/**Start editing*/
- (IBAction)startEditing:(id)sender
{
    self.tfNewFavorite.text = @"";
    self.tfNewFavorite.textColor = [UIColor blackColor]; //Set color to black
}

/**Click return --> close keyboard**/
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Show error

/**Method to display a popup in case of error*/
- (void) showAlertControl_withMessage:(NSString *)message
{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Add favorites view controller"
                               message:message
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"ERRORE: %@", message);
}

@end
