//: [Previous](@previous)

import PerfectMarkdown

let markdown = "# some blah blah blah markdown text \n\n## with mojo 🇨🇳 🇨🇦"

guard let html = markdown.markdownToHTML else {
    // conversion failed// 转换失败
}//end guard

print(html)

//: [Next](@next)
