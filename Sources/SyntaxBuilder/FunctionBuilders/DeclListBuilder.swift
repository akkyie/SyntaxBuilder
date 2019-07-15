import SwiftSyntax

@_functionBuilder
public struct DeclListBuilder {
    public static func buildBlock(_ builders: DeclListBuildable...) -> DeclListBuildable {
        DeclList(builders: builders)
    }
}
