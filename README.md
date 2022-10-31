# Opaque Identifier

> Or at least translucent

[![CI](https://github.com/schrismartin/swift-opaque-identifier/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/schrismartin/swift-opaque-identifier/actions/workflows/ci.yml)

`OpaqueIdentifier` offers a type that can exist in-place of `Int`, `UUID`, or `String`-based identifiers. When working in client-side development, we often don't care about the underlying type of the identifier. This type erases incoming identifiers while preserving their ability to be printed and re-encoded.

## Usage

Use the identifier in place of an `Int`, `UUID`, or `String` in your `Codable`-conforming models.

```swift
struct MyType: Codable {
  var id: OpaqueIdentifier
  ...
}
```

`OpaqueIdentifier` will decode the identifier as the most appropriate type, preserving type information to be re-encoded later.

You may access a string representation of the identifier through the type's `description` property. Though this is only recommended for use in debug and error-reporting contexts.

## Installation

This package can be installed via Swift Package Manager.

### Through Xcode

1. From the File menu, navigate through Swift Packages and select Add Package Dependency...
2. Enter package repository URL: https://github.com/schrismartin/swift-opaque-identifier.git
3. Confirm the version and let Xcode resolve the package
4. Add the package to the target that intends to use the package

### Through Swift Package Manager

If you want to use OpaqueIdentifier in any other project that uses SwiftPM, add the package as a dependency in Package.swift:

```swift
dependencies: [
  .package(
    url: "https://github.com/pointfreeco/swift-opaque-identifier",
    from: "0.1.0"
  ),
  ...
]
```

Next, add OpaqueIdentifier as a dependency of your test target:

```swift
targets: [
  .target(
  	name: "MyApp"
  	dependencies: [
      .product(name: "OpaqueIdentifier", package: "swift-opaque-identifier"),
      ...
    ]
  ),
  ...
]
```

## Motivation

When working as a client of an API, we commonly deal with an influx of data of all shapes and sizes. Especially when working in strongly-typed languages, it's important that we make the right decisions involving domain modeling. Identifiers are an interesting problem, because different identifiers come with different tradeoffs. For example,
- Integer-based identifiers are generally created in increments. However, depending on how many bytes you associate with that integer, you can unexpectedly exceed the limit of identifiers you can make within that fixed-width amount.
- String-based identifiers can be more expensive to work with on the backend, especially when used as primary keys in databases.
- UUID-based identifiers (128 bits) are larger than their 32-bit integer cousins, and they still have a (really small, [but nonzero](https://github.com/ramsey/uuid/issues/80)) chance of generating collisions.

However, as a client-side engineer, **I rarely have to worry about these problems** due to the scale of the information a client-side program realistically has to consider. These will (of course) vary by use cases, but I've found this statement to be broadly applicable.

### The Problem

Now, we don't always have the opportunity to decide how our APIs represent their IDs. Worse yet, we can't always influence how they evolve. While our client and server may have once agreed that a 32-bit integer is sufficient to handle our represent our IDs, unexpected growth may eventually push past that [2.1 billion](https://en.wikipedia.org/wiki/2,147,483,647) mark and wreak havoc on the backend. Remote databases can quickly migrate to a larger integer size, but mobile clients can't immediately upgrade to client with a safer size. This leaves mobile users with downtime that would easily drop us below [three-nines of availability](https://en.wikipedia.org/wiki/High_availability). 

Sometimes backends will innovate by encoding metadata into their ID's to shortcut otherwise expensive operations. This is especially prevalent when encoding ID's as strings, as you have unbounded potential to add prefixes and symbols and all sorts of data into your identifiers. Clients can pick up on these (often informal) conventions, permanently enshrining these hacks into your API.  

### Principles

As a client, I want the following properties from my identifiers:

- **Uniquely Referenceable** – One identifier should uniquely identify one item. This means that two items with the same identifier are actually referring to the same identity, signifying a change in the properties of the object but not a change in the object itself.
- **Deserializable** – If something gives me an identifier in raw form (i.e. backend, remote device, etc), I should be able to store it in memory.
- **Serializable** – If I have the identifier, I should be able to write it to disk or send it to a backend.
- **Communicable** – If I'm working with another person, I should be able to have a discussion with them (or report a problem with them) and be able to use this identifier to refer to an object.

Conversely, I **do not** care about the following properties in an identifier:

- **Generatable** – I don't care about generating an ID. I want this responsibility to exist on the backend. Even in the infinitesimally small chance that I were to generate a collision with a UUID, I don't have the backend's ability to ensure there are no duplicates.
- **Modifiable** – We're dealing with identity here. As a client, there is no circumstance where I want to be making changes to identifiers. 
- **Introspectable** – Sometimes identifiers have embedded context in them. I have never happened upon an API where this embedded context is written into the API contract. As such, I should never be deriving context of an object based on its identifier. 

### Proposed Solution

Given an identifier that hides its implementation, I no longer need to worry about its representation. As long as it fulfills the above principles, we can use these identifiers as opaque tokens within our applications. 
