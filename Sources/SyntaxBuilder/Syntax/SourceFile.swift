import SwiftSyntax

public struct SourceFile: SyntaxBuildable {
    let builder: CodeBlockItemListBuildable

    public init(@CodeBlockBuilder _ makeBuilder: () -> CodeBlockItemListBuildable) {
        builder = makeBuilder()
    }

    public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
        let statements = builder.buildCodeBlockItemList(format: format, leadingTrivia: nil)
        let eofToken = SyntaxFactory.makeToken(.eof, presence: .present)

        return SyntaxFactory.makeSourceFile(
            statements: statements,
            eofToken: eofToken
        )
    }
}
