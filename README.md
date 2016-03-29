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

![Light](https://bytebucket.org/GuaranaM/grnalertview/raw/f5238cdc11293290fe671d267e2372479048279f/screenshots/screenshot1.png?token=659a54995da3d8730308fa7c73f4eb7da142e9c1)

*   BackgroundTypeTransparentDark (background is black with an alpha)

![Dark](https://bytebucket.org/GuaranaM/grnalertview/raw/f5238cdc11293290fe671d267e2372479048279f/screenshots/screenshot2.png?token=442893d73c7bd81132d9bbcdf4bd1d06b5fe906b)

*   BackgroundTypeBlurred  (background is blurred)

![Blurred](https://bytebucket.org/GuaranaM/grnalertview/raw/f5238cdc11293290fe671d267e2372479048279f/screenshots/screenshot3.png?token=075dccde9cd380971bd5fe583c8c70a36e93f8e6)


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