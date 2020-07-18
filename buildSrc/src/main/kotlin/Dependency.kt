private object Group {
    const val jetbrains = "org.jetbrains"
    const val kotlin = "$jetbrains.kotlin"
    const val pinterest = "com.pinterest"
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
            group = Group.pinterest,
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
        val kotlinJvm = Plugin(
            name = Group.kotlin + ".jvm",
            version = Version.kotlin
        )
    }
}
