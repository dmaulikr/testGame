//
//  ViewController.m
//  testGame
//
//  Created by satyendra chauhan on 12/10/15.
//  Copyright © 2015 satyendra chauhan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.strWords=[[NSMutableString alloc]init];
    
    [self.collectionView registerClass:[GTCell class] forCellWithReuseIdentifier:@"cvCell"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(70, 70)];
   
    [self.collectionView setCollectionViewLayout:flowLayout];

    [self performSelector:@selector(randomizeLatters:) withObject:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)randomizeLatters:(id)sender {
    NSString *str=[self randomStringWithLength:12];
    self.strLatters=str;
    self.lblWord.text=@"";
    self.strWords=[[NSMutableString alloc]init];
    self.lblWord.textColor=[UIColor blackColor];
    NSLog(@"%@",str);
    BOOL isValidated=[[GameHelper shareInstance]validate:str];
    if(isValidated){
        [self.collectionView reloadData];
    }else{
        [self randomizeLatters:nil];
    }
}

- (IBAction)latterAction:(UIButton *)btnltr {
    NSLog(@"%@",btnltr.titleLabel.text);
    [self.strWords appendString:btnltr.titleLabel.text];
    self.lblWord.text=self.strWords;
    GameHelper *gamH=[GameHelper shareInstance];
    gamH.delegate=self;
    BOOL isMatched=[gamH matchWord:self.strWords];
    if(isMatched){
        
    }
    btnltr.hidden=YES;
}

#pragma mark - UICollectionview Delegate and Datasources

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.strLatters.length;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cvCell";
    GTCell *cell = (GTCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.btnLatter.hidden=NO;
    [cell.btnLatter setTitle:[NSString stringWithFormat:@"%C",[self.strLatters characterAtIndex:indexPath.row]] forState:UIControlStateNormal];
    [cell.btnLatter setBackgroundColor:[self getRandomColors]];
    return cell;
    
}

#pragma mark - Utility Methods
-(UIColor *)getRandomColors{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

-(NSString *) randomStringWithLength: (int) len {
    NSString *letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}
-(void)finishedMatchingWord:(NSString *)word{
    if(word==nil){
        self.lblWord.textColor=[UIColor redColor];
    }else{
        self.lblWord.textColor=[UIColor greenColor];
    }
    
}
@end
