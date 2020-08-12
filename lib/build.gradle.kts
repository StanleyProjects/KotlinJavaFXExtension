version = Version.name + "-" + Version.code

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

val compileKotlin: org.jetbrains.kotlin.gradle.tasks.KotlinCompile by tasks

setOf(
    "release",
    "snapshot"
).forEach { type ->
    val buildName = Common.applicationId
    val versionName = when (type) {
        "Release" -> version.toString()
        else -> "$version-$type"
    }
    val taskName = "assemble" + type.capitalize()
    task<Jar>(taskName) {
        dependsOn(compileKotlin)
        archiveBaseName.set(buildName)
        archiveVersion.set(versionName)
        from(compileKotlin.destinationDir)
    }
    task<Jar>(taskName + "Source") {
        archiveBaseName.set(buildName)
        archiveVersion.set(versionName)
        archiveClassifier.set("sources")
        from(sourceSets["main"].allSource)
    }
    task(taskName + "Pom") {
        doLast {
            val parent = File(buildDir, "libs")
            if (!parent.exists()) parent.mkdirs()
            val file = File(parent, "$buildName-$versionName.pom")
            if (file.exists()) file.delete()
            file.createNewFile()
            check(file.exists()) { "File by path: ${file.absolutePath} must be exists!" }
            val text = MavenUtil.pom(
                modelVersion = "4.0.0",
                groupId = Bintray.organization + "." + Bintray.repository,
                artifactId = buildName,
                version = versionName,
                packaging = "jar"
            )
            file.writeText(text)
        }
    }
}
