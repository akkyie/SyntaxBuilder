import SwiftSyntax

public struct DeclList: DeclListBuildable {
    let builders: [DeclListBuildable]

    public func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax] {
        builders.flatMap { $0.buildDeclList(format: format, leadingTrivia: leadingTrivia) }
    }

    public func buildSyntaxList(format: Format, leadingTrivia: Trivia?) -> [Syntax] {
        buildDeclList(format: format, leadingTrivia: leadingTrivia)
    }
}

extension DeclList {
    public static var empty: DeclList {
        DeclList(builders: [])
    }
}
