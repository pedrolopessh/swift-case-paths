// swift-tools-version: 6.0

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "swift-case-paths",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "CasePaths",
      targets: ["CasePaths"]
    )
  ],
  dependencies: [
	.package(url: "https://github.com/sjavora/swift-syntax-xcframeworks", exact: "510.0.1"),
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.2.2"),
    .package(url: "https://github.com/pedrolopessh/swift-macro-testing", branch: "swift-syntax-test"),
  ],
  targets: [
    .target(
      name: "CasePaths",
      dependencies: [
        "CasePathsMacros",
        .product(name: "IssueReporting", package: "xctest-dynamic-overlay"),
        .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
      ]
    ),
    .testTarget(
      name: "CasePathsTests",
      dependencies: ["CasePaths"]
    ),
    .macro(
      name: "CasePathsMacros",
      dependencies: [
//        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
//        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
		.product(name: "SwiftSyntaxWrapper", package: "swift-syntax-xcframeworks"),
      ]
    ),
    .testTarget(
      name: "CasePathsMacrosTests",
      dependencies: [
        "CasePathsMacros",
        .product(name: "MacroTesting", package: "swift-macro-testing"),
      ]
    ),
  ],
  swiftLanguageVersions: [.v6]
)

#if !os(Windows)
  // Add the documentation compiler plugin if possible
  package.dependencies.append(
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  )
#endif
