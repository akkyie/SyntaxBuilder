import SwiftSyntax

public struct Struct: DeclBuildable {
    let name: String
    let memberList: DeclListBuildable

    public init(_ name: String, @DeclListBuilder buildMemberList: () -> DeclListBuildable) {
        self.name = name
        self.memberList = buildMemberList()
    }

    public func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax {
        let declList = memberList.buildDeclList(
            format: format.indented(),
            leadingTrivia: format.indented().makeNewline()
        )

        let members = SyntaxFactory.makeMemberDeclList(
            declList.map { decl in
                SyntaxFactory.makeMemberDeclListItem(decl: decl, semicolon: nil)
            }
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
