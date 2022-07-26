//
//  HomeViewController.m
//  MyWeather
//
//  Created by Luca on 25/07/22.
//

#import "HomeViewController.h"
#import "../../Library/UICustomElements/UIViewGradientColor/UIViewGradientColor.h"

/**Created for home view*/
@interface HomeViewController ()

@property(nonatomic, strong) UIViewGradientColor *uiViewGradientColor;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
