## Value Types and Reference Types

We are just going to explore how `classes` and `structure` differs in the context of _Memory Management_


## Passing by Value

We have to keep in mind that _instances_ of `structures` and `enumerations` are _passed by value_

One good example of a `structure` is the `String` data type. If you look it on the documentation, `String` is a structure. Let's illustrate it with an example:

### What Does Passing by Value Mean?

```swift
var string1 = "Hello, playground"
var string2 = string1
```

The value stored in `string1` is equal to the value stored in `string2`

```swift
if string1 == string2 {
    print("string1 is equal to string2") // this one gets print out
} else {
    print("string1 is NOT equal to string2")
}
```


But what happens if we change the value of `string1`? `string2` value is not affected by that change even though we created `string2` using `string1`. This is what _instances of structures and enumerations are passed by value_ means.

Under the hood, the value of `string2` is just a copy of the value of `string1`. This means that separate values are stored in `string1` and `string2`. Values are equal, but they differ in memory. When we assign the `string2` value with `string1`, it was _passed by value_


## What Does Passing by Reference Mean?

First let's define a `class` Person and create an instance of it.

```swift
class Person {
    var first: String
    var last: String
    
    init(first: String, last: String) {
        self.first = first
        self.last = last
    }
}

let lucas = Person(first: "John", last: "Lucas")
lucas.first // "John"
lucas.last // "Lucas"

```

Now let's declared a new constant and assign the value stored in `lucas` to this new constant

```swift
let chabby = lucas
chabby.first // "John"
chabby.last // "Lucas"
```


Now observe what happens when we modify the first name of Chabby

```
chabby.first = "Chabby"
chabby.first // "Chabby"
lucas.first // "Chabby"
```


The value stored in the `first` property of `lucas` got modified as well. This is what _instances of classes are passed by reference_ means. When we assign `lucas` constant to `chabby` constant, the value of `lucas` is not a copy. Instead it's a reference/pointer of the `Person` instance stored in `lucas` was assigned to `chabby`. Meaning, both `lucas` and `chabby` points to the same instance and only one instance is present in the memory.


## Memory Management

We may be wondering why it is important to know and understand the difference between a reference types and value types. If we are working with Swift memory management, we should know these differences in this context


The good thing with `structs` and `enums` is that we do not need to worry about their memory management. It's the compiler's job to do the memory management of `structs` and `enums`. Because they are _passed by value_, the compiler is smart enough to know when to dispose their instances.


Meanwhile, with `classes`, this is not the case. Though most of the time we do not need to worry with its instances, but it doesn't mean we shouldn't worry at all about its memory management. 


## What is ARC?

ARC is short for Automatic Reference Counting. In programming, it's essential that an object or an instance of a class, structure or enumerations gets deallocated when it is no longer needed! When an object get deallocated, the memory it occupies gets freed. This is important in context for performance and efficiency of the system.


Because class instances are passed by reference, it is possible for its properties, constants, and variables to keep a reference to a class instance. Though doing this is useful when needed, it makes it difficult for the compiler to know and understand when it is safe to deallocate a class instance.

To make the compiler's task easier, Swift uses ARC. ARC keeps track of class instances and it decides when it is safe to deallocate the class instances it monitors. ARC does this by counting the references of each class instance. 


Let's make an example:

```swift
class Device {
    let model: String
    let manufacturer: String
    
    init(model: String, manufacture: String) {
        self.model = model
        self.manufacturer = manufacture
    }
}
```

Before we make an instance of this, let's create two variables of this type

```swift
var lucasDevice: Device?
var chabbyDevice: Device?
```

Now let's create a `Device` instance and assign it to `lucasDevice`

```swift
lucasDevice = Device(model: "iPhone 12 Pro Max", manufacture: "Apple")
```

Because `lucasDevice` variable holds a reference to the `Device` instance we just created, this instance isn't deallocated yet


ARC ensures that class intances doesn't get deallocated as long as a property, constance or variable keeps a strong reference to the class instance.


Again, ARC keeps count of the number of references to a class instance. A reference count. It does this to understand when it is safe to dispose a class instance.

To demonstrate the job of ARC, we can store another reference to the `Device` instance we created with `lucasDevice` to `chabbyDevice`. Doing this, both of them will point to the same `Device` instance and only one `Device` instance is in the memory.


```swift
chabbyDevice = lucasDevice
```

Now, the reference count of the `Device` instance is 2. We can decrement this by setting `lucasDevice` to nil, but because `chabbyDevice` continues to hold a reference to the `Device` instance, it doesn't get deallocated yet. This proves that both constants point to a same instance.

```swift
lucasDevice = nil
```


The moment we set `chabbyDevice` to nil, the `Device` instance it holds doesn't have a reference anymore, therefore the `Device` instance gets deallocated and this means that the memory it takes is now freed. That is the goal of ARC. We can verify this using the `deinit` method from the class

```swift
deinit {
    print("\(model) is now deallocated")
}
```




























