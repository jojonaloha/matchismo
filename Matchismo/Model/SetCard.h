//
//  SetCard.h
//  Matchismo
//
//  Created by Jonathan Jordan on 8/31/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *shading;

+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

@end
