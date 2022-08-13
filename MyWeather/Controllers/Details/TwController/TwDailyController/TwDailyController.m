//
//  TwDailyController.m
//  MyWeather
//
//  Created by Luca on 12/08/22.
//

#import "TwDailyController.h"
#import "../../../../Library/UICustomElements/UIDetailsWeatherTableCell/DetailWeatherTableCell.h"

@interface TwDailyController ()

@end

@implementation TwDailyController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**Method for setting the number of Weather cell of the table*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _todayHoursWeather.count;
}

/**Method for setting the height of Weather cell*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 55; //In according with the height of the object
}

/**Method to get a table view cell*/
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        static NSString *identifier = @"DetailWeatherCell";
        
        DetailWeatherTableCell *detailWeatherCell = (DetailWeatherTableCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        if(!detailWeatherCell)
        {
            NSArray *nswth = [[NSBundle mainBundle] loadNibNamed:@"DetailWeatherTableCell" owner:self options:nil]; //Method found on stackoverflow --> create an object with certain name
            detailWeatherCell = [nswth objectAtIndex:0];
        }
        
        NSInteger i = indexPath.row;
 
        detailWeatherCell.weather = _todayHoursWeather[i];
    
        detailWeatherCell.lbWeather.text = [_todayHoursWeather[i] getWeatherImage];
        detailWeatherCell.lbMaxTmp.text = [NSString stringWithFormat:@"%.2f °C", detailWeatherCell.weather.maxTemperature];
        detailWeatherCell.lbMinTmp.text = [NSString stringWithFormat:@"%.2f °C", detailWeatherCell.weather.minTemperature];
        
        return detailWeatherCell;
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
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Table view Daily controller"
                               message:message
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"ERRORE: %@", message);
}

@end
