//
//  UIViewGradientColor.m
//  MyWeather
//
//  Created by Luca on 26/07/22.
//

#import "UIViewGradientColor.h"

@implementation UIViewGradientColor

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (Class) layerClass
{
    return [CAGradientLayer class];
}

/**Create gradient background*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
        gradientLayer.colors = [[NSArray alloc] initWithObjects: (id)[[UIColor blueColor] CGColor], (id)[[UIColor cyanColor] CGColor], nil];
        
        NSMutableArray *posArray = [NSMutableArray arrayWithObjects: [NSNumber numberWithDouble:0.0], [NSNumber numberWithDouble:1.2], nil];
        
        gradientLayer.locations = posArray;
    }
    
    return self;
}

@end
