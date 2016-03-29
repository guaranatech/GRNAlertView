//
//  AlertController.m
//  Raden
//
//  Created by Antoine Marliac on 16-01-28.
//  Copyright © 2016 Guaraná Technologies Inc All rights reserved.
//

#import "AlertController.h"

@interface AlertController ()

@end




@implementation AlertController
{
    NSString* _title;
    NSString* _subTitle;
    NSString* _content;
    NSString* _leftBtnTitle;
    NSString* _rightBtnTitle;
    UIImage* _image;
}


- (instancetype)initWithTitle:(NSString*) title
                     subTitle:(NSString*) subTitle
                      content:(NSString*) content
              leftButtonTitle:(NSString*) leftBtnTitle
             rightButtonTitle:(NSString*) rightBtnTitle
                     andImage:(UIImage*) image
{
    self = [super initWithNibName:@"AlertController" bundle:nil];
    if (self) {
        _title = title;
        _subTitle = subTitle;
        _content = content;
        _leftBtnTitle = leftBtnTitle;
        _rightBtnTitle = rightBtnTitle;
        _image = image;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureView];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UI Configuration

- (void) configureView
{
    //labels configuration

    _titleLabel.text = _title;
    _subTitleLabel.text = _subTitle;
    _contentLabel.text = _content;
    
    
    //buttons configuration

    [_btn1 configureLightButtonWithTitle:_leftBtnTitle];
    [_btn1 enableBlocking:NO];
    [_btn1 setDelegate:self];
    [_btn2 configureLightButtonWithTitle:_rightBtnTitle];
    [_btn2 enableBlocking:NO];
    [_btn2 setDelegate:self];
    
    
    
    //imageview configuration
    
    [_imageView setImage:_image];

    if (!_imageView.image) {
        _imageTopMargin.constant = 20;
        _imageHeight.constant = 0;
    }
    
    //subttitle constraints configuration

    if (_subTitleLabel.text.length == 0) {
        _subTitleTopMargin.constant = 0;
    }

    [_alertView layoutIfNeeded];

    
    //button display management

    if (_rightBtnTitle.length > 0) {
        _btn2Width.constant = -1 + _alertView.bounds.size.width/2;
    }else{
        [_btn2 setHidden:YES];
    }
    
    _alertView.layer.cornerRadius = _cornerRadius;
    
    
    //shadow configuration
    _shadowView.layer.masksToBounds = NO;
    _shadowView.layer.shadowOffset = CGSizeMake(0, 10);
    _shadowView.layer.shadowRadius = 20;
    _shadowView.layer.shadowOpacity = 0.4;
    _shadowView.layer.cornerRadius = _cornerRadius;
    
    

    
//    [self setBackground];

}

- (void) setBlackground
{
    [self.view layoutIfNeeded];

    
    switch (_backgroundType) {
        case BackgroundTypeDefault:
            self.backgroundView.backgroundColor = [UIColor clearColor];
            break;
            
        case BackgroundTypeTransparentLight:
            self.backgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
            break;
            
        case BackgroundTypeTransparentDark:
            self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
            break;
            
        case BackgroundTypeBlurred:
            [self blurConfiguration];
            break;
            
        default:
            break;
    }
    
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;


}

- (void) blurConfiguration
{
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + 68);
    
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *beView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    beView.frame = frame;
    
    self.view.frame = frame;
    [self.backgroundView insertSubview:beView atIndex:0];

    self.view.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = [UIColor clearColor];
//    self.backgroundView.alpha = 0;
}

#pragma mark - Material Button Delegate


- (void) buttonTapped:(id)sender
{
    MaterialButton * btn = (MaterialButton*) sender;
    if (btn == _btn1) {
        [self leftButton:sender];
    }else{
        [self rightButton:sender];
    }
}


#pragma mark - Show / Hide

- (void) showOn:(UIViewController *) controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setBlackground];
        
        [controller presentViewController:self animated:YES completion:^{
            //start animations
            //        [self showBackgroundAnimation];
        }];
    });
}


- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Button Actions

- (void)leftButton:(id)sender {
    self.leftButtonAction(self);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButton:(id)sender {
    self.rightButtonAction(self);
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Animation / Transitions


- (void) showBackgroundAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.alpha = 1;
    }];
}

@end
