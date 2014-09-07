//
//  SetCard.m
//  Matchismo
//
//  Created by Jonathan Jordan on 8/31/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    BOOL isSet = false;
    
    if ([otherCards count] == 2) {
        NSMutableArray *shapes = [[NSMutableArray alloc] initWithArray:@[self.shape]];
        NSMutableArray *shadings = [[NSMutableArray alloc] initWithArray:@[self.shading]];
        NSMutableArray *colors = [[NSMutableArray alloc] initWithArray:@[self.color]];
        NSMutableArray *numbers = [[NSMutableArray alloc] initWithArray:@[[[NSNumber alloc] initWithUnsignedInteger:self.number]]];
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[SetCard class]]) {
                SetCard *setCard = (SetCard *) otherCard;
                // Only add unique objects
                if ([shapes indexOfObject:setCard.shape] == NSNotFound) {
                    [shapes addObject:setCard.shape];
                }
                if ([shadings indexOfObject:setCard.shading] == NSNotFound) {
                    [shadings addObject:setCard.shading];
                }
                if ([colors indexOfObject:setCard.color] == NSNotFound) {
                    [colors addObject:setCard.color];
                }
                if ([numbers indexOfObject:[[NSNumber alloc] initWithUnsignedInteger:setCard.number]] == NSNotFound) {
                    [numbers addObject:[[NSNumber alloc] initWithUnsignedInteger:setCard.number]];
                }
            }
        }
        
        if (([shapes count] == 1 || [shapes count] == 3) &&
            ([shadings count] == 1 || [shadings count] == 3) &&
            ([colors count] == 1 || [colors count] == 3) &&
            ([numbers count] == 1 || [numbers count] == 3)) {
            isSet = true;
        }
    }
    
    if (isSet) {
        score = 10;
    }
    
    return score;
}

- (NSString *)contents
{
    NSString *string = @"";
    for (int i = 0; i < self.number; i++) {
        string = [string stringByAppendingString:self.shape];
    }
    return string;
}

# pragma mark - shapes
@synthesize shape = _shape;

+ (NSArray *)validShapes
{
    return @[@"▲", @"●", @"■"];
}

- (NSString *)shape
{
    return _shape ? _shape : [[SetCard validShapes] firstObject];
}

- (void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
}

# pragma mark - color
@synthesize color = _color;

+ (NSArray *)validColors {
    return @[@"red", @"green", @"purple"];
}

- (NSString *)color
{
    return _color ? _color : [[SetCard validColors] firstObject];
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

# pragma mark - shading
@synthesize shading = _shading;

+ (NSArray *)validShadings {
    return @[@"solid", @"striped", @"open"];
}

- (NSString *)shading
{
    return _shading ? _shading : [[SetCard validShadings] firstObject];
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

#pragma mark - number
@synthesize number = _number;

+ (NSUInteger)maxNumber
{
    NSUInteger max = 3;
    return max;
}

- (NSUInteger)number
{
    return _number ? _number : 1;
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber]) {
        _number = number;
    }
}


@end
