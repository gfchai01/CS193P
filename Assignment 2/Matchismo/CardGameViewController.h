//
//  CardGameViewController.h
//  Matchismo
//
//  Created by ZacharyChai on 14-4-24.
//  Copyright (c) 2014年 CS193p. All rights reserved.
//

//Abstract class. Must implement methods as described below.


#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController <UIAlertViewDelegate>

//protected
//for subclasses
- (Deck *)createDeck;

@end
