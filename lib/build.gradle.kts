plugins {
    applyAll(
        Plugin.kotlinJvm,
        Plugin.dokka
    )
    apply(Plugin.openjfx, isWithVersion = true)
}

javafx {
    version = "14"
    modules("javafx.controls")
}

dependencies(
    "implementation" to setOf(Dependency.kotlinStdlib),
    "testImplementation" to setOf(Dependency.jupiterApi),
    "testRuntimeOnly" to setOf(Dependency.jupiterEngine)
)

tasks.withType<Test> {
    useJUnitPlatform()
}
