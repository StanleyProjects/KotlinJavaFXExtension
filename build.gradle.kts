import org.jetbrains.dokka.gradle.DokkaTask
import org.jetbrains.dokka.gradle.DokkaPlugin
import org.jetbrains.kotlin.gradle.plugin.KotlinPluginWrapper

buildscript {
    repositories.jcenter()
    dependencies(Dependency.kotlinGradlePlugin)
}

plugins {
    apply(Plugin.dokka, isWithVersion = true)
}

repositories.jcenter()

val kotlinLint: Configuration by configurations.creating

dependencies(
    kotlinLint.name to setOf(Dependency.kotlinLint)
)

val documentationPath = "${rootProject.buildDir}/documentation"
val documentationHtmlPath = "$documentationPath/html"
val reportsPath = "${rootProject.buildDir}/reports"
val analysisPath = "$reportsPath/analysis"
val analysisStylePath = "$analysisPath/style"
val analysisStyleHtmlPath = "$analysisStylePath/html/report.html"

task<JavaExec>("verifyCodeStyle") {
    classpath = kotlinLint
    main = "com.pinterest.ktlint.Main"
    args(
        "build.gradle.kts",
        "settings.gradle.kts",
        "buildSrc/src/main/kotlin/**/*.kt",
        "buildSrc/build.gradle.kts",
        "lib/src/main/kotlin/**/*.kt",
        "lib/build.gradle.kts",
        "sample/src/main/kotlin/**/*.kt",
        "sample/build.gradle.kts",
        "--reporter=html,output=$analysisStyleHtmlPath"
    )
}

task<DefaultTask>("verifyReadme") {
    doLast {
        val file = File(rootDir, "README.md")
        val text = file.requireFilledText()
        // todo
    }
}

task<DefaultTask>("verifyService") {
    doLast {
        val file = File(rootDir, "buildSrc/build.gradle.kts")
        val text = file.requireFilledText()
        // todo
    }
}

task<DefaultTask>("verifyLicense") {
    doLast {
        val file = File(rootDir, "LICENSE")
        val text = file.requireFilledText()
        // todo
    }
}

task<DefaultTask>("verifyAll") {
    dependsOn(setOf(
        "CodeStyle",
        "Readme",
        "Service",
        "License"
    ).map { "verify$it" })
}

task<Delete>("clean") {
    delete = setOf(rootProject.buildDir, "buildSrc/build")
}

allprojects {
    repositories.jcenter()
}

evaluationDependsOnChildren()

subprojects.filter {
    setOf(KotlinPluginWrapper::class, DokkaPlugin::class).all { plugin ->
        it.plugins.hasPlugin(plugin)
    }
}.forEach {
    it.task<DokkaTask>("collectDocumentation") {
        outputFormat = "html"
        outputDirectory = documentationHtmlPath
        configuration {
            moduleName = "KotlinJavaFXExtension " + it.name
        }
    }
}
