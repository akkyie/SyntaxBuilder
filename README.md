# SyntaxBuilder

A *toy* Swift code generator based on SwiftSyntax, leveraging [`Function Builders`](https://github.com/apple/swift-evolution/blob/9992cf3c11c2d5e0ea20bee98657d93902d5b174/proposals/XXXX-function-builders.md).

## Requirements

Xcode 11 beta-bundled Swift 5.1

## Example (or everything currently implemented)

```swift
import SyntaxBuilder

let sourceFile = SourceFile {
    Import("Foundation")

    Struct("User") {
        Let("name", of: String.self)
        Var("age", of: Int.self)
    }
}

let writer = SourceWriter(source: sourceFile, format: Format(indentWidth: 4))

var str: String = ""
writer.write(to: &str)

print(str)
```

results in:

```swift
import Foundation
struct User {
    let name: String
    var age: Int
}
```