import SwiftSyntax

public protocol SyntaxBuildable {
    func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax
}
