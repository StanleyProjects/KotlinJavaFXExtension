plugins {
    kotlin(module = "jvm")
    apply(Plugin.openjfx, isWithVersion = true)
    apply(Plugin.dokka)
}

javafx {
    version = "14"
    modules("javafx.controls")
}

dependencies {
    implementation(kotlin(module = "stdlib"))
}
