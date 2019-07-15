import SwiftSyntax

/// - Note: Currently supports repeating only a single element.
public struct ForEach<Builder: SyntaxListBuildable>: SyntaxListBuildable {
    let builders: [Builder]

    public init<T: Sequence>(_ sequence: T, makeBuilder: (T.Element) -> Builder) {
        self.builders = sequence.map(makeBuilder)
    }

    public func buildSyntaxList(format: Format, leadingTrivia: Trivia?) -> [Syntax] {
        builders.flatMap { $0.buildSyntaxList(format: format, leadingTrivia: leadingTrivia) }
    }
}

extension ForEach: DeclListBuildable where Builder: DeclListBuildable {
    public func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax] {
        DeclList(builders: builders).buildDeclList(format: format, leadingTrivia: leadingTrivia)
    }
}
