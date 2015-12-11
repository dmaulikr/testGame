//
//  GameHelper.h
//  testGame
//
//  Created by satyendra chauhan on 12/10/15.
//  Copyright © 2015 satyendra chauhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"

@interface GameHelper : NSObject
@property(strong, nonatomic)NSArray *arrayAllWords;
@property (strong, nonatomic) DBManager *dbManager;
+(id)shareInstance;
-(BOOL)matchWord:(NSString *)strWord;
-(BOOL)validate:(NSString *)allCharecters;
@property(weak, nonatomic)id delegate;
@end
/*!
 *  @author Satyendra
 *
 *  @brief  create protocol for implementing delegate
 */
@protocol MyGameProto <NSObject>
-(void)finishedMatchingWord:(NSString *)word;

@end