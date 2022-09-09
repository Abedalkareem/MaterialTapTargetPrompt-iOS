[![pub package](https://img.shields.io/pub/v/games_services.svg)](https://pub.dartlang.org/packages/games_services)
<a href="https://www.buymeacoffee.com/abedalkareem" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 20px !important;width: 100px !important; box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" > </a>
[![Telegram](https://img.shields.io/badge/chat-telegram-0088cc)](https://t.me/+NvUXzshmIg44N2M0)
[![Youtube](https://img.shields.io/badge/subscribe-youtube-c4302b)](https://www.youtube.com/c/Omreyh)
[![Twitter](https://img.shields.io/badge/follow-twitter-00acee)](https://twitter.com/abedalkareemomr)  

<p align="center">
 <img src="https://github.com/Abedalkareem/MaterialTapTargetPrompt-iOS/blob/master/material_tap_target_logo.png"  >
</p>
An iOS version of Material Tap Target Prompt, written in Swift and can be used in swift or objective c projects.

</br>

<b>ScreenShots</b>

<img src="https://raw.githubusercontent.com/Abedalkareem/MaterialTapTargetPrompt-iOS/master/screenshot.png"  width="450">

<b>Usage</b>

```swift
let tapTargetPrompt = MaterialTapTargetPrompt(target: leftBarButton)
tapTargetPrompt.action = {
  print("left clicked")
}
tapTargetPrompt.dismissed = {
  print("view dismissed")
}
tapTargetPrompt.circleColor = UIColor.red
tapTargetPrompt.primaryText = "Add Home"
tapTargetPrompt.secondaryText = "Here you can add home"
tapTargetPrompt.textPostion = .bottomRight
```

<b>Installation</b>

MaterialTapTargetPrompt-iOS is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MaterialTapTargetPrompt-iOS'
```

Or you can use [Carthage](https://github.com/Carthage/Carthage).

```
github "Abedalkareem/MaterialTapTargetPrompt-iOS"
```

## Support me 🚀  

You can support this project by:  

1- Checking my [apps](https://apps.apple.com/us/developer/id928910207).  
2- Star the repo.  
3- Share the repo with your friends.  
4- [Buy Me A Coffee](https://www.buymeacoffee.com/abedalkareem).  

## Follow me ❤️  

[Facebook](https://www.facebook.com/Abedalkareem.Omreyh/) | [Twitter](https://twitter.com/abedalkareemomr) | [Instagram](https://instagram.com/abedalkareemomreyh/) | [Youtube](https://www.youtube.com/user/AbedalkareemOmreyh)

<b>License</b>

```
The MIT License (MIT)

Copyright (c) 2017 Abedalkareem Omreyh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
