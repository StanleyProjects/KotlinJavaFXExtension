plugins {
    applyAll(
        Plugin.kotlinJvm,
        Plugin.dokka,
        Plugin.jacoco
    )
    apply(Plugin.openjfx, isWithVersion = true)
}

jacoco {
    toolVersion = Version.jacoco
}

javafx {
    version = Version.javafx
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

/*tasks.withType<JacocoCoverageVerification> {
    violationRules {
        rule {
            limit {
                minimum = BigDecimal(1.0)
            }
        }
    }
}*/
