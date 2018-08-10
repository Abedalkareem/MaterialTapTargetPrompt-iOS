<p align="center">
 <img src="https://github.com/Abedalkareem/MaterialTapTargetPrompt-iOS/blob/master/material_tap_target_logo.png"  >
</p>
A iOS version of Material Tap Target Prompt ,Written in Swift and can be used in swift or objective c projects.

</br>

<b>ScreenShots</b>

<img src="https://raw.githubusercontent.com/Abedalkareem/MaterialTapTargetPrompt-iOS/master/MaterialTapTargetPrompt/screenshot.png"  width="450">

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

Just add ```MaterialTapTargetPrompt.swift``` in your project


<b>Note</b>

I'm going to be very happy if you give me a feedback or advice , thank you

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
