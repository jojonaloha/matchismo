//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Jonathan Jordan on 8/30/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Move.h"

@interface PlayingCardGameViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeControl;
@end

@implementation PlayingCardGameViewController

- (CardMatchingGame *)newGame
{
    CardMatchingGame *game = [super newGame];
    if (game) {
        game.numCardsToMatch = self.matchModeControl.selectedSegmentIndex + 2;
        self.matchModeControl.enabled = YES;
    }
    return game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)changeMatchModeControl:(UISegmentedControl *)sender {
    self.game.numCardsToMatch = sender.selectedSegmentIndex + 2;
}

- (IBAction)touchPlayingCardButton:(UIButton *)sender {
    self.matchModeControl.enabled = NO;
}


@end
