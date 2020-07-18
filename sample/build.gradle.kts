plugins {
    application
    kotlin(module = "jvm")
    apply(Plugin.openjfx, isWithVersion = true)
}

application {
    mainClassName = "stan.kjfex.sample.App"
}

javafx {
    version = "14"
    modules("javafx.controls")
}

dependencies {
    implementation(project(":lib"))

    implementation(kotlin(module = "stdlib"))
}
