import SwiftSyntax

public struct ParameterList {
    struct Parameter {
        let firstName: String
        let secondName: String
        let type: Type
    }

    public static let empty = ParameterList(parameters: [])

    let parameters: [Parameter]

    func buildParameterList(format: Format, leadingTrivia: Trivia?) -> [FunctionParameterSyntax] {
        parameters.enumerated().map { index, parameter in
            let isLast = index == parameters.endIndex - 1
            let firstIdentifier = SyntaxFactory.makeIdentifier(parameter.firstName)
            let secondIdentifier = SyntaxFactory.makeIdentifier(parameter.secondName)
            return SyntaxFactory.makeFunctionParameter(
                attributes: nil,
                firstName: firstIdentifier,
                secondName: secondIdentifier,
                colon: Tokens.colon,
                type: parameter.type.buildType(format: format, leadingTrivia: leadingTrivia),
                ellipsis: nil,
                defaultArgument: nil,
                trailingComma: !isLast ? Tokens.comma : nil
            )
        }
    }
}

extension ParameterList: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, Type)...) {
        self.init(parameters: elements.map { name, type in
            Parameter(firstName: "", secondName: name, type: type)
        })
    }
}
