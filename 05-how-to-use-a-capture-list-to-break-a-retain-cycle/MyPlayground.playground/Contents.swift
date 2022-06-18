import UIKit

class RootViewController: UIViewController {

    // MARK: - Properties

    private lazy var settingsViewController: SettingsViewController = {
        // Initialize Settings View Controller
//        guard let settingsViewController = UIStoryboard.main.instantiateViewController(withIdentifier: SettingsViewController.storyboardIdentifier) as? SettingsViewController else {
//            fatalError("Unable to Instantiate Settings View Controller")
//        }
        
        let settingsViewController = SettingsViewController()

        // Install Handler
        settingsViewController.didModifySettings = { [unowned self] in
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


/*:
 In the example above, the RootViewController holds a strong reference to the `Settings View Controller` through the `settingsViewController` property. The `Settings View Controller` _indirectly_ holds a strong reference to the `Root View Controller` through its `didModifySettings` handler.
 */


