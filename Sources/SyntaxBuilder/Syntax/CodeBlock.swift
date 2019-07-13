import SwiftSyntax

public struct CodeBlock: SyntaxListBuildable {
    let builders: [SyntaxBuildable]

    public func buildSyntaxList(format: Format, leadingTrivia: Trivia?) -> [Syntax] {
        func trivia(for index: Int) -> Trivia {
            index == builders.startIndex
                ? leadingTrivia ?? .zero
                : (leadingTrivia ?? .zero).appending(format.makeNewline())
        }

        return builders
            .enumerated()
            .map { index, builder in
                builder.buildSyntax(format: format, leadingTrivia: trivia(for: index))
            }
    }
}
