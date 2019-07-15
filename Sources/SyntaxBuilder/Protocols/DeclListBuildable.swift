import SwiftSyntax

public protocol DeclListBuildable: SyntaxListBuildable {
    func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax]
}

public protocol DeclBuildable: SyntaxBuildable, DeclListBuildable {
    func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax
}

extension DeclBuildable {
    public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
        buildDecl(format: format, leadingTrivia: leadingTrivia)
    }

    public func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax] {
        [buildDecl(format: format, leadingTrivia: leadingTrivia)]
    }
}
