plugins {
    application
    apply(Plugin.kotlinJvm)
    apply(Plugin.openjfx, isWithVersion = true)
}

application {
    mainClassName = Common.applicationId + ".App"
}

javafx {
    version = Version.javafx
    modules("javafx.controls")
}

dependencies(
    projects = mapOf(
        "implementation" to setOf(":lib")
    ),
    dependencies = mapOf(
        "implementation" to setOf(Dependency.kotlinStdlib)
    )
)
