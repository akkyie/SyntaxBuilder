import SyntaxBuilder

let sourceFile = SourceFile {
    Import("Foundation")

    Struct("User") {
        Typealias("ID", of: String.self)

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

let writer = SourceWriter(source: sourceFile, format: Format(indentWidth: 4))

var str: String = ""
writer.write(to: &str)

print(str)
