import SwiftSyntax

/// Fixed and commonly used tokens.
enum Tokens {
    // MARK: Punctuations and Signs

    /// `", "`
    static let comma = SyntaxFactory.makeCommaToken().with(trailing: .space)

    /// `": "`
    static let colon = SyntaxFactory.makeColonToken().with(trailing: .space)

    /// `" = "`
    static let equal = SyntaxFactory.makeEqualToken().with(leading: .space, trailing: .space)

    /// `"("`, `")"`
    static let paren = (
        left: SyntaxFactory.makeLeftParenToken(),
        right: SyntaxFactory.makeRightParenToken()
    )

    /// `"{"`, `"}"`
    static let brace = (
        left: SyntaxFactory.makeLeftBraceToken(),
        right: SyntaxFactory.makeRightBraceToken()
    )

    // MARK: Variables

    static let `let` = SyntaxFactory.makeLetKeyword().with(trailing: .space)

    static let `var` = SyntaxFactory.makeVarKeyword().with(trailing: .space)

    // MARK: Types

    static let `typealias` = SyntaxFactory.makeTypealiasKeyword().with(trailing: .space)

    static let `struct` = SyntaxFactory.makeStructKeyword().with(trailing: .space)

    // MARK: Function

    static let function = SyntaxFactory.makeFuncKeyword().with(trailing: .space)

    /// `" -> "`
    static let arrow = SyntaxFactory.makeArrowToken().with(leading: .space, trailing: .space)

    // MARK: File

    /// `"import "`
    static let `import` = SyntaxFactory.makeImportKeyword().with(trailing: .space)

    static let eof = SyntaxFactory.makeToken(.eof, presence: .present)
}

// MARK: - Syntactic Sugars

extension TokenSyntax {
    func with(leading: Trivia? = nil, trailing: Trivia? = nil) -> Self {
        self
            .withLeadingTrivia(leadingTrivia.prepending(leading))
            .withTrailingTrivia(trailingTrivia.appending(trailing))
    }
}

extension Trivia {
    static var space: Trivia { .spaces(1) }
    static var newline: Trivia { .newlines(1) }

    func pieces() -> [TriviaPiece] {
        Array(makeIterator())
    }

    func appending(_ trivia: Trivia?) -> Trivia {
        Trivia(pieces: pieces() + (trivia?.pieces() ?? []))
    }

    func prepending(_ trivia: Trivia?) -> Trivia {
        Trivia(pieces: (trivia?.pieces() ?? []) + pieces())
    }
}
