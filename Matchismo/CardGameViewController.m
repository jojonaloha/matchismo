//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jonathan Jordan on 8/17/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "CardGameHistoryViewController.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSString *matchText;
@end

@implementation CardGameViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Card Game History"]) {
        if ([segue.destinationViewController isKindOfClass:[CardGameHistoryViewController class]]) {
            CardGameHistoryViewController *cghvc = (CardGameHistoryViewController *)segue.destinationViewController;
            cghvc.moves = self.game.moves;
            cghvc.formatter = self;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self newGame];
    [self updateUI];
}

- (NSString *)matchText {
    if (!_matchText) _matchText = [[NSString alloc] init];
    return _matchText;
}

- (CardMatchingGame *)game {
    if (!_game) _game = [self newGame];
    return _game;
}

- (Deck *)createDeck { // abstract
    return nil;
}

- (CardMatchingGame *)newGame {
    CardMatchingGame *game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return game;
}

- (IBAction)touchNewGameButton:(UIBarButtonItem *)sender {
    self.game = nil;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (NSAttributedString *)titleForCard:(Card *)card {
    return [[NSAttributedString alloc] initWithString: card.isChosen ? card.contents : @""];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}


@end
