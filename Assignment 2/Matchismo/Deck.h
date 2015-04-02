//
//  Deck.h
//  Matchismo
//
//  Created by ZacharyChai on 14-5-12.
//  Copyright (c) 2014年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard: (Card *)card atTop: (BOOL)atTop;
- (void)addCard: (Card *)card;

- (Card *)drawRandomCard;

@end
