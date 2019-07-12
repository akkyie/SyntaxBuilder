import SwiftSyntax

public protocol VariableMutability {
    static var token: TokenSyntax { get }
}

public enum VariableLetMutability: VariableMutability {
    public static let token = SyntaxFactory.makeLetKeyword()
}

public enum VariableVarMutability: VariableMutability {
    public static let token = SyntaxFactory.makeVarKeyword()
}

public typealias Let = Variable<VariableLetMutability>
public typealias Var = Variable<VariableVarMutability>

public struct Variable<Mutability: VariableMutability>: DeclBuildable {
    let name: String
    let type: String

    public init(_ name: String, type: String) {
        self.name = name
        self.type = type
    }

    public init<T>(_ name: String, of type: T.Type) {
        self.name = name
        self.type = String(describing: type)
    }

    public func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax {
        let mutabilityKeyword = Mutability.token
            .withLeadingTrivia(leadingTrivia ?? .zero)
            .withTrailingTrivia(.spaces(1))

        let nameIdentifier = SyntaxFactory.makeIdentifier(name)
        let typeIdentifier = SyntaxFactory.makeTypeIdentifier(type)
        let colon = SyntaxFactory.makeColonToken().withTrailingTrivia(.spaces(1))

        return SyntaxFactory.makeVariableDecl(
            attributes: nil,
            modifiers: nil,
            letOrVarKeyword: mutabilityKeyword,
            bindings: SyntaxFactory.makePatternBindingList([
                SyntaxFactory.makePatternBinding(
                    pattern: SyntaxFactory.makeIdentifierPattern(identifier: nameIdentifier),
                    typeAnnotation: SyntaxFactory.makeTypeAnnotation(colon: colon, type: typeIdentifier),
                    initializer: nil,
                    accessor: nil,
                    trailingComma: nil
                )
            ])
        )
    }
}
