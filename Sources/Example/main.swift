import SyntaxBuilder

struct UserSourceFile: SourceFile {
    let idType: Type

    @SyntaxListBuilder
    var body: Body {
        Import("Foundation")

        Struct("User") {
            Typealias("ID", of: idType)

            Let("id", of: "ID")
                .prependingComment("The user's ID.", .docLine)

            Let("name", of: "String")
                .prependingComment("The user's name.", .docLine)

            Var("age", of: "Int", value: IntegerLiteral(0))
                .prependingComment("The user's age.", .docLine)
        }
        .prependingComment("""
            User is an user.
            <https://github.com/akkyie/SyntaxBuilder/>
        """, .docBlock)

        Func("test", ["foo": "String"], returns: "Void") {
            ForEach(0 ..< 5) { i in
                Let("value\(i)", of: "String", value: StringLiteral("Value \(i)"))
            }   
        }.prependingNewline()
    }
}

let user = UserSourceFile(idType: "String")

var str: String = ""
user.write(to: &str)

print(str)
