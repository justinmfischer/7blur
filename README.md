```HTML
Note : ...
````

## Overview
IOS 7 introduces a new efficient snapshot API. The 7blur project builds apron these frameworks to produce control center and notification center like blur effects enforcing the 3rd design pattern of depth for iOS 7 apps. It should be noted that iOS 7 is no longer under developer NDA. 7blur can be used free and improved by the community.

7blur supports both two styles of blur, two styles of positioning and many blur color components.

* **Supported blurs**
 * Live (realtime) blur
 * Static blur

* **Support positioning**
 * Dropdown menu style
 * Fixed position

* **Blur Color Components**
 * Blur radius
 * Tint color
 * Saturation Delta
 * Image Mask

By combining the attributes above one can produce many desired visual effects and human interfaces. 7blur only has a handful of API tasks and the view content can be visually edited in Interface Builder for productivity. The next section will go over the API followed by common use cases contained in the sample project. Let's get started.

## Getting Started
```Objective-C
//Dropdown menu style
+ (BLRView *) load:(UIView *) view;

//Fixed position style
+ (BLRView *) loadWithLocation:(CGPoint) point parent:(UIView *) view;

//Remove
- (void) unload;

//Up
- (void) slideDown;

//Down
- (void) slideUp;

//Static blur
- (void) blurWithColor:(BLRColorComponents *) components;

//Live (realtime) blur
- (void) blurWithColor:(BLRColorComponents *) components updateInterval:(float) interval;
````

* **1** : _..._
* **2** : _...._
* **3** : _...._

```Objective-C
...
````

## Required Linked Frameworks

* **Accelerate.framework**
* **CoreLocation.framework**
* **CFNetwork.framework**
* **SystemConfiguration.framework**

## Code : Sample Project 

```Objective-C
...
````

```Objective-C
...
````

## Performance and Implementation Details

## History
Initial release : _9/03/2013_

## Copyright and Software Licenses
* UIImage Alpha, Resize, RoundedCorner Category Methods : _Trevor Harmon_
* UIImage Image Effects Category Methods : _Apple, Inc._

The MIT License (MIT)

Copyright (c) 2013 Justin M Fischer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Contact
* Justin M Fischer : _justinmfischer@gmail.com_

## Links
* [iOS 7 UI Transition Guide](https://developer.apple.com/library/etc/redirect/WWDR/iOSUITransitionGuide)
* [iOS Human Interface Guidelines](https://developer.apple.com/library/etc/redirect/WWDR/iOSHIG)
