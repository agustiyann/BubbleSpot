# 🗨️ BubbleSpot

[![Swift 5](https://img.shields.io/badge/Swift-v5-orange?logo=swift&style=flat-square)](https://www.swift.org/)
[![iOS 12+](https://img.shields.io/badge/iOS-12+-silver?logo=apple&style=flat-square)](https://www.apple.com/iphone/)
[![SPM](https://img.shields.io/badge/Swift_Package_Manager-Compatible-green?logo=swift&style=flat-square)](https://www.swift.org/documentation/package-manager/)
[![GitHub](https://img.shields.io/badge/GitHub-agustiyann-%2300b894?logo=github&style=flat-square)](https://github.com/agustiyann)

BubbleSpot is a lightweight library for creating tooltips in iOS development using UIKit. It allows developers to easily add informative tooltips to their app's user interface, enhancing user experience and providing helpful hints.

<img style="width: 50%" src="https://github.com/agustiyann/BubbleSpot/assets/47731450/f80e4a2a-4a15-4204-8b73-48276faf8577" alt="Screenshoot" />

## Features
- Easily create customizable tooltips for iOS apps.
- Support for positioning tooltips relative to target views.
- Customizable text, background color, arrow color, and more.
- Simple API for showing and dismissing tooltips.

## Installation

BubbleSpot can be easily integrated into your iOS project using Swift Package Manager.

### Swift Package Manager

1. In Xcode, select "File" > "Swift Packages" > "Add Package Dependency..."
2. Enter the BubbleSpot GitHub repository URL: `https://github.com/agustiyann/BubbleSpot.git`
3. Follow the prompts to complete the installation.

## Usage

To use BubbleSpot in your project, follow these simple steps:

1. Import the BubbleSpot module wherever you plan to use it:

```swift
import BubbleSpot
```

2. Create a BubbleSpot instance with the target view, tooltip text, and arrow position:

```swift
let bubble = BubbleSpot(targetView: targetView, text: "Your tooltip text here", arrowPosition: .top)
```

3. Customize the tooltip appearance (optional):

```swift
bubble.backgroundColor = .black
bubble.textColor = .white
bubble.arrowColor = .black
```

4. Show the tooltip:

```swift
bubble.show()
```

5. Dismiss the tooltip (optional):

```swift
bubble.dismiss()
```

## Example

Here's a simple example demonstrating how to use BubbleSpot:

```swift
import UIKit
import BubbleSpot

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a target view
        let button = UIButton(type: .system)
        button.setTitle("Tap me", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        // Add constraints for the button
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func buttonTapped() {
        // Create and show a tooltip
        let bubble = BubbleSpot(targetView: view, text: "This is a tooltip", arrowPosition: .top)
        bubble.show()
    }
}
```

## Contributing

Contributions to BubbleSpot are welcome! If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

BubbleSpot is available under the MIT license. See the [LICENSE](LICENSE.md) file for more information.
