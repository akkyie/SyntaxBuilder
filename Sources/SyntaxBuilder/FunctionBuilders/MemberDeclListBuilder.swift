import SwiftSyntax

@_functionBuilder
public struct MemberDeclListBuilder {
    public static func buildBlock(_ builders: DeclBuildable...) -> MemberDeclListBuildable {
        MemberDeclList(builders: builders)
    }
}
