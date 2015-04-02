//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by ZacharyChai on 14/10/31.
//  Copyright (c) 2014年 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger matchScore;
@property (nonatomic, strong) NSMutableArray *cards; //of card
@end


@implementation CardMatchingGame


//lazy instantiation
- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSMutableArray *)otherCards {
    if (!_otherCards) {
        _otherCards = [[NSMutableArray alloc] init];
    }
    return _otherCards;
}

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck {
    self = [super init]; //super's designated initializer
    
    if (self) {
        for (int i =0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

//#define MISMATCH_PENALTY 2
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index modeOfCardGame:(NSUInteger)mode {

    Card *card = self.cards[index];
    self.otherCards = nil;
//    [self.otherCards insertObject:card atIndex:0];
    

    if (!card.isMatched) {
        if (card.isChosen) {
            card.Chosen = NO;
        } else {
            //create an array to save chosen cards
//            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if ([otherCard isChosen] && ![otherCard isMatched]) {
                    [self.otherCards addObject:otherCard];
                }
            }
            //create different matching mechanism based on different mode
            if ([self.otherCards count] == mode + 1) {
                self.matchScore = [card match:self.otherCards];
                if (self.matchScore) {
                    self.matchScore = self.matchScore * MATCH_BONUS;
                    self.score += self.matchScore;
                    for (Card *oneCard in self.otherCards) {
                        oneCard.matched = YES;
                    }
                    card.matched = YES;
                } else {
                    self.matchScore = -MISMATCH_PENALTY;
                    self.score += self.matchScore;
                    for (Card *oneCard in self.otherCards) {
                        oneCard.chosen = NO;
                    }
                }
            }
            [self.otherCards addObject:card];
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}



//- (void)chooseCardAtIndex:(NSUInteger)index modeOfCardGame:(NSUInteger)mode {
//
//    Card *card = self.cards[index];
//
//    if (!card.isMatched) {
//        if (card.isChosen) {
//            card.Chosen = NO;
//        } else {
//            //match against other chosen cards
//            if (mode == 0) {
//                for (Card *otherCard in self.cards) {
//                    if ([otherCard isChosen] && ![otherCard isMatched]) {
//                        int matchScore = [card match:@[otherCard]];
//                        if (matchScore) {
//                            self.score += matchScore * MATCH_BONUS;
//                            otherCard.matched = YES;
//                            card.matched = YES;
//                        } else {
//                            self.score -= MISMATCH_PENALTY;
//                            otherCard.Chosen = NO;
//                        }
//                        break; //can only choose 2 cards for now
//                        
//                    }
//                    
//                }
//            } else if (mode == 1) {
//                NSMutableArray *otherCards = [[NSMutableArray alloc] init];
//                for (Card *otherCard in self.cards) {
//                    if ([otherCard isChosen] && ![otherCard isMatched]) {
//                        [otherCards addObject:otherCard];
//                    }
//                }
//                    if ([otherCards count] == 2) {
//                        Card *otherCard1 = otherCards[0];
//                        Card *otherCard2 = otherCards[1];
//                        int matchScore = [card match:otherCards];
//                        if (matchScore) {
//                            self.score += matchScore * MATCH_BONUS;
//                            otherCard1.matched = YES;
//                            otherCard2.matched = YES;
//                            card.matched = YES;
//                        } else {
//                            self.score -= MISMATCH_PENALTY;
//                            otherCard1.chosen = NO;
//                            otherCard2.Chosen = NO;
//                        }
////                        otherCards = nil;
//                    }
//
//            }
//
//            self.score -= COST_TO_CHOOSE;
//            card.chosen = YES;
//        }
//
//    }
//
//}



//- (void)chooseCardAtIndex:(NSUInteger)index {
//    
//    Card *card = self.cards[index];
//    
//    if (!card.isMatched) {
//        if (card.isChosen) {
//            card.Chosen = NO;
//        } else {
//            //match against other chosen cards
//            for (Card *otherCard in self.cards) {
//                if ([otherCard isChosen] && ![otherCard isMatched]) {
//                    int matchScore = [card match:@[otherCard]];
//                    if (matchScore) {
//                        self.score += matchScore * MATCH_BONUS;
//                        otherCard.matched = YES;
//                        card.matched = YES;
//                    } else {
//                        self.score -= MISMATCH_PENALTY;
//                        otherCard.Chosen = NO;
//                    }
//                    break; //can only choose 2 cards for now
//                    
//                }
//
//            }
//            
//            self.score -= COST_TO_CHOOSE;
//            card.chosen = YES;
//        }
//        
//    }
//    
//}




@end
