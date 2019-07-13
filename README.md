# SyntaxBuilder

A *toy* Swift code generator based on SwiftSyntax, leveraging [`Function Builders`](https://github.com/apple/swift-evolution/blob/9992cf3c11c2d5e0ea20bee98657d93902d5b174/proposals/XXXX-function-builders.md).

## Requirements

Xcode 11 beta-bundled Swift 5.1

## Example (or everything currently implemented)

```swift
import SyntaxBuilder

struct UserSourceFile: SourceFile {
    let idType: String

    @SyntaxListBuilder
    var body: Body {
        Import("Foundation")

        Struct("User") {
            Typealias("ID", of: idType)

            Let("id", of: "ID")
                .prependingComment("The user's ID.", .docLine)

            Let("name", of: String.self)
                .prependingComment("The user's name.", .docLine)

            Var("age", of: Int.self)
                .prependingComment("The user's age.", .docLine)
        }
        .prependingComment("""
            User is an user.
            <https://github.com/akkyie/SyntaxBuilder/>
        """, .docBlock)
    }
}

let user = UserSourceFile(idType: "String")

var str: String = ""
user.write(to: &str)

print(str)
```

results in:

```swift
import Foundation

/**
    User is an user.
    <https://github.com/akkyie/SyntaxBuilder/>
 */
struct User {
    typealias ID = String
    
    /// The user's ID.
    let id: ID
    
    /// The user's name.
    let name: String
    
    /// The user's age.
    var age: Int
}
```