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
        Trivia.newlines(1).appending(.spaces(indents * indentWidth))
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
