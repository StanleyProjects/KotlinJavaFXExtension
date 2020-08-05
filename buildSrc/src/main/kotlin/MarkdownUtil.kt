object MarkdownUtil {
    fun image(
        text: String,
        url: String
    ): String {
        return "![$text]($url)"
    }
}
