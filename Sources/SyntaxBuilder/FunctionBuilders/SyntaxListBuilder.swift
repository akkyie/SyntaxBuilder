import SwiftSyntax

@_functionBuilder
public struct SyntaxListBuilder {
    public static func buildBlock(_ builders: SyntaxListBuildable...) -> SyntaxListBuildable {
        SyntaxList(builders: builders)
    }
}
