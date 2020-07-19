object Group {
    const val jetbrains = "org.jetbrains"
    const val kotlin = "$jetbrains.kotlin"
    const val jupiter = "org.junit.jupiter"
}

data class Dependency(
    val group: String,
    val name: String,
    val version: String
) {
    companion object {
        val kotlinGradlePlugin = Dependency(
            group = Group.kotlin,
            name = "kotlin-gradle-plugin",
            version = Version.kotlin
        )
        val kotlinStdlib = Dependency(
            group = Group.kotlin,
            name = "kotlin-stdlib",
            version = Version.kotlin
        )
        val kotlinLint = Dependency(
            group = "com.pinterest",
            name = "ktlint",
            version = Version.kotlinLint
        )
        val jupiterApi = Dependency(
            group = Group.jupiter,
            name = "junit-jupiter-api",
            version = Version.jupiter
        )
        val jupiterEngine = Dependency(
            group = Group.jupiter,
            name = "junit-jupiter-engine",
            version = Version.jupiter
        )
    }
}

data class Plugin(
    val name: String,
    val version: String
) {
    companion object {
        val dokka = Plugin(
            name = Group.jetbrains + ".dokka",
            version = Version.dokka
        )

        val kotlinJvm = Plugin(
            name = Group.kotlin + ".jvm",
            version = Version.kotlin
        )

        val openjfx = Plugin(
            name = "org.openjfx.javafxplugin",
            version = Version.openjfx
        )
    }
}
