//
//  MaterialButton.m
//  Raden
//
//  Created by Antoine Marliac on 16-01-19.
//  Copyright © 2016 Guaraná Technologies Inc All rights reserved.
//

#import "MaterialButton.h"

@implementation MaterialButton
{
    UITapGestureRecognizer * tap;
    bool blockingEnabled;
    bool isLight;
}


#pragma mark - UI


- (void) configureWithTitle:(NSString*) title
{
    _btn = [[UIButton alloc] init];
    [_btn setTitle:[title uppercaseString] forState:UIControlStateNormal];
    [_btn.titleLabel setFont:[UIFont fontWithName:@"System" size:14]];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn setUserInteractionEnabled:NO];
    
    [_btn setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self addSubview:_btn];

    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tap];
    tap.delegate = self;
    
    [self layoutIfNeeded];
    [self setConstraints];
    
    [self setBlocked:YES];
}

- (void) configureLightButtonWithTitle:(NSString*) title
{
    isLight = YES;
    _btn = [[UIButton alloc] init];
    [_btn setTitle:[title uppercaseString] forState:UIControlStateNormal];
    [_btn.titleLabel setFont:[UIFont fontWithName:@"System" size:14]];
    [_btn setTitleColor:[UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1] forState:UIControlStateNormal];
    [_btn setUserInteractionEnabled:NO];
    
    [_btn setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:_btn];
    
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tap];
    tap.delegate = self;
    
    [self setConstraints];
    [self layoutIfNeeded];

    [self setBlocked:YES];
}


- (void) setConstraints
{
    NSLayoutConstraint *heightConstraint =
    [NSLayoutConstraint constraintWithItem:_btn
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:60];
    [self addConstraint:heightConstraint];
    
    NSLayoutConstraint *widthConstraint =
    [NSLayoutConstraint constraintWithItem:_btn
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:self.bounds.size.width];
    [self addConstraint:widthConstraint];
    
    // Center Vertically
    NSLayoutConstraint *centerYConstraint =
    [NSLayoutConstraint constraintWithItem:_btn
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0.0];
    [self addConstraint:centerYConstraint];
    
    // Center Horizontally
    NSLayoutConstraint *centerXConstraint =
    [NSLayoutConstraint constraintWithItem:_btn
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0];
    [self addConstraint:centerXConstraint];
    
}

#pragma mark - Tap gesture method

- (void) handleTap:(UIGestureRecognizer*) tapRecognizer
{
    CGPoint touchePoint = [tapRecognizer locationInView:self];
    
    UIView * roundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    if (isLight) {
        roundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
    }else{
        roundView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.15];
    }
    
    roundView.center = touchePoint;
    roundView.layer.cornerRadius = 10.0f;
    [self addSubview:roundView];
    
    [self bringSubviewToFront:_btn];
    
    [self removeGestureRecognizer:tap];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        roundView.transform = CGAffineTransformMakeScale(50, 50);
        roundView.alpha = 0.5;
    } completion:^(BOOL finished) {
        [_delegate buttonTapped:self];
        [roundView removeFromSuperview];
        [self addGestureRecognizer:tap];
    }];
}



#pragma mark - Misc


- (void) setBlocked:(bool) isBlocked
{
    if (!blockingEnabled) {
        return;
    }
    if (isBlocked) {
        [self setUserInteractionEnabled:NO];
        [self setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.15]];
    }else{
        [self setUserInteractionEnabled:YES];
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:1]];
    }
}

- (void) enableBlocking:(bool) enableBlocking
{
    blockingEnabled = enableBlocking;
}

@end
