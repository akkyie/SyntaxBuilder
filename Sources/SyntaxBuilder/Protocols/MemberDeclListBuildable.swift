import SwiftSyntax

public protocol DeclBuildable: MemberDeclListBuildable {
    func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax
}

public protocol MemberDeclListBuildable {
    func buildMemberDeclList(format: Format, leadingTrivia: Trivia?) -> MemberDeclListSyntax
}

extension DeclBuildable {
    public func buildMemberDeclList(format: Format, leadingTrivia: Trivia?) -> MemberDeclListSyntax {
        let decl = buildDecl(format: format, leadingTrivia: leadingTrivia)
        return SyntaxFactory.makeMemberDeclList([
            SyntaxFactory.makeMemberDeclListItem(decl: decl, semicolon: nil)
        ])
    }
}

public struct MemberDeclList: MemberDeclListBuildable {
    let builders: [DeclBuildable]

    public func buildMemberDeclList(format: Format, leadingTrivia: Trivia?) -> MemberDeclListSyntax {
        let decls: [DeclSyntax] = builders.map { builder in
            builder.buildDecl(format: format, leadingTrivia: leadingTrivia)
        }
        return SyntaxFactory.makeMemberDeclList(
            decls.map { decl in
                SyntaxFactory.makeMemberDeclListItem(decl: decl, semicolon: nil)
            }
        )
    }
}
