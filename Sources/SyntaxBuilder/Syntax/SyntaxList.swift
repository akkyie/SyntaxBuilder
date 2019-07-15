import SwiftSyntax

public struct SyntaxList: SyntaxListBuildable {
    let builders: [SyntaxListBuildable]

    public func buildSyntaxList(format: Format, leadingTrivia: Trivia?) -> [Syntax] {
        func trivia(for index: Int) -> Trivia {
            index == builders.startIndex
                ? leadingTrivia ?? .zero
                : (leadingTrivia ?? .zero).appending(format.makeNewline())
        }

        return builders
            .enumerated()
            .flatMap { index, builder in
                builder.buildSyntaxList(format: format, leadingTrivia: trivia(for: index))
        }
    }
}
