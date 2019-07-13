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

    func makeNewline(count: Int = 1) -> Trivia {
        Trivia.newlines(count).appending(.spaces(indents * indentWidth))
    }

    func makeComment(_ content: String, _ type: CommentType) -> Trivia {
        let makeLines = { (content: String) in
            content.split(separator: "\n", omittingEmptySubsequences: false)
        }

        var trivias = [Trivia]()
        switch type {
        case .line:
            trivias = makeLines(content).map { line in
                Trivia.lineComment("// " + line)
            }

        case .docLine:
            trivias = makeLines(content).map { line in
                Trivia.lineComment("/// " + line)
            }

        case .block:
            trivias += [Trivia.docBlockComment("/*")]
            trivias += makeLines(content).map { line in
                Trivia.lineComment(String(line)).appending(makeNewline())
            }
            trivias += [Trivia.docBlockComment(" */")]

        case .docBlock:
            trivias += [Trivia.docBlockComment("/**")]
            trivias += makeLines(content).map { line in
                Trivia.lineComment(String(line)).appending(makeNewline())
            }
            trivias += [Trivia.docBlockComment(" */")]
        }

        return trivias.reduce(Trivia.zero) { trivia, next in
            trivia.appending(next).appending(makeNewline())
        }
    }
}
