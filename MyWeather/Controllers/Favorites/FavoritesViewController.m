//
//  FavoritesViewController.m
//  MyWeather
//
//  Created by Luca on 30/07/22.
//

#import "FavoritesViewController.h"
#import "../../Library/UICustomElements/UIWeatherTableCell/WeatherTableCell.h"

@interface FavoritesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *twFavorites;
@property (nonatomic, strong) NSMutableArray *favForecast;
@property (nonatomic, strong) NSUserDefaults *favs;

@end

@implementation FavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    @try
    {
        self.twFavorites.delegate = self; //Set delegate
        self.twFavorites.dataSource = self; //Set deta source
        
        self.twFavorites.refreshControl = [[UIRefreshControl alloc]init]; //Create a refresh control
        [self.twFavorites.refreshControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
        
        _favs = [NSUserDefaults standardUserDefaults];
        _favForecast = [[NSMutableArray alloc] init];
        //[self refreshTableView];
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

/**Method to get a table view cell*/
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"WeatherCell";
    
    WeatherTableCell *weatherCell = (WeatherTableCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!weatherCell)
    {
        NSArray *nswth = [[NSBundle mainBundle] loadNibNamed:@"WeatherTableCell" owner:self options:nil]; //Method found on stackoverflow --> create an object with certain name
        weatherCell = [nswth objectAtIndex:0];
        
    }
    
    NSInteger i = indexPath.row;
    MDForecast *forecast = [_favForecast objectAtIndex:i];
    MDWeather *actualWeather = forecast.weatherArray[0];
    MDCoordinate *coordinate = forecast.coordinate;
    
    weatherCell.weather = actualWeather;
    weatherCell.coordinate = coordinate;
    
    weatherCell.lbCity.text = weatherCell.coordinate.city;
    weatherCell.lbWeather.text = [forecast getWeatherImage_fromIndex:0];
    weatherCell.lbMaxTemperature.text = [NSString stringWithFormat:@"%.2f °C", weatherCell.weather.maxTemperature];
    weatherCell.lbMinTemperature.text = [NSString stringWithFormat:@"%.2f °C", weatherCell.weather.minTemperature];
    
    //Set lbWeather
    //if(
    
    return weatherCell;
}

/**Method for setting the height of Weather cell*/
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55; //In according with the height of the object
}

/**Method for setting the number of Weather cell of the table*/
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _favForecast.count;
}

/**Function call for update data of table view*/
- (void) refreshTableView
{
    [self updateFavoritesWeather];
    
    [self.twFavorites.refreshControl endRefreshing];
    [self.twFavorites reloadData];
}

/**Function call for update favorites*/
- (void) updateFavoritesWeather
{
    [_favForecast removeAllObjects]; //Clean array
    
    for (NSString* currentKey in _favs.dictionaryRepresentation.allKeys)
    {
        NSArray *arrayResultKey= [currentKey componentsSeparatedByString:@"_"];
        if([[arrayResultKey objectAtIndex:0] isEqual:@"Weather"]) //If is a key, so an element,  of interest
        {
            NSString *resultToSPlit = [_favs stringForKey:currentKey];
            //Example of syntax --> Zurigo;CH;47.366670;8.55
            NSArray *arrayOfComponents = [resultToSPlit componentsSeparatedByString:@";"];
            
            NSString *lat = [arrayOfComponents objectAtIndex:2];
            NSString *lon = [arrayOfComponents objectAtIndex:3];
            
            MDForecast *newForecast = [_serviceWeather getForecastWith_latitude:[[arrayOfComponents objectAtIndex:2] doubleValue]
                                                                      longitude:[[arrayOfComponents objectAtIndex:3] doubleValue]];
            
            [_favForecast addObject:newForecast];
        }
        
        /*NSString *resultToSPlit = [_favs stringForKey:currentKey];
        NSArray *arrayOfComponents = [resultToSPlit componentsSeparatedByString:@";"];
        
        if([arrayOfComponents objectAtIndex:1])
            NSLog(@"%@", [arrayOfComponents objectAtIndex:0]);*/
        // do stuff
    }
    
}

@end
