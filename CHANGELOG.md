## 1.0.3

* Added two properties for opening full-quality images. With this feature, it is possible to display small images in the list view and open full-quality images on user tap. If `imageUrl` is null, the plugin works as before.

  /// Image url
  /// If imageUrl is not null, child will be ignored when large image is opened
  final String? imageUrl;

  /// headers
  final Map<String, String>? headers;

## 1.0.2

* Fixed bug with gestures.

## 1.0.1

* Improved gestures to swipe down\up.
* Added `disableSwipeToDismiss` property - disable swipe gestures.

## 0.0.1+3

* Updated docs.

## 0.0.1

* Initial release - the first beta with main functionality.
