//
//  HomeViewController.h
//  MyWeather
//
//  Created by Luca on 25/07/22.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UITabBarController <UITabBarControllerDelegate>

/**Method to display a popup in case of error*/
- (void) showAlertControl_withMessage:(NSString *)message;

@end
