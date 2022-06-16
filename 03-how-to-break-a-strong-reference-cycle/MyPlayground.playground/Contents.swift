import UIKit

//: ### How to Break a Strong Reference Cycle


//: Strong reference cycles negatively impact our application's performance and they lead to memory leaks or unexpected behavior that is often hard to debug.




//: ### Turning Strong References Into Weak References

// The simple answer to our problem is just to make a strong reference into `weak reference`! And that will break the retain cycle.



//: ### What is A Weak Reference?


//: A `weak reference` is similar to a strong reference. It too points to a class instance and the difference is that a `weak reference` doesn't prevent a class instance from being deallocated. This means that a weak reference can be used to break a strong reference cycle/retain cycle.


//: With our previous example with `ViewController` having a  strong reference to `tableView`, and the `tableView.delegate` references the `ViewController`, under the hood, the implementation of UIKit framework with its tableView `delegate` keeps a `weak reference` to its delegate, therefore there wont be a strong reference cycle here.

//: if the view controller is deallocated, then the table view it references is also deallocated.





//: ### How to Use a Weak Reference?

//: We have to keep in mind that `weak reference` is not guaranteed to always have a value. Therefore, a weak reference is always of an optional type. If the class instance of the weak reference points to is deallocated, then the weak reference is automatically set to `nil`




//: ### Breaking a Strong Reference Cycle
//: In the previous example of `Account` and `Plan` classes, both these classes has a strong reference to each other.

/*:
 ```
class Account {

    // MARK: - Properties

    var plan: Plan!

}

class Plan {

    // MARK: - Properties

    let account: Account

    // MARK: - Initialization

    init(account: Account) {
        self.account = account
    }
}
 ```
*/

//: To break the `strong reference` between these two classes, we can declare the account property of the `Plan` class as weak

/*:
 ```
class Account {

    // MARK: - Properties

    var plan: Plan!

}

class Plan {

    // MARK: - Properties

    weak var account: Account?

    // MARK: - Initialization

    init(account: Account) {
        self.account = account
    }
}
 ```
 */

//: Defining the account property as an optional is okay, but it may be inconvenient. We KNOW that every `Plan` instance should have an `Account` instance associated with it. A workaround for this is by changing `weak` to `unowned` keyword. This turns `weak` reference into an `unowned` reference.

/*:
 ```
class Account {
    
    // MARK: - Properties
    
    var plan: Plan!
}

class Plan {
    
    // MARK: - Properties
    
    unowned var account: Account
    
    // MARK: - Initialization
    
    init(account: Account) {
        self.account = account
    }
}
 ```
 */

//: Once a plan is associated with an account, the account plan reference shouldn't change. An easy solution to this problem is to make the setter of account property as private

class Account {

    // MARK: - Properties

    var plan: Plan!

}

class Plan {

    // MARK: - Properties

    private(set) unowned var account: Account

    // MARK: - Initialization

    init(account: Account) {
        self.account = account
    }

}

