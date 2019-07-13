import SwiftSyntax

public enum CommentType {
    case raw
    case line
    case block
    case docLine
    case docBlock
}

public struct Commented<T: SyntaxBuildable> {
    let builder: T
    let type: CommentType
    let content: String
    let newlineCount: Int

    private func makeTrivia(format: Format, leadingTrivia: Trivia?) -> Trivia {
        var trivia = leadingTrivia ?? .zero
        trivia = format.appendNewline(to: trivia, count: newlineCount)
        trivia = format.appendComment(to: trivia, content, type)
        return trivia
    }
}

extension SyntaxBuildable {
    public func prependingComment(_ content: String, _ type: CommentType = .line, withNewlines count: Int = 1) -> Commented<Self> {
        return Commented(builder: self, type: type, content: content, newlineCount: count)
    }

    public func prependingNewlines(count: Int) -> Commented<Self> {
        prependingComment("", .raw, withNewlines: count)
    }
}

extension Commented: SyntaxBuildable where T: SyntaxBuildable {
    public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
        let leadingTrivia = makeTrivia(format: format, leadingTrivia: leadingTrivia)
        return builder.buildSyntax(format: format, leadingTrivia: leadingTrivia)
    }
}

extension Commented: MemberDeclListBuildable where T: MemberDeclListBuildable {
    public func buildMemberDeclList(format: Format, leadingTrivia: Trivia?) -> MemberDeclListSyntax {
        let leadingTrivia = makeTrivia(format: format, leadingTrivia: leadingTrivia)
        return builder.buildMemberDeclList(format: format, leadingTrivia: leadingTrivia)
    }
}

extension Commented: DeclBuildable where T: DeclBuildable {
    public func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax {
        let leadingTrivia = makeTrivia(format: format, leadingTrivia: leadingTrivia)
        return builder.buildDecl(format: format, leadingTrivia: leadingTrivia)
    }
}
