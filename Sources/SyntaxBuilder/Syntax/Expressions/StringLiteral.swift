import SwiftSyntax

public struct StringLiteral: ExprBuildable {
    let value: String

    public init(_ value: String) {
        self.value = value
    }

    public func buildExpr(format: Format, leadingTrivia: Trivia?) -> ExprSyntax {
        SyntaxFactory.makeStringLiteralExpr(value)
    }
}

extension StringLiteral: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}
