//
//  MaterialButton.h
//  Raden
//
//  Created by Antoine Marliac on 16-01-19.
//  Copyright © 2016 Guaraná Technologies Inc All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MaterialButton <NSObject>
/*!
 *  Triggers the selected action
 */
@optional -(void)buttonTapped:(id)sender;

@end

@interface MaterialButton : UIView <UIGestureRecognizerDelegate>

@property (nonatomic) id <MaterialButton> delegate;
@property (nonatomic, strong) UIButton * btn;


- (void) configureWithTitle:(NSString*) title;
- (void) configureLightButtonWithTitle:(NSString*) title;


- (void) setBlocked:(bool) isBlocked;
- (void) enableBlocking:(bool) enable;




@end
