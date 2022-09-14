//
//  WeatherTableCell.m
//  MyWeather
//
//  Created by Luca on 30/07/22.
//

#import "WeatherTableCell.h"

@implementation WeatherTableCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)btRemoveClick:(id)sender
{
    @try
    {
        [_favs removeObjectForKey:[NSString stringWithFormat:@"Weather_%@%@", _coordinate.city, _coordinate.country]];
        [_fvcRef refreshTableView];
    }
    
    @catch (NSException *exception)
    {
        [self printAlertControl_withMessage:exception.reason];
    }
    NSLog(@"%@", _lbCity.text);
}

/**Method to display a popup in case of error*/
- (void) printAlertControl_withMessage:(NSString *)message
{
    NSLog(@"ERRORE: %@", message);
}

@end
