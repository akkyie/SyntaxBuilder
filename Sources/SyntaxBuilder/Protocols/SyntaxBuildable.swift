import SwiftSyntax

public protocol SyntaxListBuildable {
    func buildSyntaxList(format: Format, leadingTrivia: Trivia?) -> [Syntax]
}

public protocol SyntaxBuildable: SyntaxListBuildable {
    func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax
}

extension SyntaxBuildable {
    public func buildSyntaxList(format: Format, leadingTrivia: Trivia?) -> [Syntax] {
        [buildSyntax(format: format, leadingTrivia: leadingTrivia)]
    }
}
