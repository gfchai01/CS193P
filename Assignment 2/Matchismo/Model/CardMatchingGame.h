//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by ZacharyChai on 14/10/31.
//  Copyright (c) 2014年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
//#import "PlayingCard.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

//- (void)chooseCardAtIndex:(NSUInteger)index;

- (void)chooseCardAtIndex:(NSUInteger)index modeOfCardGame:(NSUInteger)mode;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger matchScore;
@property (nonatomic) NSMutableArray *otherCards;

@end
