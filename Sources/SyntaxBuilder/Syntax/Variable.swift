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
        let mutabilityKeyword = Mutability.token.with(leading: leadingTrivia)

        let nameIdentifier = SyntaxFactory.makeIdentifier(name)
        let typeIdentifier = SyntaxFactory.makeTypeIdentifier(type)

        let binding = SyntaxFactory.makePatternBinding(
            pattern: SyntaxFactory.makeIdentifierPattern(identifier: nameIdentifier),
            typeAnnotation: SyntaxFactory.makeTypeAnnotation(
                colon: Tokens.colon,
                type: typeIdentifier
            ),
            initializer: nil,
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
