import SwiftSyntax

public protocol CodeBlockItemListBuildable: SyntaxBuildable {
    func buildCodeBlockItemList(format: Format, leadingTrivia: Trivia?) -> CodeBlockItemListSyntax
}

extension CodeBlockItemListBuildable {
    public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
        buildCodeBlockItemList(format: format, leadingTrivia: leadingTrivia)
    }
}

public struct CodeBlock: CodeBlockItemListBuildable {
    let builders: [SyntaxBuildable]

    public func buildCodeBlockItemList(format: Format, leadingTrivia: Trivia?) -> CodeBlockItemListSyntax {
        let itemList: [CodeBlockItemSyntax] = builders.enumerated().map { index, builder in
            let isFirst = index == builders.startIndex
            let leadingTrivia = isFirst ? leadingTrivia : format.makeNewline()
            return SyntaxFactory.makeCodeBlockItem(
                item: builder.buildSyntax(format: format, leadingTrivia: leadingTrivia),
                semicolon: nil,
                errorTokens: nil
            )
        }
        return SyntaxFactory.makeCodeBlockItemList(itemList)
    }
}
