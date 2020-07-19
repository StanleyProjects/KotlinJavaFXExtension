import org.jetbrains.dokka.gradle.DokkaTask
import org.jetbrains.dokka.gradle.DokkaPlugin
import org.jetbrains.kotlin.gradle.plugin.KotlinPluginWrapper

buildscript {
    repositories.jcenter()
    dependencies(Dependency.kotlinGradlePlugin)
}

plugins {
    apply(Plugin.dokka, isWithVersion = true)
    apply(Plugin.jacoco)
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

task<Delete>("clean") {
    delete = setOf(rootProject.buildDir, "buildSrc/build")
}

allprojects {
    repositories.jcenter()
}

evaluationDependsOnChildren()

val testCoverageReportPath = "${rootProject.buildDir}/report/test/coverage"

subprojects.filter {
    setOf(KotlinPluginWrapper::class, JacocoPlugin::class).all { plugin ->
        it.plugins.hasPlugin(plugin)
    }
}.forEach { project ->
    val collectTestCoverageReport = project.task<JacocoReport>("collectTestCoverageReport") {
        reports {
            xml.isEnabled = false // todo
//            xml.isEnabled = true
//            xml.destination = File("$testCoverageReportPath/${project.name}/xml/report.xml")
            html.isEnabled = true
            html.destination = File("$testCoverageReportPath/${project.name}/html")
            csv.isEnabled = false
        }
        executionData(project.tasks.getByName("test"))
        sourceSets(project.sourceSet("main"))
    }
//    project.task<DefaultTask>("verifyTestCoverage") {
//        dependsOn(
//            project.tasks.filterIsInstance<Test>(),
////            it.tasks.filterIsInstance<JacocoReport>(),
//            collectTestCoverageReport,
//            project.tasks.filterIsInstance<JacocoCoverageVerification>()
//        )
//    }
}

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

task<DefaultTask>("verifyAll") {
    dependsOn(setOf(
        "CodeStyle",
        "Readme",
        "Service",
        "License"
    ).map { "verify$it" })
}
