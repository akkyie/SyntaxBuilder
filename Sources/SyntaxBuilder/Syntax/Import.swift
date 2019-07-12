import SwiftSyntax

public struct Import: SyntaxBuildable {
    let module: String

    public init(_ module: String) {
        self.module = module
    }

    public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
        let importToken = SyntaxFactory.makeImportKeyword(
            leadingTrivia: leadingTrivia ?? .zero,
            trailingTrivia: .spaces(1)
        )

        let moduleToken = SyntaxFactory
            .makeIdentifier(module)

        return SyntaxFactory.makeImportDecl(
            attributes: nil,
            modifiers: nil,
            importTok: importToken,
            importKind: nil,
            path: SyntaxFactory.makeAccessPath([
                SyntaxFactory.makeAccessPathComponent(name: moduleToken, trailingDot: nil),
            ])
        )
    }
}
