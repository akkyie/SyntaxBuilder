import SwiftSyntax

public protocol ParameterListBuildable: SyntaxListBuildable {
    func buildParameterList(format: Format, leadingTrivia: Trivia?) -> [FunctionParameterSyntax]
}

extension ParameterListBuildable {
    public func buildSyntaxList(format: Format, leadingTrivia: Trivia?) -> [Syntax] {
        buildParameterList(format: format, leadingTrivia: leadingTrivia)
    }
}
