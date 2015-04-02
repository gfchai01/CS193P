//
//  PlayingCard.m
//  Matchismo
//
//  Created by ZacharyChai on 14-5-12.
//  Copyright (c) 2014年 CS193p. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents {
    //note that we are not required to declare this earlier in the file than we use it.
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        id card = [otherCards firstObject];
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherCard = (PlayingCard *)card;
            if (self.rank == otherCard.rank) {
                score = 4;
            } else if ([self.suit isEqualToString:otherCard.suit]){
                score = 1;
            }
        }
            
    } else if ([otherCards count] == 2) {
        PlayingCard *otherCard1 = [otherCards firstObject];
        PlayingCard *otherCard2 = [otherCards lastObject];
        if (self.rank == otherCard1.rank && self.rank == otherCard2.rank) {
            score = 8;
        } else if (self.suit == otherCard1.suit && self.suit == otherCard2.suit) {
            score = 4;
        } else if (self.rank == otherCard1.rank || self.rank == otherCard2.rank || otherCard1.rank == otherCard2.rank) {
            score = 2;
        } else if (self.suit == otherCard1.suit || self.suit == otherCard2.suit || otherCard1.suit == otherCard2.suit) {
            score =1;
        }
    }
    
//    for (Card *card in otherCards) {
//        if ([card.contents isEqualToString:self.contents]) {
//            score = 1;
//        }
//    }
    return score;
}


+ (NSArray *)validSuits {
//    return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
    return @[@"♠", @"♣", @"♥", @"♦"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7",
             @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
