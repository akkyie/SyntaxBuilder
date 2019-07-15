import SwiftSyntax

public protocol ExprListBuildable: SyntaxListBuildable {
    func buildExprList(format: Format, leadingTrivia: Trivia?) -> [ExprSyntax]
}

public protocol ExprBuildable: SyntaxBuildable, ExprListBuildable {
    func buildExpr(format: Format, leadingTrivia: Trivia?) -> ExprSyntax
}

extension ExprBuildable {
    public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
        buildExpr(format: format, leadingTrivia: leadingTrivia)
    }

    public func buildExprList(format: Format, leadingTrivia: Trivia?) -> [ExprSyntax] {
        [buildExpr(format: format, leadingTrivia: leadingTrivia)]
    }
}
