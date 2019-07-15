import SwiftSyntax

public protocol TypeListBuildable: SyntaxListBuildable {
    func buildTypeList(format: Format, leadingTrivia: Trivia?) -> [TypeSyntax]
}

public protocol TypeBuildable: SyntaxBuildable, TypeListBuildable {
    func buildType(format: Format, leadingTrivia: Trivia?) -> TypeSyntax
}

extension TypeBuildable {
    public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
        buildType(format: format, leadingTrivia: leadingTrivia)
    }

    public func buildTypeList(format: Format, leadingTrivia: Trivia?) -> [TypeSyntax] {
        [buildType(format: format, leadingTrivia: leadingTrivia)]
    }
}
