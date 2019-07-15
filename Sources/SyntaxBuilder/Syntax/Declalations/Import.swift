import SwiftSyntax

public struct Import: DeclBuildable {
    let module: String

    public init(_ module: String) {
        self.module = module
    }

    public func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax {
        let moduleToken = SyntaxFactory.makeIdentifier(module)

        return SyntaxFactory.makeImportDecl(
            attributes: nil,
            modifiers: nil,
            importTok: Tokens.import.with(leading: leadingTrivia),
            importKind: nil,
            path: SyntaxFactory.makeAccessPath([
                SyntaxFactory.makeAccessPathComponent(name: moduleToken, trailingDot: nil),
            ])
        )
    }
}
