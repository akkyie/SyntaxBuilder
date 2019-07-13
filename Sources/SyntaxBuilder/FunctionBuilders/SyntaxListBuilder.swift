import SwiftSyntax

@_functionBuilder
public struct SyntaxListBuilder {
    public static func buildBlock(_ builders: SyntaxBuildable...) -> SyntaxListBuildable {
        return CodeBlock(builders: builders)
    }
}
