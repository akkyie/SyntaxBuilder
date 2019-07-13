import SwiftSyntax

public enum Type: TypeBuildable {
    case type(String)
    case tuple([(String, String)])

    public func buildType(format: Format, leadingTrivia: Trivia?) -> TypeSyntax {
        switch self {
        case let .type(name):
            return SyntaxFactory.makeTypeIdentifier(name)

        case let .tuple(names):
            let elements: [TupleTypeElementSyntax] = names.enumerated().map { index, type in
                let (name, typeName) = type
                let isLast = index == names.endIndex - 1
                return SyntaxFactory.makeTupleTypeElement(
                    inOut: nil,
                    name: name.isEmpty ? nil : SyntaxFactory.makeIdentifier(name),
                    secondName: nil,
                    colon: name.isEmpty ? nil : Tokens.colon.with(trailing: .space),
                    type: SyntaxFactory.makeTypeIdentifier(typeName),
                    ellipsis: nil,
                    initializer: nil,
                    trailingComma: isLast ? nil : Tokens.comma
                )
            }

            let elementList = SyntaxFactory.makeTupleTypeElementList(elements)

            return SyntaxFactory.makeTupleType(
                leftParen: Tokens.paren.left,
                elements: elementList,
                rightParen: Tokens.paren.right
            )
        }
    }
}

extension Type: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .type(value)
    }
}


extension Type: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: String...) {
        switch elements.count {
        case 0: self = .type("Void")
        case 1: self = .type(elements[0])
        default: self = .tuple(elements.map { ("", $0) })
        }
    }
}
