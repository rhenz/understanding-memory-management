# How to use a capture list to break a retain cycle


```swift
import UIKit

class RootViewController: UIViewController {

    // MARK: - Properties

    private lazy var settingsViewController: SettingsViewController = {        
        let settingsViewController = SettingsViewController()

        // Install Handler
        settingsViewController.didModifySettings = {
            self.updateView()
        }

        return settingsViewController
    }()

    // MARK: - Navigation

    @IBAction func showSettings(_ sender: Any) {
        // Present Settings View Controller
        present(settingsViewController, animated: true)
    }

    // MARK: - View Methods

    private func updateView() {}

}

class SettingsViewController: UIViewController {

    // MARK: - Properties

    var didModifySettings: (() -> Void)?

    // MARK: - Actions

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
}

```

In the example above, the RootViewController holds a strong reference to the `Settings View Controller` through the `settingsViewController` property. The `Settings View Controller` _indirectly_ holds a strong reference to the `Root View Controller` through its `didModifySettings` handler.



## Capturing values

When a closure captures a value from its surrounding scope, Swift is responsible for managing the memory for that value and because of that we are responsible in helping ARC in giving instruction to avoid _retain cycle_.

```swift
private lazy var settingsViewController: SettingsViewController = {        
    let settingsViewController = SettingsViewController()

    // Install Handler
    settingsViewController.didModifySettings = {
        self.updateView()
    }

    return settingsViewController
}()

```

Let's revisit this _lazy property_. The closure we assign in the `didModifySettings` property of the `settingsViewController` captures `self` which in this context is the `RootViewController` instance. Meaning, the closure holds a strong reference to the `RootViewController` instance. Because the `RootViewController` also holds a strong reference to the `SettingsViewController` instance, we introduce a `reference cycle` or `retain cycle` in this case.

We need to prevent the closure from holding a strong reference to `self` or the `RootViewController` to prevent _retain cycles_.



## Defining a capture list

The references a closure holds to reference types are `strong` by default. We can change this behavior by defining a `capture list`. This is how we are going to do it with our example:

```swift
private lazy var settingsViewController: SettingsViewController = {        
    let settingsViewController = SettingsViewController()

    // Install Handler
    settingsViewController.didModifySettings = { [weak self]
        self?.updateView()
    }

    return settingsViewController
}()

```

Remember that `weak` reference is always an optional type.



The `Settings View Controller` is owned by the `Root View Controller` and that implies that we can be sure that the `Root View Controller` is deallocated after the `Settings View Controller`. This means we could use the `unowned` reference instead of `weak` reference to the root view controller.


```swift
private lazy var settingsViewController: SettingsViewController = {        
    let settingsViewController = SettingsViewController()

    // Install Handler
    settingsViewController.didModifySettings = { [unowned self]
        self.updateView()
    }

    return settingsViewController
}()

```



