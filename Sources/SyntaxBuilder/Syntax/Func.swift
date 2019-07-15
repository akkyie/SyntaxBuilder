import SwiftSyntax

public struct Func: DeclBuildable {
    let name: String
    let parameters: ParameterList
    let returnType: Type
    let body: SyntaxListBuildable

    public init(
        _ name: String,
        _ parameters: ParameterList = .empty,
        returns type: Type = .void,
        @SyntaxListBuilder body makeBody: () -> SyntaxListBuildable = { SyntaxList.empty }
    ) {
        self.name = name
        self.parameters = parameters
        self.returnType = type
        self.body = makeBody()
    }

    public func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax {
        let funcKeyword = Tokens.function.with(leading: leadingTrivia)

        let nameIdentifier = SyntaxFactory.makeIdentifier(name)

        let input = SyntaxFactory.makeParameterClause(
            leftParen: Tokens.paren.left,
            parameterList: SyntaxFactory.makeFunctionParameterList(
                parameters.buildParameterList(format: format, leadingTrivia: leadingTrivia)
            ),
            rightParen: Tokens.paren.right
        )

        let output = SyntaxFactory.makeReturnClause(
            arrow: Tokens.arrow,
            returnType: returnType.buildType(format: format, leadingTrivia: nil)
        )

        let signature = SyntaxFactory.makeFunctionSignature(
            input: input,
            throwsOrRethrowsKeyword: nil,
            output: output
        )


        let syntaxList = body.buildSyntaxList(
            format: format.indented(),
            leadingTrivia: format.indented().makeNewline()
        )

        let statements = SyntaxFactory.makeCodeBlockItemList(syntaxList.map {
            SyntaxFactory.makeCodeBlockItem(item: $0, semicolon: nil, errorTokens: nil)
        })

        return SyntaxFactory.makeFunctionDecl(
            attributes: nil,
            modifiers: nil,
            funcKeyword: funcKeyword,
            identifier: nameIdentifier,
            genericParameterClause: nil,
            signature: signature,
            genericWhereClause: nil,
            body: SyntaxFactory.makeCodeBlock(
                leftBrace: Tokens.brace.left,
                statements: statements,
                rightBrace: Tokens.brace.right.with(leading: format.makeNewline())
            )
        )
    }
}
