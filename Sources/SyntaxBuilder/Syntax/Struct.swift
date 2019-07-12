import SwiftSyntax

public struct Struct: SyntaxBuildable {
    let name: String
    let members: MemberDeclListBuildable

    public init(_ name: String, @MemberDeclListBuilder buildMembers: () -> MemberDeclListBuildable) {
        self.name = name
        self.members = buildMembers()
    }

    public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
        let keyword = SyntaxFactory.makeStructKeyword(
            leadingTrivia: leadingTrivia ?? .zero,
            trailingTrivia: .spaces(1)
        )

        let nameToken = SyntaxFactory
            .makeIdentifier(name)

        return SyntaxFactory.makeStructDecl(
            attributes: nil,
            modifiers: nil,
            structKeyword: keyword,
            identifier: nameToken,
            genericParameterClause: nil,
            inheritanceClause: nil,
            genericWhereClause: nil,
            members: SyntaxFactory.makeMemberDeclBlock(
                leftBrace: SyntaxFactory.makeLeftBraceToken().withLeadingTrivia(.spaces(1)),
                members: members.buildMemberDeclList(format: format, leadingTrivia: format.indented().makeNewline()),
                rightBrace: SyntaxFactory.makeRightBraceToken().withLeadingTrivia(format.makeNewline())
            )
        )
    }
}
