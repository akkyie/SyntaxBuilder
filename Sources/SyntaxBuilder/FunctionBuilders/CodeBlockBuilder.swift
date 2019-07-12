import SwiftSyntax

@_functionBuilder
public struct CodeBlockBuilder {
    public static func buildBlock(_ builders: SyntaxBuildable...) -> CodeBlockItemListBuildable {
        return CodeBlock(builders: builders)
    }
}
