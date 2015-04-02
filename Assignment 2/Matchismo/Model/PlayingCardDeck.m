//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by ZacharyChai on 14-5-13.
//  Copyright (c) 2014年 CS193p. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
//                [self addCard:card atTop:NO];
            }
        }
    }
    return self;
}

@end
