//
//  CardGameViewController.m
//  Matchismo
//
//  Created by ZacharyChai on 14-4-24.
//  Copyright (c) 2014年 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
//#import "Deck.h"
//#import "PlayingCardDeck.h"
//#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
//@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
//@property (nonatomic) int flipCount;
//
//@property (strong, nonatomic) Deck *deck;
//@property Deck *assignmentDeck;

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIButton *restartButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentButton;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UISlider *descriptionSlider;

@property (strong, nonatomic) NSMutableArray *descriptions;

@end

@implementation CardGameViewController


- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (NSMutableArray *)descriptions {
    if (!_descriptions) {
        _descriptions = [[NSMutableArray alloc] init];
    }
    return _descriptions;
}


//- (void)setFlipCount:(int)flipCount
//{
//    _flipCount = flipCount;
//    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
//    NSLog(@"flipCount changed to %d", self.flipCount);
//}

//- (Deck *)deck {
//    if (!_deck) {
//        _deck = [self createDeck];
//    }
//    return _deck;
//}

//- (Deck *)createDeck {
//    return [[PlayingCardDeck alloc] init];
//}

- (Deck *)createDeck {   //abstract
    return nil;
}


- (IBAction)touchCardButton:(UIButton *)sender
{
////    UIImage *cardImage = [UIImage imageNamed:@"cardback"];
//    
////    if (!self.aPlayingDeck) {
////        self.aPlayingDeck = [[PlayingCardDeck alloc] init];
////    }
//    
//    if ([sender.currentTitle length]) {
//        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
//                          forState:UIControlStateNormal];
//        [sender setTitle:@"" forState:UIControlStateNormal];
//    } else {
//        Card *randomCard = [self.deck drawRandomCard];
//
////        if ([@[@"♥︎", @"♦︎"] containsObject:[randomCard.contents substringFromIndex:1]]) {
////            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
////        }
////        PlayingCard *playingCard = [[PlayingCard alloc] init];
////        playingCard.contents = randomCard.contents;
////        NSLog(@"%@", randomCard.contents);
////        if ([[playingCard.contents substringFromIndex:0] isEqualToString:@"♥︎"]) {
////            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
////        }
//        
////        if ([randomCard.contents hasSuffix:@"♥︎"] | [randomCard.contents hasSuffix:@"♦︎"]) {
////            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
////        } else
////            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        
//        if (randomCard) {
//            
//            if ([randomCard.contents hasSuffix:@"♥︎"] || [randomCard.contents hasSuffix:@"♦︎"]) {
//                [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            } else
//                [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            
//            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
//                              forState:UIControlStateNormal];
//            //        [sender setTitle:@"A♣︎" forState:UIControlStateNormal];
//            [sender setTitle:randomCard.contents forState:UIControlStateNormal];
////            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            
//        }
//    }
    
    self.segmentButton.enabled = NO;
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex modeOfCardGame:[self.segmentButton selectedSegmentIndex]];
    [self updateUI];
//    [self updateDescription];
    
    
//    self.flipCount++;
    
}

- (IBAction)touchDescriptionSlider:(UISlider *)sender {
    if ([self.descriptions count]) {
        self.descriptionSlider.maximumValue = [self.descriptions count] -1;
        self.descriptionLabel.text = [self.descriptions objectAtIndex:self.descriptionSlider.value];
    }
}



- (void)updateDescription {
    if ([self.segmentButton selectedSegmentIndex] == 0) {
        if ([self.game.otherCards count] == 2) {
            Card *otherCard1 = self.game.otherCards[0];
            Card *otherCard2 = self.game.otherCards[1];
            if (self.game.matchScore > 0) {
                self.descriptionLabel.text = [NSString stringWithFormat:@"Matched %@ %@ for %i points.",
                                              otherCard1.contents,
                                              otherCard2.contents,
                                              self.game.matchScore];
            } else if (self.game.matchScore < 0){
                self.descriptionLabel.text = [NSString stringWithFormat:@"%@ %@ don't match! %i points penalty!",
                                              otherCard1.contents,
                                              otherCard2.contents,
                                              self.game.matchScore];
            }
        } else if ([self.game.otherCards count] == 1){
            Card *otherCard1 = self.game.otherCards[0];
            self.descriptionLabel.text = [NSString stringWithFormat:@"%@", otherCard1.contents];
        }
        
    } else if ([self.segmentButton selectedSegmentIndex] == 1) {
        if ([self.game.otherCards count] == 3) {
            Card *otherCard1 = self.game.otherCards[0];
            Card *otherCard2 = self.game.otherCards[1];
            Card *otherCard3 = self.game.otherCards[2];
            if (self.game.matchScore > 0) {
                self.descriptionLabel.text = [NSString stringWithFormat:@"Matched %@ %@ %@ for %i points",
                                              otherCard1.contents,
                                              otherCard2.contents,
                                              otherCard3.contents,
                                              self.game.matchScore];
            } else if (self.game.matchScore < 0) {
                self.descriptionLabel.text = [NSString stringWithFormat:@"%@ %@ %@ don't match! %i points penalty!",
                                              otherCard1.contents,
                                              otherCard2.contents,
                                              otherCard3.contents,
                                              self.game.matchScore];
            }
        } else if ([self.game.otherCards count] == 2) {
            Card *otherCard1 = self.game.otherCards[0];
            Card *otherCard2 = self.game.otherCards[1];
            self.descriptionLabel.text = [NSString stringWithFormat:@"%@ %@",
                                          otherCard1.contents,
                                          otherCard2.contents];
        } else if ([self.game.otherCards count] == 1){
            Card *otherCard1 = self.game.otherCards[0];
            self.descriptionLabel.text = [NSString stringWithFormat:@"%@", otherCard1.contents];
        }
    }
    if (self.descriptionLabel.text) {
        [self.descriptions addObject:self.descriptionLabel.text];
    }
//    self.descriptionLabel.text = nil;
}

- (IBAction)touchRestartButton {
    
    [[[UIAlertView alloc] initWithTitle:@"Restart"
                                message:@"Are you sure to restart the game?"
                               delegate:self
                      cancelButtonTitle:@"Cancel"
                      otherButtonTitles:@"Yes", nil] show];
    
    
//    self.game = nil;
//    [self updateUI];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        self.game = nil;
        self.segmentButton.enabled = YES;
        [self updateUI];
//        [self updateDescription];
        self.descriptionLabel.text = nil;
        self.descriptions = nil;
    }
}

//- (IBAction)touchSegmentButton:(UISegmentedControl *)sender {
////    self.segmentButton.selectedSegmentIndex
//    
//}


- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
//        if ([card.contents hasSuffix:@"♥︎"] || [card.contents hasSuffix:@"♦︎"]) {
//            [cardButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        } else
//            [cardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [cardButton setTitleColor:[self colorForSuitOfCard:card] forState:UIControlStateNormal];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", self.game.score];
        
        [self updateDescription];
        
        if ([self.descriptions count]) {
            self.descriptionSlider.value = self.descriptionSlider.maximumValue;
        }
    }
    
}

- (UIColor *)colorForSuitOfCard: (Card *)card {
    return ([card.contents hasSuffix:@"♥︎"] || [card.contents hasSuffix:@"♦︎"]) ? [UIColor redColor] : [UIColor blackColor];
}

- (NSString *)titleForCard: (Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}




@end
