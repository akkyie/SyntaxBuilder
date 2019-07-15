import SwiftSyntax

public struct Typealias: DeclBuildable {
    let name: String
    let type: Type

    public init(_ name: String, of type: Type) {
        self.name = name
        self.type = type
    }

    public func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax {
        let identifier = SyntaxFactory.makeIdentifier(name)

        let initializer = SyntaxFactory.makeTypeInitializerClause(
            equal: Tokens.equal,
            value: type.buildType(format: format, leadingTrivia: nil)
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
