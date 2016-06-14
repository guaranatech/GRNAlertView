//
//  MaterialButton.h
//  Raden
//
//  Created by Antoine Marliac on 16-01-19.
//  Copyright © 2016 Guaraná Technologies Inc All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MaterialButton : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton * btn;

@property (nonatomic, copy) void (^buttonTapped)(MaterialButton* btn);


- (void) configureButtonWithTitle:(NSString*) title;


- (void) setBlocked:(bool) isBlocked;
- (void) enableBlocking:(bool) enable;




@end
