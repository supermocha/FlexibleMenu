# FlexibleMenu
`FlexibleMenu` is a clean and easy-to-use menu on iOS.

## How To Use
Just import the header file and create an instance of `FlexibleMenu`.
```objective-c
#import "FlexibleMenu.h"

...

FlexibleMenu *flexibleMenu = [[FlexibleMenu alloc] initWithFrame:[UIScreen mainScreen].bounds 
                                                          titles:titles 
                                                           items:items];
flexibleMenu.delegate = self;
[self.view addSubview:flexibleMenu];
```

### Gesture Interaction

```objective-c
- (void)flexibleMenuDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
```
