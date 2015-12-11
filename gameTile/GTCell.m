//
//  GTCell.m
//  testGame
//
//  Created by satyendra chauhan on 12/10/15.
//  Copyright © 2015 satyendra chauhan. All rights reserved.
//

#import "GTCell.h"

@implementation GTCell
@synthesize btnLatter=_btnLatter;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"GTCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
    }
    
    return self;
    
}
@end
