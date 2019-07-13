import SwiftSyntax

public protocol SourceFile {
    typealias Body = SyntaxListBuildable

    var body: Body { get }
}

public extension SourceFile {
    func write<Output: TextOutputStream>(to output: inout Output, format: Format = .default) {
        let sourceFile = SourceFileBuilder(builder: body)
        let syntax = sourceFile.buildSyntax(format: format, leadingTrivia: nil)
        syntax.write(to: &output)
    }
}

private struct SourceFileBuilder: SyntaxBuildable {
    let builder: SyntaxListBuildable

    func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
        let syntaxList = builder.buildSyntaxList(format: format, leadingTrivia: leadingTrivia)
        let itemList: [CodeBlockItemSyntax] = syntaxList.enumerated().map { index, syntax in
            return SyntaxFactory.makeCodeBlockItem(
                item: syntax,
                semicolon: nil,
                errorTokens: nil
            )
        }

        let codeBlockItemList = SyntaxFactory.makeCodeBlockItemList(itemList)

        return SyntaxFactory.makeSourceFile(
            statements: codeBlockItemList,
            eofToken: Tokens.eof
        )
    }
}
