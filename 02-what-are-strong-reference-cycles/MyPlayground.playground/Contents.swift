import UIKit

/*: ### What Is A Strong Reference
 
 A reference to a class instance is **strong** by default.
 */


class Device {
    
    let model: String
    let manufacturer: String
    
    init(model: String, manufacturer: String) {
        self.model = model
        self.manufacturer = manufacturer
    }
    
}

var deviceJim: Device?
var deviceJane: Device?

deviceJim = Device(model: "iPhone 7", manufacturer: "Apple")


//: The `deviceJim` variable holds a strong reference to the `Device` instance. _Strong_ means that the class instance the reference points to cannot be deallocated as long as the reference exists. A strong reference prevents the class instance it points to from being deallocated





/*: ### ## What is a Reference Cycle?
 
 A strong reference prevents the class instance it points to from being deallocated and it could pose a risk.
 
 
 ### Delegation
 Delegation pattern is the most common and powerful pattern we use in iOS Development and even Apple's frameworks use it a lot. For example, the `UITableView`. A table view is not responsible for handling user interaction. It delegates that responsibility to a delegate, an object that conforms to the `UITableViewDelegate` protocol. Means that the `UITableView` informs its delegate when a user scroll or taps a row in the table view. By delegating user interaction to a deleagte, the `UITableView` class is flexible and reusable.
 
 A view controller that uses a table view usually holds a strong reference to the table view
 */

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    // MARK: -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


/*: ### Dependencies
 Strong reference cycles can also be caused by objects that depend on one another. For example when we sign up to a video streaming service, we create an `account` and we choose a `plan`. The `account` references the `plan` we chose and the `plan` references the `account` we created.
 
 Because references are strong by default, the `account` keeps a strong reference to the `plan` and vice versa. This means we end up with another strong reference cycle
 
 
 ### Closures
 Another common source of reference cycles or retain cycle is through the use of `closures`. `Closures` are a powerful tool in our toolbox, but we always need to be mindful of memory management when we are using it.
 
 Like classes, `closures` are reference types. Because a `closure` can capture values from its surrounding scope, a `closure` can introduce a reference cycle.
 */


class RootViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var settingsViewController: SettingsViewController = {
        // Initialize Settings View Controller
//        guard let settingsViewController = UIStoryboard.main.instantiateViewController(withIdentifier: SettingsViewController.storyboardIdentifier) as? SettingsViewController else {
//            fatalError("Unable to Instantiate Settings View Controller")
//        }
        
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
