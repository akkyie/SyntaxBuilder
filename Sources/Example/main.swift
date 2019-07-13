import SyntaxBuilder

let sourceFile = SourceFile {
    Import("Foundation")

    Struct("User") {
        Typealias("ID", of: String.self)
        Let("name", of: String.self)
        Var("age", of: Int.self)
    }
}

let writer = SourceWriter(source: sourceFile, format: Format(indentWidth: 4))

var str: String = ""
writer.write(to: &str)

print(str)
