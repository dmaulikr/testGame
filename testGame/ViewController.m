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
    /*!
     *  @author Satyendra
     *
     *  @brief  below lines are configuring UICollectionView with cell called GTCell
     */
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
/*!
 *  @author Satyendra
 *
 *  @brief  randomizeLatters is a action method which will display random latters in grid. While randomizing it will check wheather the randomized grid is valid or not if not then again this method will called itself implemented recursion.
 *
 *  @param sender
 */
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
/*!
 *  @author Satyendra
 *
 *  @brief  latterAction is action method of grid tiles when any grid will be clicked then this method will be called and sent latter for validation to GameHelper.
 *
 *  @param btnltr btnltr is contain instance of clicked button
 */
- (IBAction)latterAction:(UIButton *)btnltr {
    NSLog(@"%@",btnltr.titleLabel.text);
    [self.strWords appendString:btnltr.titleLabel.text];
    self.lblWord.text=self.strWords;
    GameHelper *gamH=[GameHelper shareInstance];
    gamH.delegate=self;
    BOOL isMatched=[gamH matchWord:self.strWords];
    if(isMatched){
        /*!
         *  @author Satyendra
         *
         *  @brief  we can do stuff for this condition like some animation if false or true
         */
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
/*!
 *  @author Satyendra
 *
 *  @brief  getRandomColors will generat random color for tiles
 *
 *  @return UIColor
 */
-(UIColor *)getRandomColors{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}
/*!
 *  @author Satyendra
 *
 *  @brief  this method will return random latters of alphabets. Here I defined len that is you can pass which length of random latter you want.
 *
 *  @param len int parameter for length of random string
 *
 *  @return rendom string
 */
-(NSString *) randomStringWithLength: (int) len {
    NSString *letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}
/*!
 *  @author Satyendra
 *
 *  @brief  this is delegate method of GameHelper that will call when any world is matched or not matched and this method have word parameter that is comes with nil if world is not matched and if matched then word will contain string
 *
 *  @param word 
 */
-(void)finishedMatchingWord:(NSString *)word{
    if(word==nil){
        self.lblWord.textColor=[UIColor redColor];
    }else{
        self.lblWord.textColor=[UIColor greenColor];
    }
    
}
@end
