import SwiftSyntax

public struct Struct: DeclBuildable {
    let name: String
    let memberList: MemberDeclListBuildable

    public init(_ name: String, @MemberDeclListBuilder buildMemberList: () -> MemberDeclListBuildable) {
        self.name = name
        self.memberList = buildMemberList()
    }

    public func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax {
        let members = memberList.buildMemberDeclList(
            format: format.indented(),
            leadingTrivia: format.indented().makeNewline()
        )

        return SyntaxFactory.makeStructDecl(
            attributes: nil,
            modifiers: nil,
            structKeyword: Tokens.struct.with(leading: leadingTrivia),
            identifier: SyntaxFactory.makeIdentifier(name),
            genericParameterClause: nil,
            inheritanceClause: nil,
            genericWhereClause: nil,
            members: SyntaxFactory.makeMemberDeclBlock(
                leftBrace: Tokens.brace.left.with(leading: .space),
                members: members,
                rightBrace: Tokens.brace.right.with(leading: format.makeNewline())
            )
        )
    }
}
