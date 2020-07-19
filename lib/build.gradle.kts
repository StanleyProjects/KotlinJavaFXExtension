plugins {
    kotlin(module = "jvm")
    apply(Plugin.openjfx, isWithVersion = true)
    apply(Plugin.dokka)
}

javafx {
    version = "14"
    modules("javafx.controls")
}

dependencies(
    ConfigurationName.IMPLEMENTATION to setOf(Dependency.kotlinStdlib),
    ConfigurationName.TEST_IMPLEMENTATION to setOf(Dependency.jupiterApi),
    ConfigurationName.TEST_RUNTIME_ONLY to setOf(Dependency.jupiterEngine)
)

tasks.withType<Test> {
    useJUnitPlatform()
}
