import SwiftSyntax

public enum CommentType {
    case line
    case block
    case docLine
    case docBlock
}

public struct Commented<T: SyntaxBuildable> {
    let builder: T
    let type: CommentType
    let content: String?
    let newlineCount: Int

    private func makeTrivia(format: Format, leadingTrivia: Trivia?) -> Trivia {
        var trivia = (leadingTrivia ?? .zero).appending(format.makeNewline(count: newlineCount))

        if let content = content {
            trivia = trivia.appending(format.makeComment(content, type))
        }

        return trivia
    }
}

extension SyntaxBuildable {
    public func prependingComment(_ content: String, _ type: CommentType = .line, withNewlines count: Int = 1) -> Commented<Self> {
        Commented(builder: self, type: type, content: content, newlineCount: count)
    }

    public func prependingNewline(count: Int = 1) -> Commented<Self> {
        Commented(builder: self, type: .line, content: nil, newlineCount: count)
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
