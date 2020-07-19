data class Dependency(
    val group: String,
    val name: String,
    val version: String
) {
    companion object {
        val kotlinLint = Dependency(
            group = "com.pinterest",
            name = "ktlint",
            version = Version.kotlinLint
        )
    }
}

data class Plugin(
    val name: String,
    val version: String
) {
    companion object {
        val dokka = Plugin(
            name = "org.jetbrains.dokka",
            version = Version.dokka
        )

        val openjfx = Plugin(
            name = "org.openjfx.javafxplugin",
            version = Version.openjfx
        )
    }
}
