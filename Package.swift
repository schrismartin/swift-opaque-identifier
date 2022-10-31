// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swift-opaque-identifier",
  products: [
    .library(
      name: "OpaqueIdentifier",
      targets: ["OpaqueIdentifier"]
    ),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "OpaqueIdentifier",
      dependencies: []
    ),
    .testTarget(
      name: "OpaqueIdentifierTests",
      dependencies: ["OpaqueIdentifier"]
    ),
  ]
)
