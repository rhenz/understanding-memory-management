# What is the Difference Between Strong, Weak and Unowned References?

The key difference between Strong and  Weak or Unowned References is that _Strong Reference_ prevents the class instance it points to from being deallocated. 

Keep in mind that `ARC` keeps track of the number of strong references to a class instances. This is known also as the `retain count` of a class instance. The class cannot be deallocated as long as there is at least one strong reference points to the class instance. 


`weak` and `unowned` references also point to a class instance. The difference is that `ARC` doesn't care if these references gets deallocated. `weak` and `unowned` references cannot prevent a class instance from being deallocated.


## What is the Difference Between `weak` and `unowned` references?

So when should we choose an `unowned` reference over a `weak` reference?


## What is `weak` reference?

A reference should be mark as `weak` if it is possible that the _class instance_ the reference points to is deallocated at some point in the future. This means that a `weak` reference can become `nil` during its lifetime.


- `ARC` automatically sets a `weak` reference to `nil` when the class instance it points to is deallocated. That's a good thing. We don't want to have a reference pointing to a class instance that no longer exists.
- `ARC` sets a `weak` reference to `nil` when the class instance is deallocated, `weak` reference always need to be declared as optionals.
- This implies that `weak` reference should always be declared as `var`

## What is `unowned` reference?

An `unowned` reference is always expected to point to a class instance. That is important to understand and remember! Because an `unowned` reference should always points to a class instance, it isn't necessary to declared it as optional. This makes `unowned` references more convenient than `weak` references, which are required to be an optional type.


Always be mindful with using `unowned` references! We are responsible for making sure that an `unowned` reference always points to a class instance. If we attempt to access an `unowned` reference that no longer points to a class instance(got deallocated already), a runtime error is thrown and your app will crash.


## Rules of thumb!

Use `weak` reference if the class instance the reference points to has a shorter lifespan than the object that owns the reference. If you are not sure, just use `weak` reference

Use `unowned` reference if the reference is guaranteed to always points to a class instance. An `unowned` reference is an option if the class instance the reference points to has a lifetime that exceeds or is equal to that of the object that owns the reference


## Defensive programming!

If we are not sure if a property should be declared as `weak` or `unowned`, then can always use `weak`. A `weak` reference cannot cause harm unlike `unowned`.  A property that is declared as unowned behaves similarly to an implicitly unwrapped optional that is defined as weak. Remember that implicitly unwrapped optionals come with a warning.