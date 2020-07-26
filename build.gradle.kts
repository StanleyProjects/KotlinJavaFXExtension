import org.jetbrains.dokka.gradle.DokkaPlugin
import org.jetbrains.dokka.gradle.DokkaTask
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
        val lines = text.split(SystemUtil.newLine)
        val versionBadge = MarkdownUtil.image(
            text = "version",
            url = badgeUrl(
                label = "version",
                message = Version.name + "-" + Version.code,
                color = "2962ff"
            )
        )
        // todo bintray
        listOf(
            versionBadge
        ).forEach {
            check(lines.contains(it)) { "File by path ${file.absolutePath} must contains \"$it\" line!" }
        }
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
    setOf(KotlinPluginWrapper::class, JacocoPlugin::class).all(it.plugins::hasPlugin)
}.forEach { project ->
    val testTask = project.tasks.getByName("test")
    require(testTask is Test)
    val sourceSets = project.sourceSet("main")

    project.task<JacocoReport>("collectTestCoverageReport") {
        executionData(testTask)
        sourceSets(sourceSets)

        reports {
            xml.isEnabled = false // todo
//            xml.isEnabled = true
//            xml.destination = File("$testCoverageReportPath/${project.name}/xml/report.xml")
            html.isEnabled = true
            html.destination = File("$testCoverageReportPath/${project.name}/html")
            csv.isEnabled = false
        }
    }

    project.task<JacocoCoverageVerification>("verifyTestCoverage") {
        executionData(testTask)
        sourceSets(sourceSets)

        violationRules {
            rule {
                limit {
                    minimum = BigDecimal(1.0)
                }
            }
        }
    }
}

subprojects.filter {
    setOf(KotlinPluginWrapper::class, DokkaPlugin::class).all(it.plugins::hasPlugin)
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
