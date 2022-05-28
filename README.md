# InstaImageViewer

A simple widget to display image in a full-screen, swipe it to dismiss, pinch & zoom.

![InstaImageViewer Demo](https://github.com/AgoraDesk-LocalMonero/insta-image-viewer/blob/main/example/example_images/insta-mage-viewer-example.gif?raw=true "InstaImageViewer Demo")

## Features

* Show a single image in a full screen mode
* Use pinch & zoom to zoom in and out of images
* No dependencies besides Flutter
* Callbacks for `onPageChanged` and `onViewerDismissed`

## Usage

As ease as an image widget:

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
- Upon request: Possibility to wrap icons with path to big images. According current UI there is no
need in in such functionality. But in long lists it will lead to significant UI slow.
So, if you need this functionality feel free to create an issue.
- Improve animations

For any bugs, suggestions - please submit an issue.

## Credits

InstaImageViewer is a project by [TSG](https://agoradesk.com/), P2P cryptocurrency trading platform.
Created by the team behind LocalMonero, the biggest and most trusted Monero P2P trading platform.