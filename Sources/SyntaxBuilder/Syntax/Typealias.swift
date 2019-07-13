import SwiftSyntax

public struct Typealias: DeclBuildable {
    let name: String
    let type: String

    public init(_ name: String, of type: String) {
        self.name = name
        self.type = type
    }

    public init<T>(_ name: String, of type: T.Type) {
        self.name = name
        self.type = String(describing: type)
    }

    public func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax {
        let identifier = SyntaxFactory.makeIdentifier(name)

        let initializer = SyntaxFactory.makeTypeInitializerClause(
            equal: Tokens.equal,
            value: SyntaxFactory.makeTypeIdentifier(type)
        )

        return SyntaxFactory.makeTypealiasDecl(
            attributes: nil,
            modifiers: nil,
            typealiasKeyword: Tokens.typealias.with(leading: leadingTrivia),
            identifier: identifier,
            genericParameterClause: nil,
            initializer: initializer,
            genericWhereClause: nil
        )
    }
}
