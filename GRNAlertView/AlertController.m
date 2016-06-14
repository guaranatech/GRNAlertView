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
        _shadowOppacity = 0.4;
        _shadowRadius = 20;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //button display management
    _alertView.layer.cornerRadius = _cornerRadius;
    _lineHeight.constant = 1/[UIScreen mainScreen].scale;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UI Configuration

- (void) configureView
{
    
    _alertView.backgroundColor = _alertBackgroundColor?_alertBackgroundColor:[UIColor whiteColor];
    
    //labels configuration
    _titleLabel.text = _title;
    [_titleLabel setFont:_titleFont];
    [_titleLabel setTextColor:_titleColor?_titleColor:[UIColor blackColor]];

    _subTitleLabel.text = _subTitle;
    [_subTitleLabel setFont:_subtitleFont];
    [_subTitleLabel setTextColor:_subtitleColor?_subtitleColor:[UIColor blackColor]];
    
    _contentLabel.text = _content;
    [_contentLabel setFont:_contentFont];
    [_contentLabel setTextColor:_contentColor?_contentColor:[UIColor blackColor]];
    

    
    [_btn1 setButtonTapped:^(MaterialButton *btn) {
        [self leftButtonTapped];
    }];

    [_btn2 setButtonTapped:^(MaterialButton *btn) {
        [self rightButtonTapped];
    }];
    
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

    
    //shadow configuration
    _shadowView.layer.masksToBounds = NO;
    _shadowView.layer.shadowOffset = CGSizeMake(0, 10);
    _shadowView.layer.shadowRadius = _shadowRadius;
    _shadowView.layer.shadowOpacity = _shadowOppacity;
    _shadowView.layer.cornerRadius = _cornerRadius;
    
    
    [self configureButtons];
}

- (void) configureButtons
{
    [_alertView layoutIfNeeded];
    //buttons configuration
    [_btn1 configureButtonWithTitle:_leftBtnTitle];
    [_btn1.btn.titleLabel setFont:_buttonFont];
    [_btn1.btn setTitleColor:_leftButtonColor?_leftButtonColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn1 enableBlocking:NO];
    _btn1.backgroundColor = _leftButtonBackgroundColor?_leftButtonBackgroundColor:[UIColor whiteColor];
    
    
    [_btn2 configureButtonWithTitle:_rightBtnTitle];
    [_btn2.btn.titleLabel setFont:_buttonFont];
    [_btn2.btn setTitleColor:_rightButtonColor?_rightButtonColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn2 enableBlocking:NO];
    _btn2.backgroundColor = _rightButtonBackgroundColor?_rightButtonBackgroundColor:[UIColor whiteColor];
    
    
    if (_rightBtnTitle.length > 0) {
        _btn2Width.constant = _alertView.bounds.size.width/2;
        [_btn2 setHidden:NO];
    }else{
        [_btn2 setHidden:YES];
    }

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
}


#pragma mark - Show / Hide

- (void) showOn:(UIViewController *) controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setBlackground];
        
        [controller presentViewController:self animated:YES completion:^{

        }];
    });
}


- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Button Actions

- (void)leftButtonTapped {
    if (self.leftButtonAction) {
        self.leftButtonAction(self);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonTapped {
    if (self.rightButtonAction) {
        self.rightButtonAction(self);
    }
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
