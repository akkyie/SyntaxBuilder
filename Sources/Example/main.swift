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
