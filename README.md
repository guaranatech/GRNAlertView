# GRNAlertView #



## Installation 
 ##

Drag the folder GRNAlertView to your project.


## How to use it
 ##

Instantiate your AlertContoller

Note : If you want only one button, just let the rightButtonTitle string empty.

```
#!objective-c

AlertController * alert = [[AlertController alloc] initWithTitle:@"My Title" subTitle:@"With a sub-title here" content:@"This is an alert view whith image Type some content here." leftButtonTitle:@"OK" rightButtonTitle:@"" andImage:[UIImage imageNamed:@"globe"]];
    
```

Set the button actions

```
#!objective-c

[alert setLeftButtonAction:^(AlertController * controller) {
    // Do something here
    
}];


[alert setRightButtonAction:^(AlertController *controller) {
    // Do something here
    
}];
    
```

Set the type of background you want :
*   BackgroundTypeDefault (background is transparent)

*   BackgroundTypeTransparentLight (background is white with an alpha)

![Light](https://github.com/guaranatech/GRNAlertView/blob/master/screenshots/screenshot1.png)

*   BackgroundTypeTransparentDark (background is black with an alpha)

![Dark](https://github.com/guaranatech/GRNAlertView/blob/master/screenshots/screenshot2.png)

*   BackgroundTypeBlurred  (background is blurred)

![Blurred](https://github.com/guaranatech/GRNAlertView/blob/master/screenshots/screenshot3.png)


```
#!objective-c

alert.backgroundType = BackgroundTypeTransparentLight;

    
```

Show the alert like so

```
#!objective-c

[alert showOn:self];
    
```


## TODO
 ##

* Transitions
* Animations
* Dynamic buttons
* Buttons displayed horizontally and vertically
* Ratings
