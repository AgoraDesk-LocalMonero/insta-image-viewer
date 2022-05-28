# InstaImageViewer

A simple widget to display image in a full-screen, swipe it to dismiss, pinch & zoom.

![InstaImageViewer Demo](https://github.com/AgoraDesk-LocalMonero/insta-image-viewer/blob/main/example/example_images/insta-mage-viewer-example.gif?raw=true "InstaImageViewer Demo")

## Features

* Show a single image in a full screen mode
* Nice swipe animation (like in Instagram) to dismiss full screen mode
* Use pinch & zoom to zoom in and out in a full screen mode
* No dependencies besides Flutter

## Usage

As easy as an image widget:

```dart
SizedBox(
  width: 100,
  height: 140,
  child: InstaImageViewer(
    child: Image(
      image: Image.network("https://picsum.photos/id/507/1000").image,
    ),
  ),
),
```

TODO:
* Upon request: Possibility to wrap icons with path to large images. According current UI there is no
need in in such functionality. But, in a long lists, it will lead to significant UI slowing down.
So, if you need this functionality feel free to create an issue.
* Improve animations

For any bugs, suggestions - please submit an issue.

## Credits

InstaImageViewer is a project by [Agoradesk](https://agoradesk.com/), P2P cryptocurrency trading platform.
Created by the team behind LocalMonero, the biggest and most trusted Monero P2P trading platform.