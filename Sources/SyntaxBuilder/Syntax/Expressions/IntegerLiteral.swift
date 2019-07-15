import SwiftSyntax

public struct IntegerLiteral: ExprBuildable {
    let value: Int

    public func buildExpr(format: Format, leadingTrivia: Trivia?) -> ExprSyntax {
        SyntaxFactory.makeIntegerLiteralExpr(
            digits: SyntaxFactory.makeIntegerLiteral(String(value))
        )
    }
}

extension IntegerLiteral: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(value: value)
    }
}
