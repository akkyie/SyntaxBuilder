import SwiftSyntax

public protocol VariableMutability {
    static var token: TokenSyntax { get }
}

public enum VariableLetMutability: VariableMutability {
    public static let token = Tokens.let
}

public enum VariableVarMutability: VariableMutability {
    public static let token = Tokens.var
}

public typealias Let = Variable<VariableLetMutability>
public typealias Var = Variable<VariableVarMutability>

public struct Variable<Mutability: VariableMutability>: DeclBuildable {
    let name: String
    let type: Type
    let initializer: ExprBuildable?

    public init(_ name: String, of type: Type, value: ExprBuildable? = nil) {
        self.name = name
        self.type = type
        self.initializer = value
    }

    public func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax {
        let mutabilityKeyword = Mutability.token.with(leading: leadingTrivia)

        let nameIdentifier = SyntaxFactory.makeIdentifier(name)
        let typeIdentifier = type.buildType(format: format, leadingTrivia: nil)

        let initClause = initializer.flatMap { builder -> InitializerClauseSyntax in
            let expr = builder.buildExpr(format: format, leadingTrivia: leadingTrivia)
            return SyntaxFactory.makeInitializerClause(equal: Tokens.equal, value: expr)
        }

        let binding = SyntaxFactory.makePatternBinding(
            pattern: SyntaxFactory.makeIdentifierPattern(identifier: nameIdentifier),
            typeAnnotation: SyntaxFactory.makeTypeAnnotation(
                colon: Tokens.colon,
                type: typeIdentifier
            ),
            initializer: initClause,
            accessor: nil,
            trailingComma: nil
        )

        return SyntaxFactory.makeVariableDecl(
            attributes: nil,
            modifiers: nil,
            letOrVarKeyword: mutabilityKeyword,
            bindings: SyntaxFactory.makePatternBindingList([binding])
        )
    }
}
