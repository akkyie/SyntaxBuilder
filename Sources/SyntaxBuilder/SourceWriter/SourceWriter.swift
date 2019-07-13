import SwiftSyntax

public struct Format {
    public static var `default`: Format { Format() }

    public let indentWidth: Int

    var indents: Int = 0

    public init(indentWidth: Int = 4) {
        self.indentWidth = indentWidth
    }
}

extension Format {
    func indented() -> Format {
        var copy = self
        copy.indents += 1
        return copy
    }

    func makeNewline() -> Trivia {
        appendNewline(to: .zero)
    }

    func appendNewline(to trivia: Trivia, count: Int = 1) -> Trivia {
        trivia
            .appending(.newlines(count))
            .appending(.spaces(indents * indentWidth))
    }

    func appendComment(to trivia: Trivia, _ content: String, _ type: CommentType) -> Trivia {
        let makeLines = { (content: String) in content.split(separator: "\n", omittingEmptySubsequences: false) }
        var trivia = trivia
        switch type {
        case .raw:
            trivia = trivia.appending(.garbageText(content))
        case .line:
            trivia = makeLines(content).reduce(trivia) { trivia, line in
                appendNewline(to: trivia.appending(.lineComment("// " + line)))
            }
        case .docLine:
            trivia = makeLines(content).reduce(trivia) { trivia, line in
                appendNewline(to: trivia.appending(.lineComment("/// " + line)))
            }
        case .block:
            trivia = appendNewline(to: trivia.appending(.docBlockComment("/*")))
            trivia = makeLines(content).reduce(trivia) { trivia, line in
                appendNewline(to: trivia.appending(.lineComment(String(line))))
            }
            trivia = appendNewline(to: trivia.appending(.docBlockComment(" */")))
        case .docBlock:
            trivia = appendNewline(to: trivia.appending(.docBlockComment("/**")))
            trivia = makeLines(content).reduce(trivia) { trivia, line in
                appendNewline(to: trivia.appending(.lineComment(String(line))))
            }
            trivia = appendNewline(to: trivia.appending(.docBlockComment(" */")))
        }
        return trivia
    }
}

open class SourceWriter {
    let source: SourceFile
    let format: Format

    public init(source: SourceFile, format: Format = .default) {
        self.source = source
        self.format = format
    }

    open func write<Output: TextOutputStream>(to output: inout Output) {
        let syntax = source.buildSyntax(format: format, leadingTrivia: nil)
        syntax.write(to: &output)
    }
}
