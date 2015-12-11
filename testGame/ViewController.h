//
//  ViewController.h
//  testGame
//
//  Created by satyendra chauhan on 12/10/15.
//  Copyright © 2015 satyendra chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTCell.h"
#import "GameHelper.h"

@interface ViewController : UIViewController<MyGameProto>

- (IBAction)randomizeLatters:(id)sender;
- (IBAction)latterAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *lblWord;
@property (strong,nonatomic) NSString *strLatters;
@property (strong,nonatomic) NSMutableString *strWords;
@property (strong, nonatomic) NSArray *arrayWords;

@end

