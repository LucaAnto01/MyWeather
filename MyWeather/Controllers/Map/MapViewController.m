//
//  MapViewController.m
//  MyWeather
//
//  Created by Luca on 29/07/22.
//

#import "MapViewController.h"
#import "../../Library/UICustomElements/UIViewGradientColor/UIViewGradientColor.h"
#import "../../Application/Services/ServiceWeather.h"
#import "../../Models/MDCoordinate.h"
#import "../../Models/MDWeather.h"
#import "../../Models/MDForecast.h"

@interface MapViewController ()

@property (nonatomic, strong) UIViewGradientColor *uiViewGradientColor;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
