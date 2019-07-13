import SwiftSyntax

public protocol TypeBuildable: SyntaxBuildable {
    func buildType(format: Format, leadingTrivia: Trivia?) -> TypeSyntax
}

extension TypeBuildable {
    public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
        buildType(format: format, leadingTrivia: leadingTrivia)
    }
}
