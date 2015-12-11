//
//  GameHelper.m
//  testGame
//
//  Created by satyendra chauhan on 12/10/15.
//  Copyright © 2015 satyendra chauhan. All rights reserved.
//

#import "GameHelper.h"

@implementation GameHelper
@synthesize delegate;
/*!
 *  @author Satyendra
 *
 *  @brief  shareInstance is singleton method of this class
 *
 *  @return <#return value description#>
 */
+(id)shareInstance{
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^
                  {
                      sharedInstance = [self new];
                  });
    [sharedInstance getAllWords];
    return sharedInstance;
}
/*!
 *  @author Satyendra
 *
 *  @brief  this mehtod will initialize when instance of its class will created.
 */
-(void)getAllWords{
   self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"WordCollection.sqlite"];
    NSString *query = @"select * from tblWords";
    self.arrayAllWords = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
}
/*!
 *  @author Satyendra
 *
 *  @brief  this method will check every time that if there is any matching word in database or not when player select any word from grid
 *
 *  @param strWord select world
 *
 *  @return if matched then yes else no
 */
-(BOOL)matchWord:(NSString *)strWord{
    BOOL isMatched=YES;
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"wordname BEGINSWITH[c] %@",[strWord lowercaseString]];
    NSArray *arrayCharTest=[self.arrayAllWords filteredArrayUsingPredicate:pre];
    
    if(arrayCharTest.count>0){
        if(arrayCharTest.count==1){
            [self.delegate finishedMatchingWord:[[arrayCharTest objectAtIndex:0] valueForKey:@"wordname"]];
        }else{
            NSPredicate *preFullTest=[NSPredicate predicateWithFormat:@"wordname==%@",[strWord lowercaseString]];
            NSArray *arrayfinal=[arrayCharTest filteredArrayUsingPredicate:preFullTest];
            if(arrayfinal.count==1&&[[[arrayfinal objectAtIndex:0] valueForKey:@"wordname"]isEqualToString:[strWord lowercaseString]]){
                [self.delegate finishedMatchingWord:[[arrayfinal objectAtIndex:0] valueForKey:@"wordname"]];
            }
        }
        return YES;
    }else{
        if(arrayCharTest.count==0){
            [self.delegate finishedMatchingWord:nil];
        }
        return NO;
    }
    return isMatched;
    
}
/*!
 *  @author Satyendra
 *
 *  @brief  validate method is validate grid that if the grid contain at least one matching word from database
 *
 *  @param allCharecters alphabets
 *
 *  @return if grid is valid then return yes else no
 */
-(BOOL)validate:(NSString *)allCharecters{
    
    BOOL isValidated=NO;
    
    for (NSDictionary *dr in  self.arrayAllWords) {
        NSString *strWordName=[dr valueForKey:@"wordname"];
        for (int i=0; i<strWordName.length; i++) {
            char strChar=[strWordName characterAtIndex:i];
            if([[allCharecters lowercaseString] containsString:[NSString stringWithFormat:@"%c",strChar]]){
                allCharecters =[[allCharecters lowercaseString] stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%c",strChar] withString:@""];
                isValidated=YES;
                continue;
            }else{
                isValidated=NO;
                break;
            }
        }
        if(isValidated){
            NSLog(@"valid string is %@",strWordName);
            break;
        }
        
    }
    
    return isValidated;
    
}
@end
