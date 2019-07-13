import SwiftSyntax

public protocol SyntaxListBuildable {
    func buildSyntaxList(format: Format, leadingTrivia: Trivia?) -> [Syntax]
}
